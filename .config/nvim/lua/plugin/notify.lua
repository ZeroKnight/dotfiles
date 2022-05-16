-- notify configuration

local notify = require 'notify'
local Color = require('colorbuddy.color').Color

local diag = require 'zeroknight.config.diagnostic'
local util = require 'zeroknight.util'

vim.notify = notify

local diag_icons = {}
for severity, icon in pairs(diag.icons()) do
  diag_icons[string.upper(severity)] = icon
end

notify.setup {
  icons = diag_icons,
  timeout = 5000,
}

-- Match existing diagnostic colors
for _, severity in ipairs { 'Error', 'Warn', 'Info' } do
  local diag_name = string.format('Diagnostic%s', severity)
  local col = Color.new(diag_name, diag.severity[severity].color):saturate(0.2):dark(0.25):to_rgb()

  util.cmdf([[hi! link Notify%sTitle %s]], string.upper(severity), diag_name)
  util.cmdf([[hi! link Notify%sIcon %s]], string.upper(severity), diag_name)
  util.cmdf([[hi! Notify%sBorder guifg=%s]], string.upper(severity), col)
end
