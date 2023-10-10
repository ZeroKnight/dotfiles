-- User Interface plugins
--
-- Additions, enhancements, and replacements for the user interface. Typically
-- adds new windows, signs, or other visual tools.

local util = require 'zeroknight.util'

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

return {
  {
    'ggandor/leap.nvim',
    lazy = false,
    config = function(_, opts)
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
          group = '  ',
        },
        window = {
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
    config = function(_, opts)
      require('ibl').setup(opts)
      require('which-key').register({ -- Fill in missing descriptions
        d = 'Delete fold under cursor',
        D = 'Delete all folds under cursor',
        E = 'Eliminate all folds in window',
        F = 'Fold n lines',
        n = 'Disable folding',
        N = 'Enable folding',
        X = 'Update folds (without zv)',
      }, { prefix = 'z' })
    end,
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
      local ui = require 'zeroknight.config.ui'
      local icons = ui.icons
      local color = require 'zeroknight.util.color'

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
              '%w',
              cond = function() return vim.wo.previewwindow end,
              color = color.fg 'Constant',
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return vim.bo.spelllang end,
              cond = function() return vim.wo.spell end,
              icon = '﬜',
              color = 'Define',
            },
            {
              function()
                local register, _ = require('noice').api.status.mode.get()
                return string.format('🔴 %s', register:sub(11))
              end,
              cond = function()
                return package.loaded['noice'] and require('noice').api.status.mode.has()
              end,
              color = color.fg 'Constant',
            },
            'searchcount',
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
                  icon = ' ',
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
      local ui = require 'zeroknight.config.ui'
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
    init = function()
      -- Lazy load when vim.ui.* is called. Tweaked from LazyVim.
      local orig_input = vim.ui.input
      local orig_select = vim.ui.select

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return orig_input(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return orig_select(...)
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

      -- Match existing diagnostic colors
      local Color = require('colorbuddy.color').Color
      local ui = require 'zeroknight.config.ui'

      for _, severity in ipairs { 'Error', 'Warn', 'Info' } do
        local diag_name = string.format('Diagnostic%s', severity)
        local col = Color.new(diag_name, ui.colors.diagnostics[severity]):saturate(0.2):dark(0.25):to_rgb()

        util.cmdf([[hi! link Notify%sTitle %s]], string.upper(severity), diag_name)
        util.cmdf([[hi! link Notify%sIcon %s]], string.upper(severity), diag_name)
        util.cmdf([[hi! Notify%sBorder guifg=%s]], string.upper(severity), col)
      end
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
    opts = function()
      local ui = require 'zeroknight.config.ui'
      return {
        action_keys = {
          close = { 'q', 'gq' }, -- Other plugins use gq for closing
          open_split = { '<C-s>' },
        },
        group = true,
        fold_open = ui.icons.folds.open,
        fold_closed = ui.icons.folds.closed,
        use_diagnostic_signs = true,
      }
    end,
    keys = {
      { '<Leader>xx', '<Cmd>TroubleToggle<CR>', desc = 'Toggle Trouble window' },
      { '<Leader>xw', '<Cmd>Trouble workspace_diagnostics<CR>', desc = 'Show workspace diagnostics (Trouble)' },
      { '<Leader>xd', '<Cmd>Trouble document_diagnostics<CR>', desc = 'Show document diagnostics (Trouble)' },
      { '<Leader>xq', '<Cmd>Trouble quickfix<CR>', desc = 'Show quickfix list (Trouble)' },
      { '<Leader>xl', '<Cmd>Trouble loclist<CR>', desc = 'Show location list (Trouble)' },
      { '<Leader>xt', '<Cmd>TodoTrouble<CR>', desc = 'Show Todo (Trouble)' },
      { '<Leader>xT', '<Cmd>TodoTelescope<CR>', desc = 'Show Todo (Telescope)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous { skip_groups = true, jump = true }
          else
            pcall(vim.cmd.cprev)
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next { skip_groups = true, jump = true }
          else
            pcall(vim.cmd.cnext)
          end
        end,
        desc = 'Next trouble/quickfix item',
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
    'simrat39/symbols-outline.nvim',
    cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' },
    keys = {
      { '<F4>', '<Esc><Cmd>SymbolsOutline<CR>', desc = 'Toggle Symbols Outline', mode = { 'n', 'i' } },
    },
    opts = function()
      local ui = require 'zeroknight.config.ui'
      local symbol_hl = {
        Array = '@constant',
        Boolean = '@boolean',
        Class = '@type',
        Constant = '@constant',
        Constructor = '@constructor',
        Enum = '@type',
        EnumMember = '@field',
        Event = '@type',
        Field = '@field',
        File = '@text.uri',
        Function = '@function',
        Interface = '@type',
        Key = '@type',
        Method = '@method',
        Module = '@namespace',
        Namespace = '@namespace',
        Null = '@type',
        Number = '@number',
        Object = '@type',
        Operator = '@operator',
        Package = '@namespace',
        Property = '@method',
        String = '@string',
        Struct = '@type',
        TypeParameter = '@parameter',
        Variable = '@constant',
      }

      return {
        autofold_depth = 3,
        auto_preview = true,
        highlight_hovered_item = false,
        width = 20,

        fold_markers = { ui.icons.folds.closed, ui.icons.folds.open },
        symbols = vim.iter(symbol_hl):fold({}, function(t, kind, hl)
          t[kind] = { icon = ui.icons.kinds[kind], hl = hl }
          return t
        end),

        keymaps = {
          hover_symbol = 'K',
          toggle_preview = 'p',
          fold_all = 'zm',
          unfold_all = 'zr',
        },
      }
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
      local ui = require 'zeroknight.config.ui'
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
}
