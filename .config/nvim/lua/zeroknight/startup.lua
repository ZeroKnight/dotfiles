-- Startup Screen Configuration and Utilities

local ui = require 'zeroknight.config.ui'
local util = require 'zeroknight.util'
local icons = ui.icons

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
  local pre_info = v.prerelease and string.format(' %s (%s)', v.prerelease, v.build) or ''
  return string.format('v%d.%d.%d%s', v.major, v.minor, v.patch, pre_info)
end

local function python_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv ~= nil then
    return string.format('🐍 VirtualEnv: %s', vim.fn.fnamemodify(venv, ':t'))
  end
  return ''
end

---@type snacks.dashboard.Config
---@diagnostic disable-next-line: missing-fields
return {
  enabled = true,
  sections = {
    {
      gap = 1,
      padding = 2,
      function()
        local height = vim.api.nvim_win_get_height(0)
        if false and height >= 40 then -- NOTE: Disabled for now
          return { header = table.concat(logo, '\n') }
        else
          return { header = 'N E O V I M' }
        end
      end,
      { header = pretty_version() },
    },
    {
      gap = 1,
      {
        { icon = icons.common.find, key = 'f', desc = 'Find File', action = ':Telescope find_files' },
        { icon = ' ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
        { icon = icons.common.file_blank, key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ':Telescope live_grep' },
        {
          icon = ' ',
          key = 'c',
          desc = 'Config',
          action = util.telescope 'nvim_config',
        },
        { icon = ' ', key = 'm', desc = 'Man Pages', action = ':Telescope man_pages' },
        { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
        { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
        { icon = '󰣪 ', key = 'M', desc = 'Mason', action = ':Mason' },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
    {
      padding = { 1, 1 },
      { section = 'startup' },
      { footer = python_venv() },
    },
    {
      pane = 2,
      indent = 2,
      padding = 1,
      icon = icons.common.file,
      title = 'Recent Files',
      section = 'recent_files',
      cwd = true,
    },
    {
      pane = 2,
      indent = 2,
      padding = 1,
      icon = icons.common.folder_open,
      title = 'Projects',
      section = 'projects',
    },
    function()
      local root = Snacks.git.get_root()
      local in_repo = root ~= nil
      local sections = {
        {
          indent = 0,
          icon = ' ',
          desc = 'Browse Repository',
          key = 'b',
          action = Snacks.gitbrowse,
        },
        {
          icon = icons.git.branch,
          title = 'Git Status',
          section = 'terminal',
          height = 6,
          cmd = 'git --no-pager diff --stat -B -M -C',
        },
        {
          icon = ' ',
          title = 'Git Log',
          section = 'terminal',
          height = 5,
          cmd = "git --no-pager log --pretty=format:'%C(green)%h%C(reset) %s' HEAD~5..",
        },
        {
          icon = '󰪶 ',
          title = 'Git Stash',
          section = 'terminal',
          height = 5,
          cmd = "git --no-pager stash list --pretty=format:'%C(magenta)%gd%C(reset): %gs'",
          enabled = function() return in_repo and vim.fn.filereadable(vim.fs.joinpath(root, '.git/refs/stash')) == 1 end,
        },
      }
      return vim.tbl_map(
        function(section)
          return vim.tbl_extend('keep', section, {
            pane = 2,
            indent = 2,
            padding = 1,
            enabled = in_repo,
          })
        end,
        sections
      )
    end,
  },
}
