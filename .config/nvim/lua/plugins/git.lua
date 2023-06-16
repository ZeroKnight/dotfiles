-- Git support and utilities

local util = require 'zeroknight.util'

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

        wk.register({
          [']h'] = { gs.next_hunk, 'Next hunk' },
          ['[h'] = { gs.prev_hunk, 'Previous hunk' },

          ['<LocalLeader>h'] = {
            name = 'hunks',
            u = { gs.undo_stage_hunk, 'Undo Stage Hunk' },
            p = { gs.preview_hunk, 'Preview Hunk' },
            P = { gs.preview_hunk_inline, 'Preview Hunk (Inline)' },
            R = { gs.reset_buffer, 'Reset Buffer (All hunks)' },
            S = { gs.stage_buffer, 'Stage Buffer (All hunks)' },
            U = { gs.reset_buffer_index, 'Reset Buffer Index' },
          },

          ['<LocalLeader>g'] = {
            name = 'git',
            B = { gs.toggle_current_line_blame, 'Toggle current line blame' },
            b = {
              util.partial(gs.blame_line, { full = true, ignore_whitespace = true }),
              'Blame line',
            },
            d = { gs.toggle_deleted, 'Toggle deleted lines' },
            w = { gs.toggle_word_diff, 'Toggle word diff' },
          },
        }, {
          buffer = buffer,
        })

        local nv_maps = {
          s = { ':Gitsigns stage_hunk<CR>', 'Stage hunk' },
          r = { ':Gitsigns reset_hunk<CR>', 'Reset hunk' },
        }
        vim.iter({ 'n', 'v' }):each(function(mode)
          wk.register(nv_maps, { prefix = '<LocalLeader>h', mode = mode, buffer = buffer })
        end)

        vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = buffer })
      end,
    },
  },
}
