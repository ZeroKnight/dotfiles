#
# Prompt Settings
#

zprompt_theme='zero'
zprompt_options=()

# Initialize
if (( $+zprompt_theme )); then
  autoload -Uz promptinit && promptinit
  prompt $zprompt_theme $zprompt_options
fi

