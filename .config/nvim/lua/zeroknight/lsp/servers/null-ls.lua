-- null-ls Configuration

local null_ls = require 'null-ls'
local builtins = null_ls.builtins

local lsp_buffer_setup = require('zeroknight.lsp').lsp_buffer_setup

-- NOTE: Vale is highly extensible, so it can "include" other prose linters

null_ls.setup {
  -- NOTE: Trouble shows the code and source name as well
  -- diagnostics_format = '[#{c}] #{m} (#{s})',
  diagnostics_format = '#{m}',
  on_attach = lsp_buffer_setup,
  update_in_insert = false,
  sources = {
    -- Diagnostics
    builtins.diagnostics.gitlint,
    builtins.diagnostics.markdownlint,
    builtins.diagnostics.rstcheck,
    builtins.diagnostics.selene,
    builtins.diagnostics.shellcheck,
    builtins.diagnostics.vale,
    builtins.diagnostics.vint,
    builtins.diagnostics.zsh,

    -- Formatting
    builtins.formatting.black,
    builtins.formatting.isort,
    builtins.formatting.markdownlint,
    builtins.formatting.prettier,
    builtins.formatting.stylua.with {
      cwd = function(params)
        local nvim_cfg = vim.fn.stdpath('config')
        if string.match(params.bufname, nvim_cfg) then
          return nvim_cfg
        end
      end,
    },
    builtins.formatting.trim_newlines,
    builtins.formatting.trim_whitespace,

    -- Code Actions
    builtins.code_actions.gitsigns,
  },
}
