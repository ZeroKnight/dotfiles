-- Colorscheme configuration

-- Set initial background based on time of day
local hour = tonumber(os.date '%H')
if hour >= 6 and hour < 18 then
  vim.opt.background = 'light'
else
  vim.opt.background = 'dark'
end

-- Colorscheme-specific settings

vim.g.tokyonight_day_brightness = 0.3

vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_variables = false

vim.g.tokyonight_dark_float = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_transparent_sidebar = false
vim.g.tokyonight_sidebars = {
  'fugitive',
  'Outline',
  'packer',
  'qf',
  'terminal',
  'Trouble',
  'undotree',
}

vim.cmd 'colorscheme tokyonight'
