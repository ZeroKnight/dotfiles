-- ZeroKnight's LightLine

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
