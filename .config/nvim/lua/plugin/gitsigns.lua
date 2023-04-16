-- GitSigns configuration

local gs = require 'gitsigns'
local wk = require 'which-key'

local function on_attach(bufnr)
  -- stylua: ignore start
  wk.register({
    [']h'] = { function() gs.next_hunk() end, 'Next hunk' },
    ['[h'] = { function() gs.prev_hunk() end, 'Previous hunk' },
  }, {
    buffer = bufnr
  })

  wk.register({
    name = 'hunks',
    u = { gs.undo_stage_hunk, 'Undo Stage Hunk' },
    p = { gs.preview_hunk, 'Preview Hunk' },
    P = { gs.preview_hunk_inline, 'Preview Hunk (Inline)' },
    R = { gs.reset_buffer, 'Reset Buffer (All hunks)' },
    S = { gs.stage_buffer, 'Stage Buffer (All hunks)' },
    U = { gs.reset_buffer_index, 'Reset Buffer Index' },
  }, {
    prefix = '<LocalLeader>h',
    buffer = bufnr,
  })
  -- stylua: ignore end

  local nv_maps = {
    s = { ':Gitsigns stage_hunk<CR>', 'Stage hunk' },
    r = { ':Gitsigns reset_hunk<CR>', 'Reset hunk' },
  }
  for _, mode in ipairs { 'n', 'v' } do
    wk.register(nv_maps, { prefix = '<LocalLeader>h', mode = mode })
  end

  wk.register({
    name = 'git',
    B = { gs.toggle_current_line_blame, 'Toggle current line blame' },
    b = {
      function()
        gs.blame_line { full = true, ignore_whitespace = true }
      end,
      'Blame line',
    },
    d = { gs.toggle_deleted, 'Toggle deleted lines' },
    w = { gs.toggle_word_diff, 'Toggle word diff' },
  }, {
    prefix = '<LocalLeader>g',
    buffer = bufnr,
  })

  vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr })
end

gs.setup {
  on_attach = on_attach,
  numhl = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    virt_text_priority = 50,
    delay = 1000,
  },
}
