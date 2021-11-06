-- Utilities for playing with colors

local band, bor, lshift, rshift = bit.band, bit.bor, bit.lshift, bit.rshift

local M = {}

function M.to_hex(color)
  -- Convert an integer color into hexadecimal format
  if type(color) == 'number' then
    return string.format('#%06x', color)
  end
  error 'color must be a number'
end

function M.extract_rgb(color)
  -- Break a given color into separate Red/Green/Blue values
  if type(color) == 'string' then
    color = tonumber(string.gsub(color, '#', ''), 16)
  end
  return {
    r = band(rshift(color, 16), 0xFF),
    g = band(rshift(color, 8), 0xFF),
    b = band(color, 0xFF),
  }
end

function M.composite_over(c0, c1, a0)
  -- Alpha compositing "over" operator
  -- https://en.wikipedia.org/wiki/Alpha_compositing
  -- NOTE: I'm only using this to overlay onto the background, so a1 is
  -- always 1 and thus a01 is always 1. This simplifies the formula a bit.
  return a0 * c0 + c1 * (1 - a0)
end

local Color = {}
Color.__index = Color

function Color:new(color)
  if type(color) == 'string' or type(color) == 'number' then
    color = M.extract_rgb(color)
  end
  local obj = vim.tbl_extend('error', {}, color)
  return setmetatable(obj, self)
end

function Color:from_background()
  return Color.new(self, vim.api.nvim_get_hl_by_name('Normal', true).background)
end

function Color:__tostring()
  return M.to_hex(bor(lshift(self.r, 16), lshift(self.g, 8), self.b))
end

function Color:over(onto_color, alpha)
  -- Return a new Color that is result of overlaying this color at the given
  -- alpha level onto another opaque color, i.e. a background.
  return Color:new {
    r = M.composite_over(self.r, onto_color.r, alpha),
    g = M.composite_over(self.g, onto_color.g, alpha),
    b = M.composite_over(self.b, onto_color.b, alpha),
  }
end

M.Color = Color
return M
