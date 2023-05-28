-- User Interface plugins
--
-- Additions, enhancements, and replacements for the user interface. Typically
-- adds new windows, signs, or other visual tools.

local util = require 'zeroknight.util'

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

return {
  {
    'chrisbra/Recover.vim',
    enabled = false, -- TODO: Test interaction with Noice
    event = 'BufReadPre',
  },

  {
    'folke/which-key.nvim',
    lazy = true,
    priority = 100,
    opts = {
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 30,
        },
      },
      show_help = false,
      icons = {
        group = '  ',
      },
      window = {
        border = require('zeroknight.config.ui').borders,
      },
    },
  },

  {
    'kshenoy/vim-signature',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<Leader>ti', '<Cmd>IndentBlanklineToggle<CR>', 'Toggle indent guides' },
    },
    opts = {
      enabled = true,
      disable_with_nolist = true,
      char = '│',
      char_blankline = '┊',
      show_first_indent_level = false,
      show_end_of_line = true,
      show_trailing_blankline_indent = false,

      -- NOTE: Turn this stuff on later when TS indent improves
      use_treesitter = false,
      -- show_current_context = true,

      filetype_exclude = {
        'lazy',
        'lspinfo',
        'checkhealth',
        'help',
        'man',
        'text',
        'markdown',
        '',
      },

      buftype_exclude = {
        'terminal',
        'nofile',
        'quickfix',
        'prompt',
      },
    },
  },

  {
    'mbbill/undotree',
    cmd = { 'UndotreeFocus', 'UndotreeHide', 'UndotreeShow', 'UndotreeToggle' },
    keys = { { '<F5>', '<Cmd>UndotreeToggle<CR>', desc = 'Toggle Undo Tree', mode = { 'n', 'i' } } },
  },

  {
    'itchyny/lightline.vim',
    init = function()
      vim.g.lightline = {
        colorscheme = vim.g.colors_name,
        separator = { left = '', right = '' },
        subseparator = { left = '', right = '' },
        active = {
          left = {
            { 'Mode', 'paste' },
            { 'GitHunks', 'GitBranch' },
            { 'diagnostics', 'filename', 'ReadOnly', 'preview' },
          },
          right = {
            { 'lineinfo' },
            { 'FileInfo' },
            { 'CurrSymbol', 'FileType' },
            { 'ShowMode', 'spell' },
          },
        },
        inactive = {
          left = {
            { 'help', 'symbols' },
            {},
            { 'filename', 'quickfix' },
          },
          right = {
            { 'lineinfo' },
            { 'FileInfo' },
            { 'FileType' },
          },
        },
        tabline = {
          left = { { 'tabs' } },
          right = { {}, { 'buffers' } },
        },
        component = {
          filename = '%<%{zeroknight#lightline#file_name()}',
          lineinfo = '%3l:%-2c [%p%%] ',
          preview = '%w',
          quickfix = '%q',
          help = "%{&buftype ==# 'help' ? 'Help' : ''}",
          symbols = "%{&filetype ==# 'Outline' ? 'Symbols' : ''}",
          diagnostics = '%{%zeroknight#lightline#diagnostics()%}%*',
        },
        component_visible_condition = {
          filename = 1,
          preview = '&previewwindow',
          quickfix = "&buftype ==# 'quickfix'",
          help = "&buftype ==# 'help'",
          symbols = "&filetype ==# 'Outline'",
          diagnostics = 'zeroknight#diagnostic#available()',
        },
        component_function = {
          Mode = 'zeroknight#lightline#mode',
          FileInfo = 'zeroknight#lightline#file_info',
          FileType = 'zeroknight#lightline#file_type',
          ReadOnly = 'zeroknight#lightline#readonly',
          GitBranch = 'zeroknight#lightline#git_branch',
          GitHunks = 'zeroknight#lightline#git_hunks',
          CurrSymbol = 'zeroknight#lightline#current_symbol',
          ShowMode = 'zeroknight#lightline#noice_showmode',
        },
        component_function_visible_condition = {
          Mode = 1,
          FileInfo = 1,
          FileType = "&buftype !=# 'nofile'",
          ReadOnly = "&readonly && &buftype ==# ''",
          GitBranch = "zeroknight#lightline#has_minwidth() && !empty(get(b:, 'gitsigns_head', ''))",
          GitHunks = "zeroknight#lightline#has_minwidth() && !empty(get(b:, 'gitsigns_status', ''))",
          CurrSymbol = '!empty(zeroknight#lightline#current_symbol())',
          ShowMode = 'luaeval("require(\'noice\').api.status.mode.has()")',
        },
        component_expand = {
          buffers = 'lightline#bufferline#buffers',
        },
        component_type = {
          buffers = 'tabsel',
        },
      }
    end,
    dependencies = {
      'mengelbrecht/lightline-bufferline',
      init = function()
        local function set(var, val)
          vim.g['lightline#bufferline#' .. var] = val
        end
        set('right_aligned', 1)
        set('filter_by_tabpage', 1)
        vim.opt.showtabline = 2
      end,
    },
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
    opts = {
      input = { -- vim.ui.input
        enabled = false, -- using noice
      },
      select = { -- vim.ui.select
        enabled = true,
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
    },
    init = function(plugin)
      -- Lazy load when vim.ui.* is called. Tweaked from LazyVim.
      if vim.tbl_get(plugin.opts, 'input', 'enabled') then
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require('lazy').load { plugins = 'dressing.nvim' }
          return vim.ui.input(...)
        end
      end
      if vim.tbl_get(plugin.opts, 'select', 'enabled') then
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require('lazy').load { plugins = 'dressing.nvim' }
          return vim.ui.select(...)
        end
      end
    end,
  },

  {
    'rcarriga/nvim-notify',
    opts = function()
      local diag_icons = {}
      for severity, icon in pairs(require('zeroknight.config.ui').icons.diagnostics) do
        diag_icons[string.upper(severity)] = icon
      end
      return {
        icons = diag_icons,
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
    config = function(_, opts)
      require('nvim-lightbulb').setup(opts)
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
    config = function(_, opts)
      util.on_attach(function(_, buffer)
        require('lsp_signature').on_attach(opts, buffer)
      end, 'LSP Signature Handler')
    end,
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

      local symbols = {}
      for kind, hl in pairs(symbol_hl) do
        symbols[kind] = { icon = ui.icons.kinds[kind], hl = hl }
      end

      return {
        autofold_depth = 3,
        auto_preview = true,
        highlight_hovered_item = false,
        width = 20,

        fold_markers = { ui.icons.folds.closed, ui.icons.folds.open },
        symbols = symbols,

        keymaps = {
          hover_symbol = 'K',
          toggle_preview = 'p',
          fold_all = 'zm',
          unfold_all = 'zr',
        },
      }
    end,
  },
}
