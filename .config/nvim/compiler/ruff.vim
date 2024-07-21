let current_compiler = 'ruff'

CompilerSet makeprg=ruff\ check\ --quiet\ --output-format=concise\ --no-fix
CompilerSet errorformat=
    \%E%f:%l:%c:\ PLE%*\\d\ %m,
    \%E%f:%l:%c:\ E%*\\d\ %m,
    \%W%f:%l:%c:\ %m
