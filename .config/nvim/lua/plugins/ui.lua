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
    keys = {
      { 's', '<Plug>(leap)', desc = 'Leap', mode = { 'n', 'x', 'o' } },
      { 'S', '<Plug>(leap-from-window)', desc = 'Leap (Window)' },
      { 'R', function() require('leap.treesitter').select() end, desc = 'Leap (Treeistter)', mode = { 'x', 'o' } },
    },
    config = function()
      local leap = require 'leap'
      leap.opts.case_sensitive = false
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
      ---@module 'which-key'
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
        triggers = {
          -- BUG: Work around which-key#824 breaking v:count in visual mode
          { '<auto>', mode = 'nisotc' },
        },
      }
    end,
  },

  {
    'kshenoy/vim-signature',
    event = { 'BufReadPost', 'BufNewFile' },
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

      local function fg(name) return { fg = color.fg(name) } end

      local function has_file() return not vim.tbl_contains({ 'nofile', 'quickfix', 'help' }, vim.bo.buftype) end

      local function navic_available() return package.loaded['nvim-navic'] and require('nvim-navic').is_available() end

      local function empty(cond) return { '', draw_empty = true, cond = cond } end

      local function text(str)
        return function() return str end
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
            {
              '%w', -- [Preview]
              cond = function() return vim.wo.previewwindow end,
              color = fg 'Constant',
            },
          },
          lualine_x = {
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
              cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
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
              lualine_a = { text 'Help' },
              lualine_b = { { 'filename', file_status = false, path = 0, icon = icons.common.help } },
              lualine_x = { searchcount },
              lualine_z = { 'progress' },
            },
            inactive_sections = {
              lualine_a = { text 'Help' },
              lualine_b = { { 'filename', file_status = false, path = 0, icon = icons.common.help } },
              lualine_x = {},
              lualine_z = { 'progress' },
            },
            filetypes = { 'help' },
          },
          {
            sections = {
              lualine_a = { text 'Fugitive' },
              lualine_b = {
                {
                  function() return vim.fn.FugitiveHead() end,
                  icon = icons.git.branch,
                },
              },
              lualine_c = {
                {
                  function() return vim.fn.fnamemodify(vim.fn.FugitiveGitDir(), ':~') end,
                  icon = icons.git.dir,
                },
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
              lualine_a = { text 'Symbols' },
              lualine_z = { 'progress' },
            },
            filetypes = { 'Outline' },
          },
          {
            sections = {
              lualine_a = { text 'UndoTree' },
              lualine_z = { 'progress' },
            },
            filetypes = { 'undotree' },
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
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = {
        '*',
        css = { css = true },
        html = { names = true },
      },
      user_default_options = {
        mode = 'background',
        names = false,
      },
    },
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim', lazy = true },
    },
    opts = { ---@type NoiceConfig
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
          enabled = true,
        },
        override = {
          -- Overrides various markdown renderers to use Treesitter instead
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = { ---@type NoiceRouteConfig[]
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
              { event = 'lsp', kind = 'progress', find = 'file symbols' },
              { event = 'lsp', kind = 'progress', find = 'semantic tokens' },
              {
                event = 'lsp',
                kind = 'progress',
                find = 'Diagnosing',
                ['not'] = { find = 'Diagnosing workspace' },
              },
            },
          },
          opts = { skip = true },
        },
        {
          -- Filter trace messages from telescope-lazy-plugins
          filter = {
            event = 'notify',
            find = "Can't find '[^']*' from line %d+ inside the '[^']*' file. Use checkhealth for details.",
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
    keys = {
      {
        '<C-f>',
        function()
          if not require('noice.lsp').scroll(4) then
            return '<C-f>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll forward',
        mode = { 'i', 'n', 's' },
      },
      {
        '<C-b>',
        function()
          if not require('noice.lsp').scroll(-4) then
            return '<C-b>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll backward',
        mode = { 'i', 'n', 's' },
      },
    },
  },

  {
    'ThePrimeagen/harpoon',
    keys = function()
      local keymaps = {
        { '<Leader>H', function() require('harpoon.ui').toggle_quick_menu() end, 'Harpoon Menu' },
        { ']n', function() require('harpoon.ui').nav_next() end, desc = 'Next Harpooned file' },
        { '[n', function() require('harpoon.ui').nav_prev() end, desc = 'Previous Harpooned file' },
      }
      for i = 0, 9 do
        table.insert(keymaps, {
          string.format('<M-%d>', i),
          function() require('harpoon.ui').nav_file(i) end,
          'Harpoon file ' .. i,
        })
      end
      return keymaps
    end,
    cmd = 'Harpoon',
    config = function()
      require('harpoon').setup()
      require('plugins.telescope.ext').add_extension 'harpoon'
      vim.api.nvim_create_user_command(
        'Harpoon',
        function() require('harpoon.mark').add_file() end,
        { desc = 'Harpoon current file' }
      )
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
          callback = function() require('nvim-lightbulb').update_lightbulb() end,
        })
      end)
    end,
  },

  {
    'folke/trouble.nvim',
    version = '*',
    dependencies = { 'echasnovski/mini.icons' },
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
    'aznhe21/actions-preview.nvim',
    lazy = true,
    opts = function()
      return {
        highlight_command = { require('actions-preview.highlight').delta() },
        ---@type telescope.picker.opts
        telescope = {
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            prompt_position = 'top',
            preview_height = 0.75,
          },
        },
      }
    end,
  },

  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    -- NOTE: Dropbar highlights will be wrong on initial load until it is
    -- refreshed (e.g. BufEnter) regardless of being lazy-loaded or not. This
    -- seems to be a Dropbar bug.
    config = function(_, opts) require('dropbar.configs').set(opts) end,
    opts = {
      bar = {
        sources = function(buffer, _)
          local sources = require 'dropbar.sources'
          local utils = require 'dropbar.utils'
          if vim.bo[buffer].ft == 'markdown' then
            return {
              sources.path,
              sources.markdown,
            }
          end
          if vim.bo[buffer].buftype == 'terminal' then
            return {
              sources.terminal,
            }
          end
          return {
            utils.source.fallback {
              sources.lsp,
              sources.treesitter,
            },
          }
        end,
      },
      icons = {
        kinds = {
          dir_icon = ui.icons.common.folder,
          file_icon = ui.icons.common.file,
          symbols = vim.tbl_extend('error', ui.icons.kinds, {
            Identifier = ui.icons.kinds.Variable,
            List = ui.icons.kinds.Array,
            Pair = ui.icons.kinds.Array,
            Scope = ui.icons.kinds.Namespace,
            Statement = ui.icons.kinds.Keyword,
          }),
        },
        ui = {
          bar = { separator = string.format(' %s ', ui.icons.separators.left.b) },
        },
      },
    },
  },

  {
    'petertriho/nvim-scrollbar',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      show_in_active_only = true,
      handle = {
        blend = 30,
        highlight = 'PmenuThumb',
      },
    },
  },
}
