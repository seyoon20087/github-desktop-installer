@echo off
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT goto abort32bit
if %OS%==64BIT goto startinstall

:startinstall
echo "Downloading file"
curl --request GET "https://central.github.com/deployments/desktop/desktop/latest/win32" --ouput %Downloads%\GitHubDesktopSetup.exe -LO
echo "Opening GitHub Desktop Installer"
%Downloads%\GitHubDesktopSetup.exe
exit /b 0

:abort32bit
echo "You must have a 64-bit operating system to run GitHub Desktop."
echo "Please see the following documentation for more info:"
echo "https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/supported-operating-systems#about-supported-operating-systems"
exit /b 1
