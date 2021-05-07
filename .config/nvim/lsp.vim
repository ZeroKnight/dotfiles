" Language Server Configuration

if has('nvim-0.5.0')
  command! LspDiagnostics lua vim.lsp.diagnostic.set_loclist()

  lua << EOF
  local lspconfig = require('lspconfig')

  local function python_interpreter()
    if vim.env.VIRTUAL_ENV then
      return vim.env.VIRTUAL_ENV .. '/bin/python' 
    else
      return vim.call('exepath', 'python3')
    end
  end

  local function python_version(interpreter)
    local ver_cmd = vim.call(
      'shellescape', "import sys; print('.'.join(map(str, sys.version_info[:2])), end='')")
    return vim.call('system', string.format('%s -c %s', interpreter, ver_cmd))
  end

  local function lsp_buffer_setup(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- TBD: Do I set this, or let completion-nvim do it?
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Language Server method mappings
    local opts = {noremap = true, silent = true}
    local function map_lsp_method(modes, kind, lhs, method)
      for mode in vim.gsplit(modes, '') do
        buf_set_keymap(mode, lhs, string.format('<Cmd>lua vim.lsp.%s.%s()<CR>', kind, method), opts)
      end
    end

    map_lsp_method('n',  'buf',        '<Leader>a',  'code_action')
    map_lsp_method('n',  'buf',        'gD',         'declaration')
    map_lsp_method('n',  'buf',        'gd',         'definition')
    map_lsp_method('n',  'buf',        '<Leader>sd', 'document_symbol')
    map_lsp_method('n',  'buf',        'K',          'hover')
    map_lsp_method('n',  'buf',        'gI',         'implementation')
    map_lsp_method('n',  'buf',        ']C',         'incoming_calls')
    map_lsp_method('n',  'buf',        '[C',         'outgoing_calls')
    map_lsp_method('n',  'buf',        'gr',         'references')
    map_lsp_method('n',  'buf',        '<F2>',       'rename')
    map_lsp_method('ni', 'buf',        '<C-s>',      'signature_help')
    map_lsp_method('n',  'buf',        '<Leader>td', 'type_definition')
    map_lsp_method('n',  'buf',        '<Leader>sw', 'workspace_symbol')
    map_lsp_method('ni', 'diagnostic', '<M-d>',      'show_line_diagnostics')
    -- TODO: Make signature help show up on open paren and comma like vim-lsp
    -- TBD line diagnostics? do we let ALE do this? regardless, we should have a mapping
    -- TBD lsp formatting mappings?

    -- Enable document highlights if supported 
    if client.resolved_capabilities.document_highlight then
      vim.cmd([[
        augroup lsp_document_highlight
          autocmd! 
          autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]])
    end
  end

  -- LSP Highlighting
  -- TBD: Info and Warning colors
  vim.cmd([[
    hi link LspReferenceRead DiffAdd
    hi link LspReferenceWrite DiffChange
    hi link LspReferenceText DiffText

    hi link LspDiagnosticsDefaultError Error
    hi link LspDiagnosticsDefaultHint Question
  ]])

  -- Configure Language Server settings
  local servers = {
    pyright = {
      settings = {
        python = {
          analysis = {
            autoImportCompletions = true
          },
          venvPath = {'venv', '.venv'}
        }
      }
    }
  }
  -- Run the setup for each server
  for ls, config in pairs(servers) do
    lspconfig[ls].setup(
      vim.tbl_extend('error', {on_attach = lsp_buffer_setup}, config)
    )
  end
EOF
else
  " Fall back to prabirshrestha/vim-lsp

  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    setlocal foldmethod=expr
      \ foldexpr=lsp#ui#vim#folding#foldexpr()
      \ foldtext=lsp#ui#vim#folding#foldtext()

    nmap <buffer> <Leader>a  <Plug>(lsp-code-action)
    nmap <buffer> gD         <Plug>(lsp-declaration)
    nmap <buffer> gd         <Plug>(lsp-definition)
    nmap <buffer> K          <Plug>(lsp-hover)
    nmap <buffer> ]r         <Plug>(lsp-next-reference)
    nmap <buffer> [r         <Plug>(lsp-previous-reference)
    nmap <buffer> [I         <Plug>(lsp-references)
    nmap <buffer> ]I         <Plug>(lsp-references)
    nmap <buffer> <F2>       <Plug>(lsp-rename)
    nmap <buffer> <C-s>      <Plug>(lsp-signature-help)
    nmap <buffer> <Leader>pD <Plug>(lsp-peek-declaration)
    nmap <buffer> <Leader>pd <Plug>(lsp-peek-definition)
  endfunction

  augroup lsp_install
      autocmd!
      autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

  if executable('pyls')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': {server_info->['pyls']},
      \ 'whitelist': ['python'],
      \ })
  endif
endif

