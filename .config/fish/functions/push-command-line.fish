function push-command-line --description 'Push commandline onto stack and start a new one'
    test -z "$(commandline)"; and return

    # Push current command line and clear the buffer
    set -ga __zero_cmdline_stack (commandline)
    commandline ""

    # Set up ephemeral callback to restore the previous cmdline and remove
    # itself once the stack is empty
    if test (count $__zero_cmdline_stack) -eq 1
        function pop-command-line --on-event fish_postexec
            commandline $__zero_cmdline_stack[-1]
            set -ge __zero_cmdline_stack[-1]
            if test (count $__zero_cmdline_stack) -eq 0
                functions -e pop-command-line
            end
        end
    end
end
