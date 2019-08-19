# Install MS Redistributable C++
.\vcredist_x86.exe /q
# Install .Net 4.6 SP1
NDP461-KB3102436-x86-x64-AllOS-ENU.exe /q /norestart
# Install SQL Backward Compatibility
.\SQLServer2005_BC_x64.msi /q

# Sets Computer Browser service to Automatic and Running
Set-Service -Name Browser -StartupType Automatic
Set-Service -Name Browser -Status Running

# Mount Azure file share
# Save the password so the drive will persist on reboot
Invoke-Expression -Command "cmdkey /add:adalab7435.file.core.windows.net /user:Azure\adalab7435 /pass:cDbn182dElr9qMSs85n7nchyGEmbvGZw+6BVKsnfkIhZ+8SySm/gBt9rLMCfK7caquYSmPzjVIurXW04iTeTTw=="
# Mount  dams-releases
New-PSDrive -Name Z -PSProvider FileSystem -Root "\\adalab7435.file.core.windows.net\dams-releases"
# Mount dams-builds
New-PSDrive -Name Z -PSProvider FileSystem -Root "\\adalab7435.file.core.windows.net\dams-builds"
