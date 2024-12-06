-- Utility functions for writing LuaSnip snippets

local ls = require 'luasnip'
local extras = require 'luasnip.extras'
local fmt = require('luasnip.extras.fmt').fmt

local M = {}

-- Snippet data is sometimes within a parent snippet (i.e. snippetnode), so
-- try each parent until the data we want is found.
local function get_snip(snip, field)
  while snip[field] == nil do
    snip = snip.parent
  end
  return snip[field]
end

local snippet_lookup_cache = {}
function M.get_snippet_by_name(name)
  if snippet_lookup_cache[name] ~= nil then
    return snippet_lookup_cache[name]
  end
  for _, ft in ipairs(ls.get_snippet_filetypes()) do
    for _, snippet in ipairs(ls.get_snippets(ft)) do
      if snippet.name == name then
        snippet_lookup_cache[name] = snippet
        return snippet
      end
    end
  end
end

-- Creates a modified luasnip.s function that creates snippets with a specific
-- priority if one isn't specified. Typically useful for ensuring snippets
-- have a lower priority so that similar, more specific ones will override
-- them, like with shell script or markdown flavors.
-- The default is to create snippets with priority 500, compared to the
-- luasnip default of 1000.
function M.snippet_with_def_prio(priority)
  if priority == nil then
    priority = 500
  end
  return function(t, nodes, opts)
    if type(t) == 'string' then
      t = { trig = t }
    end
    t.priority = t.priority and t.priority - priority or priority
    return ls.s(t, nodes, opts)
  end
end

function M.author() return vim.g.snips_author end

-- Return a suitable comment leader for the current filetype
function M.get_comment()
  local cms = vim.opt.commentstring:get()
  if cms:match '%%s$' then
    return vim.trim(cms:sub(0, -3))
  end
  for _, part in vim.gsplit(vim.opt.comments:get(), ',', true) do
    local flags, text = unpack(vim.split(part, ':', true))
    if flags == '' or flags == 'b' then
      return text
    end
  end
end

function M.get_foldmarker(marker)
  ---@diagnostic disable-next-line: redundant-parameter
  vim.validate {
    marker = {
      marker,
      function(x) return x == nil or x == 'open' or x == 'close' end,
      "'open', 'close', or nil",
    },
  }
  local fmr = vim.opt.foldmarker:get()
  if marker ~= nil then
    local map = { open = 1, close = 2 }
    return fmr[map[marker]]
  else
    return fmr
  end
end

-- Return a text node with `n` newlines. Default is one.
function M.nl(n)
  local nodes = { '' }
  for _ = 1, n or 1 do
    table.insert(nodes, '')
  end
  return ls.t(nodes)
end

-- Return a function node that expands to `text` surrounded by `opening` and
-- `closing` only if the jumpable node at `pos` is not empty. Otherwise,
-- expands to an empty string.
function M.maybe_surround(pos, text, opening, closing)
  return extras.nonempty(pos, string.format('%s%s%s', opening, text, closing))
end

-- Return a function node that expands to `if_match` when the snippet trigger
-- used matches `pat`, or `fallback` otherwise, which defaults to nothing.
-- If `exact` is `true` then the trigger must exactly match `pat`.
-- Defaults to `false`.
function M.if_trigger(pat, text, fallback, exact)
  return ls.f(function(_, snip)
    local trigger = get_snip(snip, 'trigger')
    if exact then
      return trigger == pat and text or fallback or ''
    else
      return trigger:match(pat) and text or fallback or ''
    end
  end)
end

-- Function node whose expansion is determined by a map of patterns and
-- potential result strings. Each pattern in `map` will be used to match
-- against the snippet trigger, and if one matches its associated string
-- will be returned. If nothing matches, an empty string is expanded.
function M.when_trigger(map)
  return ls.f(function(_, snip)
    for pat, output in pairs(map) do
      if snip.trigger:match(pat) then
        return output
      end
    end
    return ''
  end)
end

-- Return a dynamic node that expands to the desired snippet selection text.
-- If the selection is empty, return `fallback_text` or an empty string if
-- unspecified.
function M.selection(pos, selection_type, fallback_text)
  return ls.d(pos, function(_, snip)
    local sel = get_snip(snip, 'env')[selection_type]
    if #sel > 0 then
      return ls.sn(nil, ls.t(sel))
    else
      return ls.sn(nil, ls.i(1, fallback_text or ''))
    end
  end)
end

-- Return a function for a dynamic node that generates a number of delimited
-- insert nodes equivalent to how many times `pattern` matches within the
-- node specified by the dynamic node. Useful for generating argument lists,
-- docstrings, etc. `opts` can consist of the following:
--    * delimiter [string]: Used to delimit each insert node (Default: `', '`)
--    * regex [bool]: Interpret `pattern` as a Vim pattern (Default: false)
function M.generate_insertnodes(pattern, opts)
  opts = vim.tbl_extend('keep', opts or {}, { delimiter = ', ', regex = false })
  -- Iterator that searches with either Vim or Lua patterns
  local function matches(src_text)
    if opts.regex then
      return function(state, lastpos)
        lastpos = vim.fn.match(state.src_text, state.pattern, lastpos)
        if lastpos == -1 then
          return nil
        end
        return lastpos + 1
      end,
        { src_text = src_text, pattern = pattern },
        0
    else
      return src_text:gmatch(pattern)
    end
  end

  return function(args)
    local placeholders = {}
    local nodes = {}
    for _ in matches(args[1][1]) do
      table.insert(placeholders, '{}')
      table.insert(nodes, ls.i(#placeholders))
    end
    if #placeholders > 0 then
      return ls.sn(nil, fmt(table.concat(placeholders, opts.delimiter), nodes))
    else
      return ls.sn(nil, ls.t '')
    end
  end
end

-- Like Python's `Path.stem`, return the basename of the current file without
-- the extension.
function M.file_stem() return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t:r') end

return setmetatable(M, {
  -- Slight sugar to avoid having to explicitly import language-specific utils
  __index = function(_, k)
    local ok, mod = pcall(require, string.format('plugins.snippet.util.%s', k))
    return ok and mod or nil
  end,
})
