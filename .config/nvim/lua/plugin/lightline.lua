-- ZeroKnight's LightLine

vim.g.lightline = {
  colorscheme = vim.g.colors_name,
  separator = {left = '', right = ''},
  subseparator = {left = '', right = ''},
  active = {
    left = {
      {'Mode', 'paste'},
      {'GitHunks', 'GitBranch'},
      {'diagnostics', 'filename', 'ReadOnly', 'preview'}
    },
    right = {
      {'lineinfo', 'LspProgress'}, {'FileInfo'}, {'CurrSymbol', 'filetype'}, {'spell'}
    }
  },
  inactive = {
    left = {
      {'help'}, {},
      {'filename', 'quickfix'}
    },
    right = {
      {'lineinfo'}, {'FileInfo'}, {'filetype'},
    }
  },
  tabline = {
    left = {{'tabs'}},
    right = {{}, {'buffers'}}
  },
  component = {
    filename = '%<%{zeroknight#lightline#file_name()}',
    lineinfo = '%3l:%-2c [%p%%] ',
    preview = '%w',
    quickfix ='%q',
    help = "%{&buftype ==# 'help' ? 'Help' : ''}",
    diagnostics = '%{%zeroknight#lightline#diagnostics()%}%*'
  },
  component_visible_condition = {
    filename = 1,
    preview = '&previewwindow',
    quickfix = "&buftype ==# 'quickfix'",
    help = "&buftype ==# 'help'",
    diagnostics = 'zeroknight#diagnostic#available()'
  },
  component_function = {
    Mode = 'zeroknight#lightline#mode',
    FileInfo = 'zeroknight#lightline#file_info',
    ReadOnly = 'zeroknight#lightline#readonly',
    GitBranch = 'zeroknight#lightline#git_branch',
    GitHunks = 'zeroknight#lightline#git_hunks',
    CurrSymbol = 'zeroknight#lightline#current_symbol',
    LspProgress = 'zeroknight#lightline#lsp_progress'
  },
  component_function_visible_condition = {
    Mode = 1,
    FileInfo = 1,
    ReadOnly = "&readonly && &buftype ==# ''",
    GitBranch = "zeroknight#lightline#has_minwidth() && !empty(get(b:, 'gitsigns_head', ''))",
    GitHunks = "zeroknight#lightline#has_minwidth() && !empty(get(b:, 'gitsigns_status', ''))",
    CurrSymbol = '!empty(zeroknight#lightline#current_symbol())'
  },
  component_expand = {
    buffers = 'lightline#bufferline#buffers'
  },
  component_type = {
    buffers = 'tabsel'
  }
}
