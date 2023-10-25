-- Startup Screen Configuration

local format = string.format

local logo = {
  '⠙⣏⠩⠉⠍⠹⣇⠀⢸⡋⠩⠉⠍⢹⡇⣠⠞⠉⠍⠩⠉⠍⠩⠉⠍⡉⠻⣤⠀⣠⠞⡉⠍⠩⠉⠍⠩⠉⠍⡉⠻⢦⢨⡏⢉⠍⠩⠉⣯⠀⠀⡯⠉⠍⠩⢙⣗⡏⠩⠉⠍⡉⣟⢻⡍⠩⠉⠍⠹⣆⠀⠀⠀⣼⠉⠍⠩⢉⢹⡏',
  '⠀⡗⠠⢁⠊⠄⢻⡄⢸⡃⠨⠈⠌⢸⣟⡇⠠⠡⠁⠅⡁⠅⠡⠁⠅⠄⠡⢸⣟⡇⢐⠠⠨⠈⠌⡈⠌⠨⠐⠠⠡⢸⣗⡇⢐⠈⠄⠅⡷⠀⠀⡯⠈⠌⠨⢐⣗⡇⠡⢁⠡⠀⣿⢸⡇⠈⠌⠨⠠⠹⡆⠀⣸⢃⠨⢈⠨⢀⢸ ',
  '⠀⡯⠐⡐⢈⠐⡈⢷⢸⡅⠌⠨⠐⢸⣯⡇⠨⠠⠑⢰⠶⠦⢧⡊⠄⠡⠡⢸⣗⡇⢐⠠⠡⢨⡶⠲⢦⡅⠡⠁⠌⢰⣗⡇⠂⠌⠄⡁⣟⠀⠀⡯⠠⠁⠅⢰⡗⡇⡁⡂⠌⠄⣿⢸⡇⠨⠈⠄⠅⢂⢻⣰⠏⡀⢂⢂⢐⠐⢸ ',
  '⠀⡧⢁⢐⠠⢁⠐⡘⣿⠆⠨⠈⠌⢸⣗⡇⠠⠡⠨⢸⡇⠀⢸⣆⣨⣠⣡⣸⣗⡇⢐⠠⢁⢸⡇⠀⢸⠇⡈⠌⣈⣨⣗⣇⡨⠠⠡⠀⣯⠀⠀⡯⠠⠁⠅⠢⡯⡇⡐⠠⠨⠀⣿⢸⡇⠈⠌⡠⢁⠂⠄⠟⡀⡂⢂⢐⠠⢈⢸ ',
  '⠀⡏⠄⢂⠐⠄⠡⠠⢹⡃⡁⠅⠌⢸⣯⡇⠨⠠⢁⠸⠶⠴⢴⠀⠀⠀⠀⠀⢸⡇⠐⡐⢐⢸⡇⠀⢸⠧⠒⠉⠈⠰⣗⡇⠈⠉⠒⠥⣗⠀⠀⡯⠠⠁⠅⡘⡯⡇⠄⠅⠌⠄⣿⢸⡇⠨⠐⡀⡂⠌⠄⠡⠐⡀⠢⠐⡐⠐⢸ ',
  '⠀⡯⠐⡐⠈⠌⠨⠐⠠⢁⢐⢈⢐⢸⡷⡇⠨⠐⡐⠈⠄⡂⢽⠀⠀⠀⠀⠀⢸⣇⡰⠔⠒⢺⡇⠀⢸⡃⠀⠀⠀⢘⣗⡇⠀⠀⠀⠀⣯⠀⠀⡟⠒⠥⠥⣨⡯⡇⠌⠄⠅⠂⣿⢸⡇⠨⠐⡀⡂⠌⠄⠅⡁⢂⢁⠂⡂⠡⢸ ',
  '⠀⡧⠁⠄⠅⠡⠨⠈⠌⡀⡂⡐⠠⢸⣟⡇⠠⠡⠠⢁⣁⢄⣻⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⢸⡇⠀⢸⡅⠀⠀⠀⢨⣗⡇⠀⠀⠀⠀⡷⠀⠀⡧⠀⠀⠀⠐⡯⡏⠒⠦⢅⢅⣿⢸⡇⠠⢁⠢⡐⠈⠄⠡⢐⠐⡀⡂⢂⠡⢸ ',
  '⠀⡏⠄⠅⠌⢨⡂⠡⢁⢐⢀⠂⠡⢸⡷⡇⠨⣀⡥⢼⡋⠉⢉⣠⣠⣠⣠⣠⡸⡇⠀⠀⠀⢸⡇⠀⢸⠆⠀⠀⠀⠰⣗⡇⠀⠀⠀⠀⣟⠀⠀⣇⠀⠀⠀⢈⡯⡇⠀⠀⠀⠀⣿⢸⡗⠬⢤⣈⣧⠁⠅⡁⡂⠂⡂⡐⢐⠐⢸ ',
  '⠀⡯⠀⠅⠌⢸⣧⠈⠄⢂⠐⣈⡌⢼⣯⡗⠉⠀⠀⢸⡃⠀⢸⡂⠀⠀⠀⢸⢯⡇⠀⠀⠀⢸⡇⠀⢸⡃⠀⠀⠀⢘⣗⡇⠀⠀⠀⠀⣯⠀⢀⡇⠀⠀⠀⠐⡯⡇⠀⠀⠀⠀⣿⢸⡇⠀⠀⠀⣿⡗⠱⠰⢄⡅⣲⠐⢐⠈⢸ ',
  '⠀⡧⠁⠅⠌⣸⡻⡦⠕⠊⠉⠀⠀⢸⡷⡇⠀⠀⠀⠀⠙⢦⣼⠂⠀⠀⠀⢸⡯⡇⠀⠀⠀⠀⠙⢦⣼⠅⠀⠀⠀⢨⣗⡇⠀⠀⠀⠀⣷⡴⠋⠁⠀⠀⠀⠨⡯⡇⠀⠀⠀⠀⣿⢸⡇⠀⠀ ⡇⢷⠀⠀⠀⢨⣿⠑⠒⠬⣸ ',
  '⠀⡷⠊⠊⠉⢸⡃⢷⠀⠀⠀⠀⠀⢸⡟⣇⡀⠀⠀⠀⠀⠀⠈⠁⠀⠀⣠⡴⠛⣇⡀⠀⠀⠀⠀⠀⠈⠁⠀⠀⣠⡴⠓⠧⣄⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⣨⢗⡇⠀⠀⠀⠀⣿⢸⠇⠀⠀⠀⡇⠸⡇⠀⢠⡏⣿⠀⠀⠀⢸ ',
  '⠀⡇⠀⠀⠀⢸⠇⠘⣇⠀⠀⢀⡴⠞⠁⠀⠙⢦⣄⠀⠀⠀⠀⣠⡴⠛⠁⠀⠀⠀⠙⠦⣄⠀⠀⠀⠀⣀⡴⠞⠁⠀⠀⠀⠈⠛⢦⣄⠀⠀⠀⠀⣀⡴⠛⠁⠀⠙⠲⣄⡀⠀⣿⠈⠳⢦⡀ ⡇⠀⢻⡀⡾⠀⣿⠀⠀⠀⢸ ',
  '⠀⡇⠀⠀⠀⢸⡇⠀⢹⣤⠞⠋⠀⠀⠀⠀⠀⠀⠈⠳⢦⡴⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢦⡤⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢦⣤⠞⠉⠀⠀⠀⠀⠀⠀⠈⠙⠶⣯⠀⠀⠀⠉⠳⡇⠀⠈⣿⠁⠀⣿⠀⠀⠀⢸ ',
  '⠀⡇⠀⠀⠀⠸⣇⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⣿⠀⠀⠀⢸ ',
  '⠀⡇⠀⣀⣴⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣟⡀⠀⠀⢸ ',
  '⢰⣧⠾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢦⣄⠸⣇',
  '⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿',
}

