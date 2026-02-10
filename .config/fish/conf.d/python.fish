# Python settings, aliases, and helpers

# Prefer python3. Useful for systems that still default python => python2
abbr -a python python3
abbr -a py python3
abbr -a pip pip3
abbr -a pydoc pydoc3

abbr -a ipy ipython
abbr -a pdb python3 -m pdb

if command -q virtualenv
    abbr -a venv virtualenv
else
    abbr -a venv python3 -m venv
end

# venv names for auto-detection
set -g python_venv_names .venv venv

function __python_auto_venv -v PWD --description 'Automatically activate/deactivate Python venv on cd'
    if set -q VIRTUAL_ENV
        set -l venv_parent (path resolve $VIRTUAL_ENV | path dirname)
        string match -q "$venv_parent*" $PWD; or deactivate
    else
        for venv_dir in $python_venv_names
            if test -d "$PWD/$venv_dir"
                source "$PWD/$venv_dir/bin/activate.fish"
                return
            end
        end
    end
end
