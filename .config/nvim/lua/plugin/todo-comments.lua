-- Todo-Comments configuration

local todo = require 'todo-comments'

todo.setup {
  -- Manually set everything since I want tags in certain categories
  merge_keywords = false,

  colors = {
    default = { 'Statement', '#7c3aed' },
    error = { 'DiagnosticError', '#dc2626' },
    warn = { 'DiagnosticWarn', '#fbbf24' },
    info = { 'DiagnosticInfo', '#2563eb' },
    hint = { 'DiagnosticHint', '#10b981' },
  },

  keywords = {
    TODO = { icon = ' ', color = 'info', alt = { 'TBD', 'TEST' } },
    FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'FIXIT', 'BUG', 'DEBUG', 'ISSUE' } },
    HACK = { icon = ' ', color = 'warn', alt = { 'XXX' } },
    NOTE = { icon = ' ', color = 'hint', alt = { 'NOTICE', 'INFO' } },
    IDEA = { icon = ' ', color = 'hint' },
    WARN = { icon = ' ', color = 'warn', alt = { 'WARNING', 'DEPRECATED', 'ATTENTION', 'ALERT', 'DANGER', 'WTF' } },
    PERF = { icon = ' ', color = 'default', alt = { 'PERFORMANCE', 'OPTI', 'OPTIMIZE', 'OPTIMIZATION' } },
  },
}
