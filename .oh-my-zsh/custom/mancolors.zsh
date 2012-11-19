man() {

    # Less Colors for Man Pages:
    # _mb = begin blinking
    # _md = begin bold
    # _me = end mode
    # _se = end standout-mode
    # _so = begin standout-mode - info box
    # _ue = end underline
    # _us = begin underline

	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

