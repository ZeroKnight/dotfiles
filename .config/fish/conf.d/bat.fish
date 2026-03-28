#
# bat configuration
#

# Since Delta uses BAT_THEME, we get automatic theme selection for it as well
function _update_bat_theme --description 'Set BAT_THEME based on $fish_terminal_color_theme' --on-variable fish_terminal_color_theme
    switch $fish_terminal_color_theme
        case dark
            set -gx BAT_THEME tokyonight_$tokyonight_variant
        case light
            set -gx BAT_THEME tokyonight_day
    end
end
