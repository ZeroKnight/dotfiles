-- Git support and utilities

local ui = require 'zeroknight.config.ui'
local util = require 'zeroknight.util'

---@type LazySpec
return {
  {
    'rhysd/committia.vim',
    ft = 'gitcommit',
  },

  {
    'tpope/vim-fugitive',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'tpope/vim-rhubarb' },
    keys = {
      { '<Leader>G', '<Cmd>Git<CR>', desc = 'Status window' },
      { '<Leader>gcc', '<Cmd>Git commit --verbose<CR>', desc = 'Commit' },
      { '<Leader>gce', '<Cmd>Git commit --amend --reuse-message=HEAD<CR>', desc = 'Amend last commit (no edit)' },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      numhl = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        virt_text_priority = 50,
        delay = 1000,
      },
      on_attach = function(buffer)
        local gs = require 'gitsigns'
        local wk = require 'which-key'

        wk.add {
          buffer = buffer,
          { ']h', util.partial(gs.nav_hunk, 'next', { preview = true }), desc = 'Next hunk' },
          { '[h', util.partial(gs.nav_hunk, 'prev', { preview = true }), desc = 'Previous hunk' },
          { ']H', util.partial(gs.nav_hunk, 'last', { preview = true }), desc = 'First hunk' },
          { '[H', util.partial(gs.nav_hunk, 'first', { preview = true }), desc = 'Last hunk' },
          {
            group = 'hunks',
            { '<LocalLeader>hu', gs.undo_stage_hunk, desc = 'Undo Stage Hunk' },
            { '<LocalLeader>hp', gs.preview_hunk, desc = 'Preview Hunk' },
            { '<LocalLeader>hP', gs.preview_hunk_inline, desc = 'Preview Hunk (Inline)' },
            { '<LocalLeader>hR', gs.reset_buffer, desc = 'Reset Buffer (All hunks)' },
            { '<LocalLeader>hS', gs.stage_buffer, desc = 'Stage Buffer (All hunks)' },
            { '<LocalLeader>hU', gs.reset_buffer_index, desc = 'Reset Buffer Index' },
            { '<LocalLeader>hd', gs.toggle_deleted, desc = 'Toggle deleted lines' },
            { '<LocalLeader>hw', gs.toggle_word_diff, desc = 'Toggle word diff' },
            {
              mode = { 'n', 'v' },
              { 'gh', ':Gitsigns stage_hunk<CR>', desc = 'Stage hunk' },
              { 'gH', ':Gitsigns reset_hunk<CR>', desc = 'Reset hunk' },
            },
          },
          {
            group = 'git',
            { '<LocalLeader>gB', gs.toggle_current_line_blame, desc = 'Toggle current line blame' },
            {
              '<LocalLeader>gb',
              util.partial(gs.blame_line, { full = true, ignore_whitespace = true }),
              desc = 'Blame line',
            },
          },
          { 'gh', '<Cmd>Gitsigns select_hunk<CR>', mode = { 'o', 'x' } },
        }
      end,
    },
  },

  {
    'sindrets/diffview.nvim',
    opts = {
      icons = {
        folder_closed = ui.icons.common.folder,
        folder_open = ui.icons.common.folder_open,
      },
      signs = {
        fold_closed = ui.icons.folds.closed,
        fold_open = ui.icons.folds.open,
        done = ui.icons.common.check,
      },
    },
  },
}