local function pretty_version()
  local v = vim.version()
  return { string.format('v%d.%d.%d%s', v.major, v.minor, v.patch, v.prerelease and ' dev' or '') }
end

local function python_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv ~= nil then
    return string.format('🐍 VirtualEnv: %s', vim.fn.fnamemodify(venv, ':t'))
  end
  return ''
end

-- Taken mostly from alpha dashboard theme with some modifications
-- NOTE: Essentially, both on_press and opts.keymap are needed. The latter covers invoking an action via its actual
-- keymap, and on_press covers pressing <CR> on the button.
local function button(shortcut, text, rhs, map_opts)
  local on_press = nil
  local opts = {
    position = 'center',
    shortcut = shortcut,
    align_shortcut = 'right',
    cursor = 3,
    width = 40,
    hl = 'String',
    hl_shortcut = 'Constant',
  }
  shortcut = shortcut:gsub('%s', ''):gsub('LDR', '<Leader>')
  if rhs then
    map_opts = vim.tbl_extend('keep', map_opts or {}, { noremap = true, silent = true, nowait = true })
    if type(rhs) == 'function' then
      on_press = rhs
    end
    opts.keymap = { 'n', shortcut, rhs, map_opts }
  end

  on_press = on_press
    or function()
      local key = vim.api.nvim_replace_termcodes(shortcut .. '<Ignore>', true, false, true)
      vim.api.nvim_feedkeys(key, 't', false)
    end

  return {
    type = 'button',
    val = text,
    on_press = on_press,
    opts = opts,
  }
