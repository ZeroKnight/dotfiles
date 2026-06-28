-- Utilities for working with the System Theme (e.g. light/dark)

local last_theme_change = 0

local M = {
  theme_preference_map = { [0] = vim.NIL, [1] = 'dark', [2] = 'light' },
}

local handle_theme_change = vim.schedule_wrap(function(pref, time)
  local new_bg = M.theme_preference_map[pref]
  if vim.o.background == new_bg then
    return
  end
  -- On theme change, the color-scheme setting changes 3 times for some
  -- reason, so we'll debounce by a couple of seconds in lieu of that.
  if time > last_theme_change + 2 then
    last_theme_change = time
    vim.notify(
      string.format("Setting background to '%s'", new_bg),
      vim.log.levels.INFO,
      { title = 'System theme changed' }
    )
    vim.opt.background = new_bg
  end
end)

-- Whether we can query the system theme or not. Relies on dbus userspace tools.
---@return boolean
function M.can_sync() return vim.fn.executable 'dbus-monitor' == 1 and vim.fn.executable 'dbus-send' == 1 end

-- Spawn a dbus-monitor process that listens for system theme changes and
-- updates the 'background' option accordingly.
---@return integer? pid pid of dbus-monitor process or `nil` if it could not be spawned
function M.spawn_theme_monitor()
  if vim.fn.executable 'dbus-monitor' == 0 then
    vim.notify(
      'dbus-monitor is unavailable, cannot sync with system theme',
      vim.log.levels.ERROR,
      { title = 'System theme' }
    )
    return
  end

  local stdout, err_pipe = vim.uv.new_pipe()
  assert(stdout, err_pipe)
  local handle, pid = vim.uv.spawn('dbus-monitor', { ---@diagnostic disable-line missing-fields
    args = {
      '--session',
      table.concat({
        'type=signal',
        'interface=org.freedesktop.portal.Settings',
        'member=SettingChanged',
        'arg0=org.freedesktop.appearance',
        'arg1=color-scheme',
      }, ','),
    },
    stdio = { nil, stdout, nil },
  }, function()
    stdout:read_stop()
    stdout:close()
  end)
  assert(handle, pid)

  vim.uv.read_start(stdout, function(err, data)
    assert(not err, err)
    if not data then
      return
    end

    -- XXX: Kind of ugly, but libuv doesn't always give us the same number of
    -- lines per handler invocation. Also, the actual signal we care about may
    -- not even be the first one we see!
    local lines = vim.split(data, '\n')
    local i = 1
    while i <= #lines do
      if vim.startswith(lines[i], 'signal') then
        if lines[i]:match 'member=SettingChanged' then
          if lines[i + 2] and lines[i + 2]:match '^%s+string%s+"color%-scheme"$' then
            local time = tonumber(lines[i]:match '^signal time=(%d+)')
            local pref = tonumber(lines[i + 3]:match '^%s+variant%s+uint32%s+(%d)$')
            if pref ~= nil then
              handle_theme_change(pref, time)
            end
          end
        end
      end
      i = i + 1
    end
  end)

  vim.api.nvim_create_autocmd('VimLeavePre', {
    desc = 'Close uv process handle for system theme dbus-monitor',
    callback = function()
      handle:kill 'sigterm'
      handle:close()
    end,
  })

  ---@cast pid integer
  return pid
end

-- Get the current system theme. Expressed like the 'background' option.
---@return 'light'|'dark'|vim.NIL theme
function M.current()
  if vim.fn.executable 'dbus-send' == 0 then
    vim.notify('dbus-send is unavailable, cannot query system theme', vim.log.levels.ERROR, { title = 'System theme' })
    return vim.NIL
  end
  local result = vim
    .system({
      'dbus-send',
      '--session',
      '--dest=org.freedesktop.portal.Desktop',
      '--type=method_call',
      '--print-reply=literal',
      '/org/freedesktop/portal/desktop',
      'org.freedesktop.portal.Settings.Read',
      'string:org.freedesktop.appearance',
      'string:color-scheme',
    }, { text = true })
    :wait()
  local pref = vim.split(result.stdout, '%s+', { trimempty = true })[4]
  return M.theme_preference_map[tonumber(pref)]
end

return M
