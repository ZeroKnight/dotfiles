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
      -- Don't show annoying null-ls progress messages
      filter = {
        any = {
          { event = 'lsp', kind = 'progress', find = 'code_action' },
          { event = 'lsp', kind = 'progress', find = 'diagnostics' },
        },
      },
      opts = { skip = true },
    },
    {
      -- TODO: Handle this better when Noice is able to
      filter = { event = 'msg_show', kind = 'echo', find = '<bs> go up one level' },
      view = 'notify',
      opts = { title = 'Which-Key', replace = true },
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
