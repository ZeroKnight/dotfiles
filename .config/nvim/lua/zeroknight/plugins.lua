-- Plugin Specification

function packer_loaded(name)
  return packer_plugins[name] and packer_plugins[name].loaded
end

local function tele_extension(name)
  return string.format([[require('telescope').load_extension('%s')]], name)
end

return require('packer').startup{
  function(use)

    -- Let Packer keep itself up to date
    use 'wbthomason/packer.nvim'

    -- UI Plugins {{{1
    use 'justinmk/vim-dirvish'
    use 'mhinz/vim-startify'
    use 'kshenoy/vim-signature'
    use 'wesQ3/vim-windowswap'
    use 'Yggdroot/indentLine'
    use {
      'mbbill/undotree',
      cmd = {'UndotreeFocus', 'UndotreeHide', 'UndotreeShow', 'UndotreeToggle'}
    }

    use {
      'itchyny/lightline.vim',
      setup = [[require('plugin.lightline')]]
    }
    use {
      'mengelbrecht/lightline-bufferline',
      requires = 'itchyny/lightline.vim',
      setup = function()
        local function set(var, val) vim.g['lightline#bufferline#' .. var] = val end
        set('right_aligned', 1)
        set('filter_by_tabpage', 1)
        vim.opt.showtabline = 2
      end
    }

    use {
      {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons'},
        config = [[require('plugin.telescope')]]
      },
      -- Extensions
      {'nvim-telescope/telescope-packer.nvim', config = tele_extension('packer')},
      {'fhill2/telescope-ultisnips.nvim', config = tele_extension('ultisnips')},
      {'nvim-telescope/telescope-z.nvim', config = tele_extension('z')}
    }

    use {
      'kyazdani42/nvim-web-devicons',
      config = function() require('nvim-web-devicons').setup {default = true} end
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
              foldcolumn = '0'
            }
          }
        }
      end
    }
    use {
      'folke/twilight.nvim',
      config = function()
        require('twilight').setup {
          dimming = {
            alpha = 0.25,
            inactive = false
          }
        }
      end
    }

    use {
      'folke/which-key.nvim',
      config = [[require('plugin.which-key')]]
    }

    -- Language Server Protocol (LSP) {{{1
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'
    use 'folke/lsp-colors.nvim'

    use {
      'kosayoda/nvim-lightbulb',
      config = function()
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]
      end
    }

    use {
      'folke/lsp-trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('trouble').setup {
          action_keys = {
            close = {'q', 'gq'}  -- Other plugins use gq for closing
          },
          use_lsp_diagnostic_signs = true
        }
      end
    }

    -- Analysis and Debugging {{{1
    use {'mhinz/vim-grepper', cmd = 'Grepper'}
    use 'romainl/vim-qlist'

    -- TODO: replace ALE with nvim-lint or diagnostic-languageserver
    use 'dense-analysis/ale'

    -- Debug Adapter Protocol (DAP)
    use 'mfussenegger/nvim-dap'
    use 'jbyuki/one-small-step-for-vimkind'

    -- Completion {{{1
    use {
      -- NOTE: Compe has been deprecated (just as I started using it, go figure...).
      -- Switch to hrsh7th/nvim-cmp once it's had time to mature.
      'hrsh7th/nvim-compe',
      after = 'lexima.vim',
      config = [[require('plugin.completion')]]
    }

    -- Editing {{{1
    use {  -- TODO: experiment with this and find good use cases
      'chrisbra/NrrwRgn',
      cmd = {
        'NR', 'NW', 'NRV', 'NUD', 'NRP', 'NRL', 'NarrowRegion', 'NarrowWindow', 'NRPrepare'
      }
    }
    use 'christoomey/vim-sort-motion'
    use 'godlygeek/tabular'
    use {'reedes/vim-wordy', cmd = 'Wordy'}
    use 'tpope/vim-abolish'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'wellle/targets.vim'  -- TODO: practice

    use {
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = [[require('plugin.todo-comments')]]
    }

    use {
      'unblevable/quick-scope',
      setup = [[vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}]]
    }

    -- NOTE: Keep an eye out for Lua snippet plugins
    use {
      'SirVer/ultisnips',
      setup = function()
        vim.g.UltiSnipsExpandTrigger = '<C-Space>'
      end
    }

    use {
      'cohama/lexima.vim',
      setup = function()
        vim.g.lexima_enable_basic_rules = 1
        vim.g.lexima_enable_newline_rules = 1
        vim.g.lexima_enable_space_rules = 0
        vim.g.lexima_enable_endwise_rules = 1
        -- We need control over when the rules are defined to avoid mapping
        -- conflicts, e.g. with compe
        vim.g.lexima_no_default_rules = 1
      end,
      config = function()
        vim.fn['lexima#set_default_rules']()
      end
    }

    -- Git Integration {{{1
    use {
      {'tpope/vim-fugitive'},
      {'tpope/vim-rhubarb', requires = 'tpope/vim-fugitive'}
    }
    use 'rhysd/committia.vim'
    use {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = [[require('gitsigns').setup()]]
    }

    -- Utility Plugins {{{1
    use '~/Projects/vim-signjump'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-projectionist'  -- TODO: Try this out
    use 'tpope/vim-scriptease'
    use 'tpope/vim-unimpaired'
    use {'Konfekt/FastFold', config = [[vim.g.fastfold_skip_filetypes = {'gitcommit', 'taglist'}]]}
    use {'moll/vim-bbye', cmd = {'Bdelete', 'Bwipeout'}}
    use {'tpope/vim-characterize', keys = 'ga'}
    use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'FocusDispatch', 'Start'}}
    use {'tpope/vim-obsession', cmd = 'Obsession'}
    use {'dstein64/vim-startuptime', cmd = 'StartupTime'}

    -- Language Support {{{1
    use {
      'nvim-treesitter/nvim-treesitter',
      config = [[require('plugin.treesitter')]],
      run = ':TSUpdate'
    }
    use {'euclidianAce/BetterLua.vim', ft = 'lua'}
    use {'withgod/vim-sourcepawn',     ft = 'sourcepawn'}
    use {'mitsuhiko/vim-jinja',        ft = {'html', 'jinja'}}
    use {'mattn/emmet-vim',            ft = {'html', 'xhtml', 'xml', 'jinja'}}
    -- TODO: revisit this after trying an HTML language server
    use {'Valloric/MatchTagAlways', disable = true, ft = {'html', 'xhtml', 'xml', 'jinja'}}

    -- Color Schemes {{{1
    use 'rakr/vim-one'
    use 'ciaranm/inkpot'
    use 'tomasr/molokai'
    use 'romainl/Apprentice'
    use 'arcticicestudio/nord-vim'
    use 'tyrannicaltoucan/vim-quantum'
    use 'tyrannicaltoucan/vim-deep-space'
    use 'mhartington/oceanic-next'
    use {'dracula/vim', as = 'vim-dracula'}
    use 'drewtempelmeyer/palenight.vim'
    use 'folke/tokyonight.nvim'

    -- Libraries & Misc {{{1
    use 'tpope/vim-repeat'
    use 'nanotee/nvim-lua-guide'
    use 'nanotee/luv-vimdocs'
    use 'nvim-lua/plenary.nvim'

  end,  -- }}}

  config = {
    max_jobs = 32,
    display = {
      open_fn = require('packer.util').float
    }
  }
}

-- vim: fdm=marker
