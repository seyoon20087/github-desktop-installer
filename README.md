<h1>GitHub Desktop Installer</h1>

<h2>Instructions for macOS</h2>
Execute this command in Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/seyoon20087/github-desktop-installer/main/mac.sh | bash
```

And when prompted, enter your password.

<h2>Instructions for Windows</h2>

1. Open Command Prompt with administrator privileges.

2. Execute these commands in the command prompt:

```cmd
powershell (new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/seyoon20087/github-desktop-installer/main/windows.cmd','%Downloads%\GitHubDesktopInstaller.cmd')
%Downloads%\GitHubDesktopInstaller.cmd
```
