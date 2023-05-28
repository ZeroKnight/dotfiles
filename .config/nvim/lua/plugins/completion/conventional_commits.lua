-- Simple cmp-nvim source that returns Conventional Commit types

local commit_types = {
  feat = {
    description = "A new feature. Any change to the code that isn't a `fix` or `refactor`.\n\nCorrelates with the `MINOR` version in **SemVer**.",
    title = 'Features',
  },
  fix = {
    description = 'A bug fix. Any change to the code that specifically fixes a bug and does not add new functionality.\n\nCorrelates with the `PATCH` version in **SemVer**.',
    title = 'Bug Fixes',
  },
  docs = {
    description = 'Documentation only changes',
    title = 'Documentation',
  },
  style = {
    description = 'Formatting and styling changes. Such changes do not affect the semantic meaning of the code (white-space, formatting, missing semi-colons, etc)',
    title = 'Styles',
  },
  refactor = {
    description = 'A code change that neither fixes a bug nor adds a feature',
    title = 'Code Refactoring',
  },
  perf = {
    description = 'A code change that improves performance. Not necessarily a feature or bug fix.',
    title = 'Performance Improvements',
  },
  test = {
    description = 'Adding missing tests or correcting existing tests',
    title = 'Tests',
  },
  build = {
    description = 'Changes that affect the build system or external dependencies',
    title = 'Builds',
  },
  ci = {
    description = 'Changes to CI/CD configuration files and scripts',
    title = 'Continuous Integration',
  },
  chore = {
    description = "Other changes that don't modify src or test files",
    title = 'Chores',
  },
  revert = {
    description = 'Reverts a previous commit',
    title = 'Reverts',
  },
}

local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

function source:is_available()
  return vim.bo.filetype == 'gitcommit'
end

function source:get_keyword_pattern()
  -- Commit type will only ever be at the start of a line
  return [[^\k\+]]
end

function source:complete(_, callback)
  local items = {}
  -- Should only complete for the subject line
  if vim.api.nvim_win_get_cursor(0)[1] == 1 then
    for type_name, type_data in pairs(commit_types) do
      table.insert(items, {
        label = type_name,
        documentation = {
          kind = 'markdown',
          value = string.format('**%s**\n\n%s', type_data.title, type_data.description),
        },
      })
    end
  end
  callback { items = items, isIncomplete = false }
end

require('cmp').register_source('cc_types', source.new())
