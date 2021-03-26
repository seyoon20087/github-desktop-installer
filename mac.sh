#!/bin/bash
if [ "$(uname -s)" = Linux ]
then
    echo "GitHub Desktop cannot run on Linux"
    exit 1
fi
[ $UID = 0 ] || exec sudo "$0" "$@"
echo "Downloading GitHub Desktop"
curl -OL "https://central.github.com/deployments/desktop/desktop/latest/darwin" &> /dev/null && mv darwin GitHubDesktop.zip
unzip GitHubDesktop.zip &> /dev/null
if [ -d "/Applications/GitHub Desktop.app" ]
then
    rm -rf "/Applications/GitHub Desktop.app"
fi
mv "GitHub Desktop.app" "/Applications"
echo "Opening GitHub Desktop"
open "/Applications/GitHub Desktop.app"
exit 0
