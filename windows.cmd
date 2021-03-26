reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT goto abort32bit


echo "Downloading file"
powershell (new-object System.Net.WebClient).DownloadFile('https://central.github.com/deployments/desktop/desktop/latest/win32','%Downloads%\GitHubDesktopSetup.exe')
echo "Opening GitHub Desktop Installer"
C:\tmp\GitHubDesktopSetup.exe
erase C:\tmp\GitHubDesktopSetup.exe
exit /b 0

:abort32bit
echo "You must have a 64-bit operating system to run GitHub Desktop."
compatibilityRelDoc
exit /b 1

:compatibilityRelDoc
echo "Please see the following documentation for more info:"
echo "https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/supported-operating-systems#about-supported-operating-systems"