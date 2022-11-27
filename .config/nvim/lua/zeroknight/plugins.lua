-- Plugin Specification

--# selene: allow(multiple_statements)

-- selene: allow(global_usage)
function _G.packer_loaded(name)
  return packer_plugins[name] and packer_plugins[name].loaded
end

local function tele_extension(name)
  return string.format([[require('telescope').load_extension('%s')]], name)
end

local function config(name)
  return string.format([[require('plugin.%s')]], name)
end

return require('packer').startup {
  function(use)
    -- Let Packer keep itself up to date
    use 'wbthomason/packer.nvim'

    -- UI Plugins {{{1
    use 'mhinz/vim-startify'
    use 'kshenoy/vim-signature'
    use 'wesQ3/vim-windowswap'
    use 'chrisbra/Recover.vim'
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = config 'indentline',
    }
    use {
      'mbbill/undotree',
      cmd = { 'UndotreeFocus', 'UndotreeHide', 'UndotreeShow', 'UndotreeToggle' },
    }

    use {
      'itchyny/lightline.vim',
      setup = config 'lightline',
    }
    use {
      'mengelbrecht/lightline-bufferline',
      requires = 'itchyny/lightline.vim',
      setup = function()
        local function set(var, val)
          vim.g['lightline#bufferline#' .. var] = val
        end
        set('right_aligned', 1)
        set('filter_by_tabpage', 1)
        vim.opt.showtabline = 2
      end,
    }

    use {
      {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
        config = config 'telescope',
      },
      -- Extensions
      { 'nvim-telescope/telescope-file-browser.nvim', config = tele_extension 'file_browser' },
      { 'nvim-telescope/telescope-fzy-native.nvim', config = tele_extension 'fzy_native' },
      { 'nvim-telescope/telescope-github.nvim', config = tele_extension 'gh' },
      { 'benfowler/telescope-luasnip.nvim', config = tele_extension 'luasnip' },
      { 'nvim-telescope/telescope-packer.nvim', config = tele_extension 'packer' },
      { 'nvim-telescope/telescope-z.nvim', config = tele_extension 'z' },
    }

    use {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup { default = true }
      end,
    }

    use {
      'folke/zen-mode.nvim',
      cmd = 'ZenMode',
      config = function()
        require('zen-mode').setup {
          window = {
            backdrop = 0.9,
            width = vim.o.textwidth + 4,
            height = vim.api.nvim_win_get_height(0) - 1,
            options = {
              cursorline = true,
              number = true,
              relativenumber = true,
              signcolumn = 'no',
              foldcolumn = '0',
            },
          },
        }
      end,
    }
    use {
      'folke/twilight.nvim',
      config = function()
        require('twilight').setup {
          dimming = {
            alpha = 0.25,
            inactive = false,
          },
        }
      end,
    }

    use {
      'folke/which-key.nvim',
      config = config 'which-key',
    }

    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup({
          '*',
          css = { css = true },
          html = { names = true },
        }, {
          -- Defaults
          mode = 'background',
          names = false,
        })
      end,
    }

    use {
      'stevearc/dressing.nvim',
      config = config 'dressing',
    }

    use {
      'rcarriga/nvim-notify',
      config = config 'notify',
    }

    -- Language Server Protocol (LSP) {{{1
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'
    use 'ray-x/lsp_signature.nvim'

    use {
      'kosayoda/nvim-lightbulb',
      config = function()
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          desc = 'Show lightbulb sign when code actions exist',
          callback = function(_)
            require('nvim-lightbulb').update_lightbulb()
          end,
        })
      end,
    }

    use {
      'folke/lsp-trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = config 'trouble',
    }

    use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }

    use {
      'simrat39/symbols-outline.nvim',
      setup = config 'symbols-outline',
      cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose' },
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }

    -- Analysis, Linting, and Debugging {{{1
    use { 'mhinz/vim-grepper', cmd = 'Grepper' }
    use 'romainl/vim-qlist'

    -- Debug Adapter Protocol (DAP)
    use 'mfussenegger/nvim-dap'
    use 'jbyuki/one-small-step-for-vimkind'

    -- Completion {{{1
    use {
      {
        'hrsh7th/nvim-cmp',
        config = config 'completion',
      },
      -- Sources
      -- TODO: Dadbod completion
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-cmdline' },
      { 'petertriho/cmp-git', config = [[require('cmp_git').setup()]] },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
    }

    -- Editing {{{1
    use { -- TODO: experiment with this and find good use cases
      'chrisbra/NrrwRgn',
      cmd = {
        'NR',
        'NW',
        'NRV',
        'NUD',
        'NRP',
        'NRL',
        'NarrowRegion',
        'NarrowWindow',
        'NRPrepare',
      },
    }
    use 'christoomey/vim-sort-motion'
    use 'godlygeek/tabular'
    use { 'reedes/vim-wordy', cmd = 'Wordy' }
    use 'tpope/vim-abolish'
    use 'wellle/targets.vim' -- TODO: practice

    use {
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup {
          highlight = {
            duration = 0,
          },
          move_cursor = false,
        }
      end,
    }

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
    }

    use {
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = config 'todo-comments',
    }

    use {
      'unblevable/quick-scope',
      setup = [[vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}]],
    }

    use {
      'L3MON4D3/LuaSnip',
      config = config 'luasnip',
    }

    use {
      'windwp/nvim-autopairs',
      before = 'nvim-cmp',
      config = config 'autopairs',
    }

    use {
      'ThePrimeagen/refactoring.nvim',
      after = { 'telescope.nvim', 'nvim-treesitter' },
      requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
      config = config 'refactoring',
    }

    -- Git Integration {{{1
    use {
      { 'tpope/vim-fugitive' },
      { 'tpope/vim-rhubarb', requires = 'tpope/vim-fugitive' },
    }
    use 'rhysd/committia.vim'
    use {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = config 'gitsigns',
    }

    -- Utility Plugins {{{1
    use '~/Projects/vim-signjump'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-projectionist' -- TODO: Try this out
    use 'tpope/vim-scriptease'
    use 'tpope/vim-unimpaired'
    use { 'Konfekt/FastFold', config = [[vim.g.fastfold_skip_filetypes = {'gitcommit', 'taglist'}]] }
    use { 'moll/vim-bbye', cmd = { 'Bdelete', 'Bwipeout' } }
    use { 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'FocusDispatch', 'Start' } }
    use { 'tpope/vim-obsession', cmd = 'Obsession' }
    use { 'dstein64/vim-startuptime', cmd = 'StartupTime' }
    use { 'bfredl/nvim-luadev', cmd = 'Luadev' }

    use {
      'tpope/vim-characterize',
      keys = 'ga',
      config = function()
        -- Explicitly set map or Which-Key will interfere with lazy load
        vim.api.nvim_set_keymap('n', 'ga', '<Plug>(characterize)', {})
      end,
    }

    -- Language Support {{{1
    use {
      'nvim-treesitter/nvim-treesitter',
      config = config 'treesitter',
      run = ':TSUpdate',
      -- WTF: Treesitter sometimes causes a segfault on startup from packer_compiled when not deferred
      event = 'VimEnter',
    }
    use { 'euclidianAce/BetterLua.vim', ft = 'lua' }
    use { 'cespare/vim-toml', ft = 'toml' }
    use { 'withgod/vim-sourcepawn', ft = 'sourcepawn' }
    use { 'mitsuhiko/vim-jinja', ft = { 'html', 'jinja' } }
    use { 'mattn/emmet-vim', ft = { 'html', 'xhtml', 'xml', 'jinja' } }
    -- TODO: revisit this after trying an HTML language server
    use { 'Valloric/MatchTagAlways', disable = true, ft = { 'html', 'xhtml', 'xml', 'jinja' } }

    -- Color Schemes {{{1
    use { 'rakr/vim-one', cmd = 'colorscheme one' }
    use { 'ciaranm/inkpot', cmd = 'colorscheme inkpot' }
    use { 'tomasr/molokai', cmd = 'colorscheme molokai' }
    use { 'romainl/Apprentice', cmd = 'colorscheme apprentice' }
    use { 'arcticicestudio/nord-vim', cmd = 'colorscheme nord' }
    use { 'tyrannicaltoucan/vim-quantum', cmd = 'colorscheme quantum' }
    use { 'tyrannicaltoucan/vim-deep-space', cmd = 'colorscheme deep-space' }
    use { 'mhartington/oceanic-next', cmd = 'colorscheme OceanicNext' }
    use { 'dracula/vim', cmd = 'colorscheme dracula', as = 'vim-dracula' }
    use { 'drewtempelmeyer/palenight.vim', cmd = 'colorscheme palenight' }
    use { 'folke/tokyonight.nvim' }

    -- Libraries & Misc {{{1
    use 'tpope/vim-repeat'
    use 'nanotee/nvim-lua-guide'
    use 'nanotee/luv-vimdocs'
    use 'bfredl/luarefvim'
    use 'nvim-lua/plenary.nvim'
    use 'tjdevries/colorbuddy.nvim'
  end, -- }}}

  config = {
    max_jobs = 32,
    display = {
      open_fn = require('packer.util').float,
    },
  },
}

-- vim: fdm=marker
