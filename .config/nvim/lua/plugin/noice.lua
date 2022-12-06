-- noice Configuration

require('noice').setup {
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
      -- Send huge notifications to a split
      filter = { event = 'notify', min_height = 15 },
      view = 'split',
    },
    {
      -- Show "recording @x" in a mini view
      filter = { event = 'msg_showmode' },
      view = 'mini',
    },
    {
      -- Don't show annoying null-ls progress messages
      filter = {
        any = {
          { event = 'lsp', kind = 'progress', find = 'code_action' },
          { event = 'lsp', kind = 'progress', find = 'diagnostics' },
        },
      },
      opts = { skip = true },
    },
  },
}

require('telescope').load_extension 'noice'

vim.keymap.set('n', '<C-f>', function()
  if not require('noice.lsp').scroll(4) then
    return '<C-f>'
  end
end, {
  silent = true,
  expr = true,
})

vim.keymap.set('n', '<C-b>', function()
  if not require('noice.lsp').scroll(-4) then
    return '<C-b>'
  end
end, {
  silent = true,
  expr = true,
})
