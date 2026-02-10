#
# Directory jumping with z.lua
#

if not set -Uq ZLUA_SCRIPT ZLUA_LUAEXE _ZL_DATA
    set -Ux ZLUA_SCRIPT $HOME/.local/opt/zlua/z.lua
    set -Ux ZLUA_LUAEXE (command -s luajit; or command -s lua)
    set -Ux _ZL_DATA $HOME/.local/state/zlua
end

if not begin
        status is-interactive
        and test -e $ZLUA_LUAEXE
        and test -e $ZLUA_SCRIPT
    end
    return
end

test -d (path dirname $_ZL_DATA); or mkdir -p (path dirname $_ZL_DATA)

set -gx _ZL_CD cd
set -gx _ZL_EXCLUDE_DIRS (string join ',' /tmp)
set -gx _ZL_MATCH_MODE 1 # Use enhanced matching

abbr -a zb z -b # Restrict to parents of CWD (z *b*ackward)
abbr -a zz z -c # Restrict to subdirectories of CWD

if command -q fzf
    if command -q eza
        set -f preview_cmd eza -1 --color=always --group-directories-first --icons
    else
        set -f preview_cmd ls -1 --color=always --group-directories-first
    end
    set -gx _ZL_FZF_FLAG "+s -1 --info=inline-right --prompt 'Jump (z.lua) > ' --preview '$preview_cmd {2}'"
    abbr -a zi z -I
else
    abbr -a zi z -i
end

$ZLUA_LUAEXE $ZLUA_SCRIPT --init fish once | source
