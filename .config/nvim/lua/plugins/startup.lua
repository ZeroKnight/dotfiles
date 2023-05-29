-- Startup Screen Configuration

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

vim.g.startup_bookmarks = {
  I = as_stdpath('config', 'init.lua'),
  L = as_stdpath('config', 'lua/plugins/lsp/init.lua'),
  L = as_stdpath('config', 'lua/plugins/lsp/servers/init.lua'),
}

local sections = {
  { 'header', 1 },
  { 'version', 0 },
  { 'bookmarks', 2 },
  { 'actions', 1 },
  { 'footer', 1 },
}

return {
  {
    'startup-nvim/startup.nvim',
    enabled = false, -- TODO: convert packer status to lazy
    opts = {
      header = {
        type = 'text',
        align = 'center',
        content = logo,
        highlight = 'Statement',
      },
      version = {
        type = 'text',
        align = 'center',
        content = pretty_version,
        highlight = 'Constant',
      },
      actions = {
        type = 'mapping',
        align = 'center',
        content = {
          { '  New File', "lua require'startup'.new_file()", '<C-n>' },
          { '  Find File', 'Telescope find_files' },
          { '  Find Git File', 'Telescope git_files' },
          { '  File Browser', 'Telescope file_browser' },
          { '  Recent Files', 'Telescope oldfiles' },
          { '  Live Grep', 'Telescope live_grep' },
        },
        highlight = 'String',
      },
      bookmarks = {
        type = 'text',
        align = 'center',
        fold_section = true,
        title = 'Bookmarks',
        content = function()
          local bookmarks = { '' }
          for key, file in pairs(vim.g.startup_bookmarks) do
            table.insert(bookmarks, string.format('[%s] %s', key, file))
          end
          return bookmarks
        end,
        highlight = 'String',
      },
      footer = {
        type = 'text',
        align = 'center',
        content = function()
          return {
            table.concat({
              string.format('🔌 %d Plugins', vim.tbl_count(packer_plugins)),
              python_venv(),
            }, '  '),
          }
        end,
        highlight = 'Operator',
      },
      options = {
        mapping_keys = true,
        disable_statuslines = true,
        paddings = vim.tbl_map(function(x)
          return x[2]
        end, sections),
        after = function()
          local bookmarks = {}
          for key, file in pairs(vim.g.startup_bookmarks) do
            bookmarks[key] = string.format('<Cmd>e %s<CR>', file)
          end
          startup.create_mappings(vim.tbl_extend('error', {
            q = '<Cmd>qa<CR>',
          }, bookmarks))
          vim.opt_local.colorcolumn = ''
        end,
      },
      mappings = {
        open_file_split = '<C-s>',
      },
      parts = vim.tbl_map(function(x)
        return x[1]
      end, sections),
    },
  },
}
