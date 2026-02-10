function fman --description 'Find man pages with fzf'
    man -k . | fzf -1 --prompt 'man> ' --preview 'man {1}' --query "$argv" \
             | awk '{print $1}' | xargs -r man
end
