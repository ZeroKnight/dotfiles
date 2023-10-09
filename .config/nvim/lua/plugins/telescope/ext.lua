local M = {}

M.to_load = {}

function M.add_extension(name)
  table.insert(M.to_load, name)
end

return M
