#!/bin/bash

# This most likely doesn't need to be changed
REMOTE_REPO='https://redeclipse.svn.sourceforge.net/svnroot/redeclipse'

# Set this to the local Red Eclipse repo path
LOCAL_REPO='.'

# Path to the SVN Red Eclipse server files (ie. servinit.cfg)
SERVFILES='/home/reserver/settings/svn'

# Get revision info
REMOTE_REV=$(svn info $REMOTE_REPO | grep '^Revision:' | awk '{print $2}')
LOCAL_REV=$(svn info $LOCAL_REPO | grep '^Revision:' | awk '{print $2}')

# Compare revisions
if [ "$REMOTE_REV" -eq "$LOCAL_REV" ]; then
    echo "Server is running the latest revision (r${REMOTE_REV})"
    exit 0
else
    # Get HEAD revision
    cd $LOCAL_REPO
    sudo -u reserver svn up

    # Compile server binary
    cd src
    make -j server
    make install-server
    
    # Write revision number to serverdesc
    sed -i -r "s/\(r[0-9]+\)/(r${REMOTE_REV})/" $SERVFILES/servexec.cfg

    # Restart server
    sudo $SERVFILES/run.sh -r
fi
