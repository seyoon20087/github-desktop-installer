#!/bin/bash
CompatibilityRelDoc() {
    echo "Please see the following documentation for more info:
    https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/supported-operating-systems#about-supported-operating-systems"
}
if [ "$(uname -s)" = Linux ]
then
    echo "GitHub Desktop cannot run on Linux."
    CompatibilityRelDoc
    exit 1
fi
Check_Volume_Version()
{
	#echo -e $(date "+%b %m %H:%M:%S") ${text_progress}"> Checking system version."${erase_style}

		volume_version="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion)"
		volume_version_short="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-5)"
	
		volume_build="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductBuildVersion)"

		if [[ ${#volume_version} == "6" ]]; then
			volume_version_short="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-4)"
		fi

		if [[ ${#volume_version_short} == "4" ]]; then
			volume_version_short="$(defaults read /System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-2)"
		fi

	#echo -e $(date "+%b %m %H:%M:%S") ${move_up}${erase_line}${text_success}"+ Checked system version."${erase_style}
}
Check_Volume_Support()
{
	#echo -e $(date "+%b %m %H:%M:%S") ${text_progress}"> Checking system support."${erase_style}

	if ! [[ $volume_version_short == "10.1"[0-5] || $volume_version_short == "11" ]]; then
		#echo -e $(date "+%b %m %H:%M:%S") ${move_up}${erase_line}${text_success}"+ System support check passed."${erase_style}
	#else
		#echo -e $(date "+%b %m %H:%M:%S") ${text_error}"- System support check failed."${erase_style}
		#echo -e $(date "+%b %m %H:%M:%S") ${text_message}"/ Run this tool on a supported system."${erase_style}

		#Input_On
		#exit
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
open "/Applications/GitHub Desktop.app"
exit 0
