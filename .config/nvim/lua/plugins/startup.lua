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

-- Taken mostly from alpha dashboard theme
local function button(sc, text, map, map_opts)
  local opts = {
    position = 'center',
    shortcut = sc,
    align_shortcut = 'right',
    cursor = 3,
    width = 40,
    hl = 'String',
    hl_shortcut = 'Constant',
  }
  sc = sc:gsub('%s', ''):gsub('LDR', '<Leader>')
  if map then
    map_opts = vim.tbl_extend('keep', map_opts or {}, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', sc, map, map_opts }
  end

  return {
    type = 'button',
    val = text,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(map or sc .. '<Ignore>', true, false, true)
      vim.api.nvim_feedkeys(key, 't', false)
    end,
    opts = opts,
  }
end

return {
  {
    'goolord/alpha-nvim',
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

      return {
        layout = {
          { type = 'padding', val = 2 },
          sections.header,
          { type = 'padding', val = 2 },
          sections.buttons,
          { type = 'padding', val = 2 },
          sections.footer,
        },
        opts = { margin = 5 },
      }
    end,
    config = function(_, opts)
      require('alpha').setup(opts)

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
