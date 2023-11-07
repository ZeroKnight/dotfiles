-- Utilities for playing with colors

local band, bor, lshift, rshift = bit.band, bit.bor, bit.lshift, bit.rshift

local M = {}

-- Convert an integer color into hexadecimal format
---@param color number
function M.to_hex(color)
  vim.validate { color = { color, 'number' } }
  return string.format('#%06x', color)
end

-- Return the foreground highlight color as a hexadecimal string
---@param name string
function M.fg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  return M.to_hex(hl.fg)
end

-- Return the background highlight color as a hexadecimal string
---@param name string
function M.bg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  return M.to_hex(hl.bg)
end

-- Break a given color into separate Red/Green/Blue values
---@param color string|number
function M.extract_rgb(color)
  if type(color) == 'string' then
    color = tonumber(string.gsub(color, '#', ''), 16)
  end
  return {
    r = band(rshift(color, 16), 0xFF),
    g = band(rshift(color, 8), 0xFF),
    b = band(color, 0xFF),
  }
end

-- Alpha compositing "over" operator
-- https://en.wikipedia.org/wiki/Alpha_compositing
function M.composite_over(c0, c1, a0)
  -- NOTE: I'm only using this to overlay onto the background, so a1 is
  -- always 1 and thus a01 is always 1. This simplifies the formula a bit.
  return a0 * c0 + c1 * (1 - a0)
end

---@class zeroknight.Color
local Color = {}
Color.__index = Color

---@param color string|number|table
---@return zeroknight.Color
function Color:new(color)
  vim.validate { color = { color, { 'string', 'number', 'table' } } }
  if type(color) == 'string' or type(color) == 'number' then
    color = M.extract_rgb(color)
  end
  return setmetatable(color, self)
end

-- Create a color based on the main background color of the current colorscheme
function Color:from_background()
  return Color.new(self, vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
end

function Color:__tostring()
  return M.to_hex(bor(lshift(self.r, 16), lshift(self.g, 8), self.b))
end

-- Return a new `Color` that is result of overlaying this color at the given
-- alpha level onto another opaque color, i.e. a background.
---@param onto_color zeroknight.Color
---@param alpha float
function Color:over(onto_color, alpha)
  return Color:new {
    r = M.composite_over(self.r, onto_color.r, alpha),
    g = M.composite_over(self.g, onto_color.g, alpha),
    b = M.composite_over(self.b, onto_color.b, alpha),
  }
end

M.Color = Color
return M
