###
### Shortcuts
###

psg() {
    ps -fp $(pgrep $@)
}
