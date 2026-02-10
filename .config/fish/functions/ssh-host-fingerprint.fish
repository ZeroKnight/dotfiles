function ssh-host-fingerprint --description 'Print host key fingerprints'
    ssh-keyscan $argv | ssh-keygen -lf -
end
