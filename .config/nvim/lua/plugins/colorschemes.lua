-- Colorschemes

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',
      light_style = 'day',
      terminal_colors = true,
      day_brightness = 0.3,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = 'dark',
        floats = 'dark',
      },
      sidebars = {
        'fugitive',
        'Outline',
        'help',
        'qf',
        'terminal',
        'Trouble',
        'undotree',
      },
    },
  },

  {
    'rakr/vim-one',
    lazy = true,
    config = function()
      -- I don't like the way vim-one highlights diff headers
      vim.cmd [[
        hi clear DiffFile
        hi clear DiffNewFile
        hi clear DiffOldFile
        hi link  DiffFile Statement
        hi link  DiffNewFile DiffAdded
        hi link  DiffOldFile DiffRemoved
        ]]
    end,
  },

  { 'ciaranm/inkpot', lazy = true },
  { 'tomasr/molokai', lazy = true },
  { 'romainl/Apprentice', lazy = true },
  { 'arcticicestudio/nord-vim', lazy = true },
  { 'tyrannicaltoucan/vim-quantum', lazy = true },
  { 'tyrannicaltoucan/vim-deep-space', lazy = true },
  { 'mhartington/oceanic-next', lazy = true },
  { 'dracula/vim', lazy = true, name = 'dracula' },
  { 'drewtempelmeyer/palenight.vim', lazy = true },
}
