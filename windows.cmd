echo "Downloading file"
powershell $client.DownloadFile("https://central.github.com/deployments/desktop/desktop/latest/win32","C:\tmp\GitHubDesktopSetup.exe")
powershell (new-object System.Net.WebClient).DownloadFile('https://central.github.com/deployments/desktop/desktop/latest/win32','%Downloads%\GitHubDesktopSetup.exe')
echo "Opening GitHub Desktop Installer"
C:\tmp\GitHubDesktopSetup.exe
erase C:\tmp\GitHubDesktopSetup.exe
exit /b 0
