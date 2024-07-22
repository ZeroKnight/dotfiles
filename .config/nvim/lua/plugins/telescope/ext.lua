local M = {}

M.to_load = {}

--- Add a telescope extension name to the lazy-load list
---@param name string: The extension name given to `load_extension`
function M.add_extension(name)
  table.insert(M.to_load, name)
end

--- Return a |LazyPluginSpec| for a telescope extension.
--- Sets the `init` handler to add the extension to the list of extensions
--- to lazy load along with Telescope.
---@param source string: Plugin source, e.g. repo name
---@param name string: The extension name given to `load_extension`
---@return LazyPluginSpec
function M.spec(source, name)
  return {
    source,
    lazy = true,
    init = function()
      M.add_extension(name)
    end,
    dependencies = { 'nvim-telescope/telescope.nvim' },
  }
end

return M
