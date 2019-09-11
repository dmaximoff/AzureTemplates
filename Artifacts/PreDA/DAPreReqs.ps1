# Prevent Server Manager from loading on startup
New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "0x1" –Force

# Install AD DS tools
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools 
Start-Sleep -s 30
# Enable network discovery
netsh advfirewall firewall set rule group=”network discovery” new enable=yes
Start-Sleep -s 30

# Download .Net from github
$url = 'https://raw.githubusercontent.com/dmaximoff/AzureTemplates/master/Artifacts/PreDA/NDP461-KB3102438-Web.exe'
$output = "c:\Packages\NDP461-KB3102438-Web.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)

# Download C++ redist from github
$url = 'https://raw.githubusercontent.com/dmaximoff/AzureTemplates/master/Artifacts/PreDA/vcredist_x86.exe'
$output = "c:\Packages\vcredist_x86.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)

# Download SQL tools from github
$url = 'https://raw.githubusercontent.com/dmaximoff/AzureTemplates/master/Artifacts/PreDA/SQLServer2005_BC_x64.msi'
$output = "c:\Packages\SQLServer2005_BC_x64.msi"
(New-Object System.Net.WebClient).DownloadFile($url, $output)

# Install MS Redistributable C++
c:\Packages\vcredist_x86.exe /q
Start-Sleep -s 15
# Install .Net 4.6 SP1
C:\Packages\NDP461-KB3102438-Web.exe /q /norestart
Start-Sleep -s 15
# Install SQL Backward Compatibility
C:\Packages\SQLServer2005_BC_x64.msi /q
Start-Sleep -s 15

# Install IIS
Install-WindowsFeature -name Web-Server -ComputerName localhost  -IncludeAllSubFeature -IncludeManagementTools

# Mount Azure file share
#Save the password so the drive will persist on reboot
Invoke-Expression -Command "cmdkey /add:adalab7435.file.core.windows.net /user:Azure\adalab7435 /pass:cDbn182dElr9qMSs85n7nchyGEmbvGZw+6BVKsnfkIhZ+8SySm/gBt9rLMCfK7caquYSmPzjVIurXW04iTeTTw=="
# Mount  dams-releases
New-PSDrive -Name y -PSProvider FileSystem -Root "\\adalab7435.file.core.windows.net\dams-releases"
# Mount dams-builds
New-PSDrive -Name Z -PSProvider FileSystem -Root "\\adalab7435.file.core.windows.net\dams-builds"
#exit
