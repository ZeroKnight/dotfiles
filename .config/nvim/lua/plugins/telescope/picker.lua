-- Custom Telescope Pickers

local M = {}

-- Pick from Neovim configuration files
function M.nvim_config()
  require('telescope.builtin').find_files {
    prompt_title = 'Neovim Configuration',
    cwd = vim.fn.stdpath 'config',
    layout_strategy = 'flex',
    layout_config = {
      horizontal = {
        preview_width = 0.6,
      },
    },
  }
end

-- Pick from Neovim logs
function M.nvim_logs()
  require('telescope.builtin').find_files {
    prompt_title = 'Neovim Log Files',
    cwd = vim.fn.stdpath 'cache',
    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.6,
    },
  }
end

-- Pick from Neovim runtime
function M.nvim_runtime()
  require('telescope.builtin').find_files {
    prompt_title = 'Neovim Runtime Files',
    cwd = vim.fn.expand '$VIMRUNTIME',
    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.6,
    },
  }
end

-- Pick from Zsh configuration files
function M.zsh_config()
  require('telescope.builtin').find_files {
    prompt_title = 'Zsh Configuration',
    cwd = vim.fn.expand '$ZSH',
    layout_strategy = 'flex',
  }
end

-- Browse ~/Projects
function M.projects()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = 'Projects',
    cwd = '~/Projects',
  }
end

-- Pick a directory from z.lua
function M.z()
  require('telescope').extensions.z.list {
    cmd = { vim.o.shell, '-c', string.format('%s %s -l', vim.env.ZLUA_LUAEXE, vim.env.ZLUA_SCRIPT) },
  }
end

-- Pick a snippet
function M.snippets()
  require('telescope').extensions.luasnip.luasnip { require('telescope.themes').get_ivy() }
end

return setmetatable(M, {
  __index = function(_, k)
    local a, b = unpack(vim.split(k, '.', { plain = true }))
    if b ~= nil then
      return require('telescope').extensions[a][b]
    else
      return require('telescope.builtin')[k]
    end
  end,
})
