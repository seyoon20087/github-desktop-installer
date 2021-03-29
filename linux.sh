#!/bin/bash

[ $UID = 0 ] || exec sudo "$0" "$@"
if [ "$(uname -s)" != Darwin ]
then
	if [ -d /usr/bin/dpkg ]
	then
		curl -OL https://github.com/shiftkey/desktop/releases/download/release-2.6.6-linux1/GitHubDesktop-linux-2.6.6-linux1.deb &> /dev/null && /usr/bin/dpkg -i GitHubDesktop-linux-2.6.6-linux1.deb &> /dev/null || apt install -f -y &> /dev/null
	elif [ -d /usr/bin/rpm ]
    then
	    curl -OL https://github.com/shiftkey/desktop/releases/download/release-2.6.6-linux1/GitHubDesktop-linux-2.6.6-linux1.rpm &> /dev/null && /usr/bin/rpm -i GitHubDesktop-linux-2.6.6-linux1.rpm
	else
		echo "Your Linux machine is not supported for GitHub Desktop."
		exit 1
	fi
elif [ "$(uname -s)" = Darwin ]
then
    curl -fsSL https://raw.githubusercontent.com/seyoon20087/github-desktop-installer/main/mac.sh | bash
    exit 0
fi

exit 0
