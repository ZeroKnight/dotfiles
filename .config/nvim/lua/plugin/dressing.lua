-- dressing.nvim configuration

local dressing = require 'dressing'

dressing.setup {
  input = { -- vim.ui.input
    enabled = true,
  },
  select = { -- vim.ui.select
    enabled = true,
    format_item_override = {
      codeaction = function(action_tuple)
        -- Show language server per action
        local title = action_tuple[2].title:gsub('\r\n', '\\r\\n')
        local client = vim.lsp.get_client_by_id(action_tuple[1])
        return string.format('%s\t[%s]', title:gsub('\n', '\\n'), client.name)
      end,
    },
    get_config = function(opts)
      if opts.kind == 'codeaction' then
        return {
          telescope = require('telescope.themes').get_cursor(),
        }
      end
    end,
  },
}
