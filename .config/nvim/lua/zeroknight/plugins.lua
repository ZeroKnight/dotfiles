-- Plugin Specification

function packer_loaded(name)
  return packer_plugins[name] and packer_plugins[name].loaded
end

return require('packer').startup{
  function(use)

    -- Let Packer keep itself up to date
    use 'wbthomason/packer.nvim'

    -- UI Plugins {{{1
    use 'airblade/vim-gitgutter'  -- TODO: try out lewis6991/gitsigns.nvim
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
      setup = function()
        local function set(var, val) vim.g['lightline#bufferline#' .. var] = val end
        set('right_aligned', 1)
        set('filter_by_tabpage', 1)
        vim.opt.showtabline = 2
      end
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
      config = [[require('plugin.telescope')]]
    }

    use {
      'kyazdani42/nvim-web-devicons',
      config = function() require('nvim-web-devicons').setup {default = true} end
    }

    use {
      'folke/zen-mode.nvim',
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

    use 'mhinz/vim-grepper'
    use 'romainl/vim-qlist'

    -- TODO: pick one (or neither? maybe telescope or something can show LSP symbols)
    -- tagbar doesn't support LSP, but vista has problems with ctags, and possibly only
    -- supports an LSP tree view for coc?
    use 'liuchengxu/vista.vim'
    use 'majutsushi/tagbar'

    -- TBD: Do I still need ALE with LSP? I suppose there's certain linters
    -- that would still be nice to have
    use 'dense-analysis/ale'

    -- Debug Adapter Protocol (DAP)
    use 'mfussenegger/nvim-dap'
    use 'jbyuki/one-small-step-for-vimkind'

    -- Completion {{{1
    use {
      'hrsh7th/nvim-compe',
      after = 'lexima.vim',
      config = [[require('plugin.completion')]]
    }

    -- Editing {{{1
    use 'chrisbra/NrrwRgn'  -- TODO: experiment with this and find good use cases
    use 'christoomey/vim-sort-motion'
    use 'godlygeek/tabular'
    use 'reedes/vim-wordy'
    use 'tpope/vim-abolish'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'wellle/targets.vim'  -- TODO: practice

    use {
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('todo-comments').setup {
          merge_keywords = false,  -- Just going to manually set everything
          keywords = {
            TODO = {alt = {'TBD', 'TEST'}},
            FIX =  {alt = {'FIXME', 'FIXIT', 'BUG', 'DEBUG', 'ISSUE'}},
            HACK = {alt = {'XXX'}},
            NOTE = {alt = {'NOTICE', 'INFO'}},
            WARN = {alt = {'WARNING', 'DEPRECATED', 'ATTENTION', 'ALERT', 'DANGER', 'WTF'}}
          },
        }
      end
    }

    use {
      'unblevable/quick-scope',
      setup = [[vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}]]
    }

    use {
      -- TODO: check out vsnip or lua snippet plugins
      'SirVer/ultisnips',
      setup = function()
        vim.g.UltiSnipsExpandTrigger = '<C-Space>'
        vim.g.UltiSnipsListSnippets = '<C-l>'
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

    -- Utility Plugins {{{1
    use '~/Projects/vim-signjump'
    use 'Konfekt/FastFold'
    use 'moll/vim-bbye'
    use 'tpope/vim-characterize'
    use 'tpope/vim-dispatch'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use {'tpope/vim-rhubarb', requires = 'tpope/vim-fugitive'}
    use 'tpope/vim-obsession'
    use 'tpope/vim-scriptease'
    use 'tpope/vim-unimpaired'

    -- Language Support {{{1
    -- TBD: Dump this and just grab what we care about; I'm not using the vast majority of filetypes
    use {
      'sheerun/vim-polyglot',
      setup = function()
        -- Don't mess with my configuration, please.
        vim.g.polyglot_disabled = {'sensible', 'autoindent'}
      end
    }
    use {'withgod/vim-sourcepawn',  ft = 'sourcepawn'}
    use {'mitsuhiko/vim-jinja',     ft = {'html', 'jinja'}}
    use {'mattn/emmet-vim',         ft = {'html', 'xhtml', 'xml', 'jinja'}}
    -- TODO: revisit this after trying an HTML language server
    use {'Valloric/MatchTagAlways', disabled = true, ft = {'html', 'xhtml', 'xml', 'jinja'}}

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
