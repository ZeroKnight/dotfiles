#!/bin/bash

# This most likely doesn't need to be changed
REMOTE_REPO='https://redeclipse.svn.sourceforge.net/svnroot/redeclipse'

# Set this to the local Red Eclipse repo path
LOCAL_REPO='/home/reserver/redeclipse-svn'

# Path to the SVN Red Eclipse server files (ie. servinit.cfg)
SERVFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get revision info
echo -n 'Acquiring remote revision number...'
REMOTE_REV=$(svn info $REMOTE_REPO | grep '^Revision:' | awk '{print $2}')
echo -ne "DONE\nAcquiring local revision number..."
LOCAL_REV=$(svn info $LOCAL_REPO | grep '^Revision:' | awk '{print $2}')
echo 'DONE'

# Compare revisions
if [[ $REMOTE_REV == $LOCAL_REV ]]; then
    echo "Server is running the latest revision (r${REMOTE_REV})"
    exit 0
elif [[ $REMOTE_REV < $LOCAL_REV ]]; then
    # Not sure how this would happen
    echo "Local revision is newer than the remote revision (L: r${LOCAL_REV}, R: r${REMOTE_REV})"
    echo 'User intervention required, sending mail to server maintainers'
    mail -s 'WazuClan Red Eclipse SVN Updater failed' xzeroknightx@gmail.com<<EOM

Unable to update SVN server as the local revision is newer than the remote revision (L: r${LOCAL_REV}, R: r${REMOTE_REV})

Manual intervention required
EOM
    exit 5
else
    # Get HEAD revision
    cd $LOCAL_REPO
    sudo -u reserver svn up

    # Compile server binary
    cd src
    make -j server
    make install-server
    
    # Write revision number to serverdesc
    sed -i -r "s/\(r[0-9]+\)/(r${REMOTE_REV})/" $SERVFILES/servinit.cfg

    # (Re)start server
    #TOOD: be able to start if down
    $SERVFILES/../reservctl restart svn

fi