end

return {
  {
    'ZeroKnight/alpha-nvim',
    branch = 'fix-button-map',
    event = 'VimEnter',
    opts = function()
      local sections = {
        header = {
          type = 'group',
          val = {
            { type = 'text', val = logo, opts = { hl = 'Statement' } },
            { type = 'text', val = pretty_version, opts = { hl = 'Keyword' } },
          },
          opts = {
            spacing = 0,
            inherit = { position = 'center' },
          },
        },

        buttons = {
          type = 'group',
          val = {
            button('e', '  New File', '<Cmd>enew<CR>'),
            button('LDR f o', '  Recent Files'),
            button('LDR f f', '  Find File'),
            button('LDR F', '  File Browser'),
            button('LDR LDR p', '  Projects'),
            button('LDR s g', '  Live Grep'),
            button('LDR h m', '  Man Pages'),
            button('s', '💾 Restore Last Session', function()
              print 'Loading session'
              require('persistence').load { last = true }
            end),
            button('c', '  Neovim Config', format('<Cmd>e %s/init.lua<CR>', vim.fn.stdpath 'config')),
            button('l', '󰒲  Lazy', '<Cmd>Lazy<CR>'),
            button('m', '🔨 Mason', '<Cmd>Mason<CR>'),
          },
          opts = { spacing = 1 },
        },

        footer = {
          type = 'text',
          val = function()
            local stats = require('lazy').stats()
            local components = vim.tbl_filter(function(x)
              return x and #x > 0
            end, {
              format('🔌 %d of %d Plugins', stats.loaded, stats.count),
              format('⚡ Loaded in %dms', (math.floor(stats.startuptime * 100 + 0.5) / 100)),
              python_venv(),
            })
            return format('  %s  ', table.concat(components, '  '))
          end,
          opts = { position = 'center', hl = 'Operator' },
        },
      }

      local pad2 = { type = 'padding', val = 2 }
      return {
        layout = {
          pad2,
          sections.header,
          pad2,
          sections.buttons,
          pad2,
          sections.footer,
        },
        opts = { margin = 5 },
      }
    end,
    config = function(_, opts)
      require('alpha').setup(opts)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'alpha',
        callback = function(event)
          vim.keymap.set('n', 'q', '<Cmd>quit<CR>', { buffer = event.buf, noremap = true, nowait = true })
        end,
      })

      -- Redraw once Lazy stats are available
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
