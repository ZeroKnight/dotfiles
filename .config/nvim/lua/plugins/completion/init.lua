-- Completion Plugins
--
-- Plugins that facilitate automatic completion, generally from a variety of
-- sources. Includes completion engines themselves, interfaces, functions, etc.

local ui = require 'zeroknight.config.ui'

---@type LazySpec
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
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'ray-x/cmp-treesitter' },
    },
    opts = function()
      local cmp = require 'cmp'
      local compare = require 'plugins.completion.compare'

      local menu_text = {
        buffer = 'buf',
        nvim_lsp = 'LSP',
        nvim_lua = 'vim',
        path = 'path',
        luasnip = 'snip',
        treesitter = 'TS',
      }

      ---@type cmp.ConfigSchema
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
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'treesitter' },
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
        window = {
          documentation = cmp.config.window.bordered(),
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
          ['<C-p>'] = cmp.mapping {
            i = cmp.mapping.complete {
              config = {
                sources = { { name = 'luasnip' } },
                experimental = { ghost_text = false },
              },
            },
          },
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'

      cmp.setup(opts)
      require 'plugins.completion.sources'
      require 'plugins.completion.conventional_commits'

      -- Set up highlights
      local overrides = {
        CmpItemMenu = 'NonText', -- Mute the item source (e.g. [LSP])
        CmpItemAbbrMatchFuzzy = 'Constant', -- Accentuate fuzzy portion
      }
      for group, link in pairs(overrides) do
        vim.api.nvim_set_hl(0, group, { link = link }) -- Accentuate fuzzy portion
      end

      -- nvim-autopairs: Automatically insert parentheses when accepting functions/methods
      if require('zeroknight.util').has_plugin 'nvim-autopairs' then
        cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
      end
    end,
  },
}
