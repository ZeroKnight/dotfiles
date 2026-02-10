#
# Miscellaneous abbreviations and aliases
#

if status is-interactive
    # Frequent typos
    abbr -a -p anywhere podamn podman
    abbr -a -p anywhere fucntion function

    # Common pipelines/redirects
    abbr -a -p anywhere --set-cursor L '| less'
    abbr -a -p anywhere --set-cursor H '| head'
    abbr -a -p anywhere --set-cursor T '| tail'
    abbr -a -p anywhere --set-cursor G '| grep'
    abbr -a -p anywhere --set-cursor LL '&| less'
    abbr -a -p anywhere --set-cursor !null '%>/dev/null'

    # Prefer color output
    alias diff 'diff --color=auto'
    alias ip 'ip -color=auto'

    # Add some nice defaults to rsync (can disable as needed with --no-<option>)
    alias rsync 'rsync -hhh --partial --info=stats1,progress2,name1'

    abbr -a kssh kitten ssh

    # Prompt to remove destination
    abbr -a ln ln -i

    # Add guardrails to rm, *especially* preserving root
    alias rm 'rm -I --preserve-root'

    # Be verbose and preserve root by default
    alias chmod 'chmod -v --preserve-root'
    alias chown 'chown -v --preserve-root'
    alias chgrp 'chgrp -v --preserve-root'
end
