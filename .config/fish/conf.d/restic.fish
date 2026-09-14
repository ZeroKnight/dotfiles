# Restic

command -q restic; or return

function restic_set_vars --description 'Prompt for RESTIC_REPOSITORY and RESTIC_PASSWORD'
    read --global --export --prompt-str "$(set_color green)RESTIC_REPOSITORY$(set_color normal)> " RESTIC_REPOSITORY
    read --global --export --silent --prompt-str "$(set_color green)RESTIC_PASSWORD$(set_color normal)> " RESTIC_PASSWORD
end
