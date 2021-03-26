#!/bin/bash
CompatibilityRelDoc() {
    echo "Please see the following documentation for more info:
    https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/supported-operating-systems#about-supported-operating-systems"
}
if [ "$(uname -s)" != Darwin ]
then
    echo "GitHub Desktop cannot run on Linux."
    CompatibilityRelDoc
    exit 1
fi
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

Check_Volume_Version
Check_Volume_Support
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
rm -rf GitHubDesktop.zip
open "/Applications/GitHub Desktop.app"
exit 0
