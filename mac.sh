#!/bin/bash
CompatibilityRelDoc() {
    echo "Please see the following documentation for more info:
    https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/supported-operating-systems#about-supported-operating-systems"
}
Check_Volume_Version()
{
		volume_version="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion)"
		volume_version_short="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-5)"
	
		volume_build="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductBuildVersion)"

		if [[ ${#volume_version} == "6" ]]; then
			volume_version_short="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-4)"
		fi

		if [[ ${#volume_version_short} == "4" ]]; then
			volume_version_short="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-2)"
		fi
}
Check_Volume_Support()
{
	if ! [[ $volume_version_short == "10.1"[0-5] || $volume_version_short == "11" ]]
	then
		echo "GitHub Desktop requires OS X Yosemite and later."
		CompatibilityRelDoc
		exit 1
	fi
}

if [ "$(uname -s)" = Darwin ]
then
	Check_Volume_Version
	Check_Volume_Support
fi
[ $UID = 0 ] || exec sudo "$0" "$@"
if [ "$(uname -s)" != Darwin ]
then
	curl -fsSL https://raw.githubusercontent.com/seyoon20087/github-desktop-installer/main/linux.sh | bash
	exit 0
fi
echo "Downloading GitHub Desktop"
if [ "$(uname -m)" = "x86_64" ]
then
	curl --request GET "https://central.github.com/deployments/desktop/desktop/latest/darwin" -o ~/Downloads/GitHubDesktop.zip -LO &> /dev/null && unzip ~/Downloads/GitHubDesktop.zip &> /dev/null
elif [ "$(uname -m)" = "arm64" ]
	curl --request GET "https://central.github.com/deployments/desktop/desktop/latest/darwin-arm64" -o ~/Downloads/GitHubDesktop.zip -LO &> /dev/null && unzip ~/Downloads/GitHubDesktop.zip &> /dev/null
fi

if [ -d "/Applications/GitHub Desktop.app" ]
then
    rm -rf "/Applications/GitHub Desktop.app"
fi
mv "GitHub Desktop.app" "/Applications"
echo "Opening GitHub Desktop"
rm -rf ~/Downloads/GitHubDesktop.zip
sleep 1
open "/Applications/GitHub Desktop.app"
exit 0
