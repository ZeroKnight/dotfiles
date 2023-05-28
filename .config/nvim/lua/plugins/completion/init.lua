-- Completion Plugins
--
-- Plugins that facilitate automatic completion, generally from a variety of
-- sources. Includes completion engines themselves, interfaces, functions, etc.

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- TODO: Dadbod completion
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-cmdline' },
      { 'petertriho/cmp-git' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
    },
    init = function()
      -- Required by cmp
      vim.opt.completeopt = { 'menuone', 'noselect' }
    end,
    opts = function()
      local cmp = require 'cmp'
      local compare = require 'plugins.completion.compare'

      local ui = require 'zeroknight.config.ui'

      local menu_text = {
        buffer = 'buf',
        nvim_lsp = 'LSP',
        nvim_lua = 'vim.api',
        path = 'path',
        luasnip = 'snip',
      }

      return {
        enabled = true,
        completion = {
          keyword_length = 2,
        },
        experimental = {
          ghost_text = {
            hl_group = 'LspCodeLens',
          },
        },
        preselect = cmp.PreselectMode.Item, -- Auto-select the source-specified item

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'luasnip' },
          { name = 'calc', keyword_length = 3 },
          { name = 'buffer', keyword_length = 5 },
        },

        formatting = {
          format = function(entry, item)
            local name = menu_text[entry.source.name]
            item.kind = string.format('%s  %s', ui.icons.kinds[item.kind] or '?', item.kind)
            item.menu = name and string.format('[%s]', name) or ''
            return item
          end,
        },

        sorting = {
          comparators = {
            compare.offset,
            compare.exact,
            -- compare.scopes,
            compare.sort_text,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.underscores,
            compare.kind,
            compare.length,
            compare.order,
          },
        },

        mapping = {
          ['<CR>'] = function(fallback)
            if cmp.visible() then
              -- Only confirm() if we've selected something, otherwise just <CR>
              if cmp.get_selected_entry() ~= nil then
                cmp.confirm()
              else
                cmp.close()
                fallback()
              end
            else
              -- Support plugins like Lexima that may remap <CR>
              fallback()
            end
          end,
          ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          ['<Tab>'] = cmp.mapping {
            i = cmp.mapping.select_next_item(),
            c = function()
              if cmp.visible() then
                cmp.select_next_item()
              else
                cmp.complete()
              end
            end,
          },
          ['<S-Tab>'] = cmp.mapping {
            i = cmp.mapping.select_prev_item(),
            c = function()
              if cmp.visible() then
                cmp.select_prev_item()
              else
                cmp.complete()
              end
            end,
          },
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'
      local ui = require 'zeroknight.config.ui'

      cmp.setup(opts)
      require 'plugins.completion.sources'
      require 'plugins.completion.conventional_commits'

      -- Set up highlights
      vim.cmd [[
  hi link CmpItemAbbrMatch Function
  hi link CmpItemAbbrMatchFuzzy Statement
]]

      for group, link in pairs { CmpItemAbbrDeprecated = 'Error', CmpItemKind = 'Title', CmpItemMenu = 'NonText' } do
        if not pcall(vim.api.nvim_get_hl_by_name, group, false) then
          vim.cmd(string.format('hi link %s %s', group, link))
        end
      end

      local kind_colors = {
        Class = 'Type',
        Field = 'String',
        Interface = 'Type',
        Method = 'Function',
        Module = 'Type',
        Namespace = 'Type',
        Package = 'Statement',
        Property = 'Identifier',
        Snippet = 'SpecialKey',
        Variable = 'Identifier',
      }
      for kind, _ in pairs(ui.icons.kinds) do
        if not pcall(vim.api.nvim_get_hl_by_name, 'CmpItemKind' .. kind, false) then
          local explicit = kind_colors[kind]
          if explicit ~= nil then
            vim.cmd(string.format('hi link CmpItemKind%s %s', kind, explicit))
          elseif pcall(vim.api.nvim_get_hl_by_name, kind, false) then
            vim.cmd(string.format('hi link CmpItemKind%s %s', kind, kind))
          end
        end
      end

      -- nvim-autopairs: Automatically insert parentheses when accepting functions/methods
      if require('zeroknight.util').has_plugin 'nvim-autopairs' then
        cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
      end
    end,
  },
}
