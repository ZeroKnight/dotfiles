-- User Interface plugins
--
-- Additions, enhancements, and replacements for the user interface. Typically
-- adds new windows, signs, or other visual tools.

local ui = require 'zeroknight.config.ui'
local util = require 'zeroknight.util'

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

---@type LazySpec
return {
  {
    'ggandor/leap.nvim',
    lazy = false,
    config = function()
      local leap = require 'leap'
      leap.add_default_mappings()
      leap.opts.highlight_unlabeled_phase_one_targets = true
    end,
  },

  {
    'chrisbra/Recover.vim',
    event = 'SwapExists',
  },

  {
    'folke/which-key.nvim',
    lazy = true,
    priority = 100,
    opts = function()
      ---@type wk.Opts
      return {
        plugins = {
          spelling = {
            enabled = true,
            suggestions = 30,
          },
        },
        show_help = false,
        icons = {
          breadcrumb = require('zeroknight.config.ui').icons.separators.breadcrumb,
          separator = '➜ ',
          group = '󰍻  ',
        },
        win = {
          border = require('zeroknight.config.ui').borders,
        },
      }
    end,
  },

  {
    'kshenoy/vim-signature',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<Leader>ti', '<Cmd>IBLToggle<CR>', desc = 'Toggle indent guides' },
    },
    opts = {
      enabled = true,
      indent = {
        char = '│',
        smart_indent_cap = true,
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          'lazy',
          'lspinfo',
          'checkhealth',
          'help',
          'man',
          'gitcommit',
          'TelescopePrompt',
          'TelescopeResults',
          'text',
          'markdown',
          '',
        },
        buftypes = {
          'terminal',
          'nofile',
          'quickfix',
          'prompt',
        },
      },
    },
  },

  {
    'mbbill/undotree',
    cmd = { 'UndotreeFocus', 'UndotreeHide', 'UndotreeShow', 'UndotreeToggle' },
    keys = { { '<F5>', '<Cmd>UndotreeToggle<CR>', desc = 'Toggle Undo Tree', mode = { 'n', 'i' } } },
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      local icons = ui.icons
      local color = require 'zeroknight.util.color'

      local function fg(name)
        return { fg = color.fg(name) }
      end

      local function has_file()
        return not vim.tbl_contains({ 'nofile', 'quickfix', 'help' }, vim.bo.buftype)
      end

      local function navic_available()
        return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
      end

      local function empty(cond)
        return { '', draw_empty = true, cond = cond }
      end

      local location = {
        'location',
        icon_enabled = true,
        icon = { icons.common.linenr, align = 'right' },
      }

      local selectioncount = {
        'selectioncount',
        icon_enabled = true,
        icon = ' ',
      }

      local searchcount = {
        'searchcount',
        icon_enabled = true,
        icon = icons.common.find,
        color = fg 'DiagnosticVirtualTextInfo',
      }

      return {
        options = {
          section_separators = { left = icons.separators.left.a, right = icons.separators.right.a },
          component_separators = { left = icons.separators.left.b, right = icons.separators.right.b },
          disabled_filetypes = { statusline = { 'alpha' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'branch', icon = icons.git.branch },
            {
              'diff',
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              update_in_insert = vim.diagnostic.config().update_in_insert,
            },
          },
          lualine_c = {
            -- { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { 'filename', path = 1 },
            -- stylua: ignore
            {
              '%w', -- [Preview]
              cond = function() return vim.wo.previewwindow end,
              color = fg 'Constant',
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return vim.bo.spelllang end,
              cond = function() return vim.wo.spell end,
              icon = ' ',
              color = fg 'PreProc',
            },
            {
              function()
                local register, _ = require('noice').api.status.mode.get()
                return string.format('🔴 %s', register:sub(11))
              end,
              cond = function()
                return package.loaded['noice'] and require('noice').api.status.mode.has()
              end,
              color = fg 'Constant',
            },
            searchcount,
          },
          lualine_y = {
            { 'filetype', cond = has_file },
            { 'encoding', separator = '' },
            { 'fileformat', padding = { left = 0, right = 1 }, cond = has_file },
          },
          lualine_z = { selectioncount, 'progress', location },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = {},
          lualine_y = { { 'filetype', cond = has_file } },
          lualine_z = { 'progress', location },
        },
        extensions = {
          'man',
          'quickfix',
          'lazy',
          'trouble',
          {
            sections = {
              -- stylua: ignore
              lualine_a = { function() return 'Help' end },
              lualine_b = { { 'filename', file_status = false, path = 0, icon = icons.common.help } },
              lualine_x = { searchcount },
              lualine_z = { 'progress' },
            },
            inactive_sections = {
              -- stylua: ignore
              lualine_a = { function() return 'Help' end },
              lualine_b = { { 'filename', file_status = false, path = 0, icon = icons.common.help } },
              lualine_x = {},
              lualine_z = { 'progress' },
            },
            filetypes = { 'help' },
          },
          {
            -- stylua: ignore
            sections = {
              lualine_a = { function() return 'Fugitive' end },
              lualine_b = { { function() return vim.fn.FugitiveHead() end, icon = icons.git.branch } },
              lualine_c = {
                {
                  function() return vim.fn.fnamemodify(vim.fn.FugitiveGitDir(), ':~') end,
                  icon = icons.git.dir,
                }
              },
              lualine_y = {
                {
                  function() return 'Git ' .. vim.fn.FugitiveGitVersion() end,
                  icon = icons.git.logo,
                },
              },
              lualine_z = { 'progress' },
            },
            filetypes = { 'fugitive' },
          },
          {
            sections = {
              -- stylua: ignore
              lualine_a = { function() return 'Symbols' end },
              lualine_z = { 'progress' },
            },
            filetypes = { 'Outline' },
          },
          {
            sections = {
              -- stylua: ignore
              lualine_a = { function() return 'UndoTree' end },
              lualine_z = { 'progress' },
            },
            filetypes = { 'undotree' },
          },
        },
        winbar = {
          lualine_a = { empty(navic_available) },
          lualine_b = { empty(navic_available) },
          lualine_c = {
            {
              -- stylua: ignore
              function() return require('nvim-navic').get_location() end,
              cond = navic_available,
            },
          },
        },
        tabline = {
          lualine_a = {
            {
              'windows',
              show_filename_only = false,
              max_length = vim.o.columns * (2 / 3),
              filetype_names = {
                lazy = 'Lazy',
                mason = 'Mason',
              },
            },
          },
          lualine_z = {
            {
              'tabs',
              mode = 1,
              fmt = function(name, context)
                if vim.fn.tabpagenr() == context.tabnr then
                  return context.tabnr
                end
                return string.format('%d %s', context.tabnr, name)
              end,
            },
          },
        },
      }
    end,
  },

  {
    'folke/zen-mode.nvim',
    dependencies = { 'folke/twilight.nvim' },
    cmd = 'ZenMode',
    opts = {
      window = {
        backdrop = 0.9,
        width = function()
          return vim.bo.textwidth + 4
        end,
        options = {
          cursorline = true,
          number = true,
          relativenumber = true,
          list = false,
          signcolumn = 'no',
          foldcolumn = '0',
        },
      },
      plugins = {
        kitty = {
          enabled = true,
          font = '+4',
        },
      },
    },
  },

  {
    'folke/twilight.nvim',
    lazy = true,
    cmd = 'Twilight',
    opts = {
      dimming = {
        alpha = 0.25,
        inactive = false,
      },
    },
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {
      filetypes = {
        '*',
        css = { css = true },
        html = { names = true },
      },
      defaults = {
        mode = 'background',
        names = false,
      },
    },
    config = function(_, opts)
      require('colorizer').setup(opts.filetypes, opts.defaults)
    end,
  },

  {
    'stevearc/dressing.nvim',
    lazy = true,
    opts = function()
      return {
        input = { -- vim.ui.input
          enabled = false, -- using noice
          border = ui.borders,
        },
        select = { -- vim.ui.select
          enabled = true,
          nui = { border = { style = ui.borders } },
          builtin = { border = ui.borders },
          format_item_override = {
            codeaction = function(action_tuple)
              -- Show language server per action
              local title = action_tuple[2].title:gsub('\r\n', '\\r\\n')
              local client = vim.lsp.get_client_by_id(action_tuple[1])
              return string.format('%s\t[%s]', title:gsub('\n', '\\n'), client.name)
            end,
          },
          get_config = function(opts)
            if opts.kind == 'codeaction' then
              return {
                telescope = require('telescope.themes').get_cursor(),
              }
            end
          end,
        },
      }
    end,
    init = function(plugin)
      -- Lazy load when vim.ui.* is called. Tweaked from LazyVim.
      if util.plugin_opts(plugin).input.enabled then
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require('lazy').load { plugins = { 'dressing.nvim' } }
          return vim.ui.input(...)
        end
      end
      if util.plugin_opts(plugin).select.enabled then
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require('lazy').load { plugins = { 'dressing.nvim' } }
          return vim.ui.select(...)
        end
      end
    end,
  },

  {
    'rcarriga/nvim-notify',
    opts = function()
      return {
        icons = require('zeroknight.config.ui').icons.logging,
        timeout = 5000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      }
    end,
    config = function(_, opts)
      local notify = require 'notify'
      vim.notify = notify
      notify.setup(opts)
      require('plugins.telescope.ext').add_extension 'notify'
    end,
    keys = {
      {
        '<Leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss notifications',
      },
    },
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-notify',
      { 'MunifTanjim/nui.nvim', lazy = true },
    },
    opts = {
      presets = {
        bottom_search = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      cmdline = {
        enabled = true,
        view = 'cmdline_popup',
      },
      lsp = {
        progress = {
          enabled = true,
        },
        signature = {
          enabled = false,
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          -- Show "recording @x" in a mini view
          filter = { event = 'msg_showmode' },
          view = 'mini',
        },
        {
          -- Send short messages to mini view
          filter = {
            any = {
              { event = 'msg_show', kind = '', find = 'written' },
              { event = 'msg_show', kind = '', find = 'appended' },
              { event = 'msg_show', find = 'line less' },
              { event = 'msg_show', find = 'more line' },
              { event = 'msg_show', find = 'fewer line' },
              { event = 'msg_show', kind = 'wmsg', find = 'search hit TOP' },
              { event = 'msg_show', kind = 'wmsg', find = 'search hit BOTTOM' },
            },
          },
          view = 'mini',
          opts = { timeout = 3000 },
        },
        {
          -- Skip various messages caused by buffer changes
          filter = {
            any = {
              { event = 'msg_show', kind = '', find = 'lines >ed' },
              { event = 'msg_show', kind = '', find = 'lines <ed' },
            },
          },
          opts = { skip = true },
        },
        {
          -- Don't show annoying null-ls/lua_ls progress messages
          filter = {
            any = {
              { event = 'lsp', kind = 'progress', find = 'code_action' },
              { event = 'lsp', kind = 'progress', find = 'diagnostics' },
              { event = 'lsp', kind = 'progress', find = 'lint:' },
              { event = 'lsp', kind = 'progress', find = 'Diagnosing', ['not'] = { find = 'Diagnosing workspace' } },
            },
          },
          opts = { skip = true },
        },
        {
          -- Send huge messages/notifications to a split
          filter = {
            any = {
              { event = { 'notify', 'msg_show' }, min_height = 10 },
              { event = { 'notify', 'msg_show' }, min_width = 80 },
            },
          },
          view = 'split',
        },
      },
    },
    -- stylua: ignore
    keys = {
      { '<C-f>', function() if not require('noice.lsp').scroll(4) then return '<C-f>' end end, silent = true, expr = true, desc = 'Scroll forward', mode = { 'i', 'n', 's' } },
      { '<C-b>', function() if not require('noice.lsp').scroll(-4) then return '<C-b>' end end, silent = true, expr = true, desc = 'Scroll backward', mode = { 'i', 'n', 's' } },
    },
  },

  {
    'ThePrimeagen/harpoon',
    keys = function()
    -- stylua: ignore
      local keymaps = {
        {'<Leader>H', function() require('harpoon.ui').toggle_quick_menu() end, 'Harpoon Menu'},
        {']H', function() require('harpoon.ui').nav_next() end, 'Next Harpooned file'},
        {'[H', function() require('harpoon.ui').nav_prev() end, 'Previous Harpooned file'},
      }
      for i = 0, 9 do
        table.insert(keymaps, {
          string.format('<M-%d>', i),
          function()
            require('harpoon.ui').nav_file(i)
          end,
          'Harpoon file ' .. i,
        })
      end
      return keymaps
    end,
    cmd = 'Harpoon',
    config = function()
      require('harpoon').setup()
      require('plugins.telescope.ext').add_extension 'harpoon'
      vim.api.nvim_create_user_command('Harpoon', function()
        require('harpoon.mark').add_file()
      end, { desc = 'Harpoon current file' })
    end,
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = { 'BufReadPost', 'BufNewFile' },
    -- stylua: ignore
    keys = {
      { 'zR', function() require('ufo').openFoldsExceptKinds() end, desc = 'Open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    },
    opts = {
      close_fold_kinds_for_ft = { default = { 'imports' } },
      open_fold_hl_timeout = ui.highlight.indicator_duration,
      preview = {
        win_config = {
          border = ui.borders,
          maxheight = 15,
        },
      },
      provider_selector = function()
        -- Use TS instead of LSP. It should give the same results much faster.
        return { 'treesitter', 'indent' }
      end,
    },
    init = function()
      vim.o.foldlevel = 99 -- ufo is designed to work with a high foldlevel
      vim.o.foldlevelstart = 99
    end,
  },

  -- LSP-Related UI

  {
    'kosayoda/nvim-lightbulb',
    lazy = true,
    opts = {
      ignore = {},
    },
    init = function()
      util.on_attach(function(_, buffer)
        autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = buffer,
          group = augroup('ZeroKnight.lsp.lightbulb.' .. buffer, { clear = true }),
          desc = 'Show lightbulb sign when code actions exist',
          callback = function()
            require('nvim-lightbulb').update_lightbulb()
          end,
        })
      end)
    end,
  },

  {
    'ray-x/lsp_signature.nvim',
    lazy = true,
    opts = {
      hint_prefix = '🐍 ', -- Signature Snake :)
      hint_scheme = 'Special',
      noice = true,
      handler_opts = { border = require('zeroknight.config.ui').borders },
      select_signature_key = '<M-o>', -- "O" for "Overload"
    },
    init = function(plugin)
      util.on_attach(function(_, buffer)
        require('lsp_signature').on_attach(plugin.opts, buffer)
      end, 'LSP Signature Handler')
    end,
    config = false,
  },

  {
    'folke/trouble.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    opts = {
      focus = true,
      icons = { kinds = ui.icons.kinds },
    },
    keys = {
      { '<Leader>xx', '<Cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics (Trouble)' },
      { '<Leader>xX', '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<Leader>xq', '<Cmd>Trouble qflist toggle<CR>', desc = 'Toggle Quickfix List (Trouble)' },
      { '<Leader>xl', '<Cmd>Trouble loclist toggle<CR>', desc = 'Toggle Location List (Trouble)' },
      { '<Leader>xt', '<Cmd>Trouble todo toggle<CR>', desc = 'Show Todo (Trouble)' },
      { '<F4>', '<Cmd>Trouble symbols toggle<CR>', desc = 'Show Document Symbols (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').prev { jump = true }
          else
            pcall(vim.cmd.cprev)
          end
        end,
        desc = 'Previous Trouble/Quickfix item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next { jump = true }
          else
            pcall(vim.cmd.cnext)
          end
        end,
        desc = 'Next Trouble/Quickfix item',
      },
      {
        '[Q',
        function()
          if require('trouble').is_open() then
            require('trouble').first { jump = true }
          else
            pcall(vim.cmd.cfirst)
          end
        end,
        desc = 'First Trouble/Quickfix item',
      },
      {
        ']Q',
        function()
          if require('trouble').is_open() then
            require('trouble').last { jump = true }
          else
            pcall(vim.cmd.clast)
          end
        end,
        desc = 'Last Trouble/Quickfix item',
      },
    },
  },

  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
    init = function()
      vim.g.code_action_menu_window_border = require('zeroknight.config.ui').borders
    end,
  },

  {
    'SmiteshP/nvim-navic',
    lazy = true,
    init = function()
      util.on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
        end
      end, 'Navic LSP symbol context')
    end,
    opts = function()
      return {
        separator = string.format(' %s ', ui.icons.separators.breadcrumb),
        icons = vim.tbl_map(function(x)
          return x .. ' '
        end, ui.icons.kinds),
        highlight = true,
        safe_output = true,
        click = true,
      }
    end,
  },
}
