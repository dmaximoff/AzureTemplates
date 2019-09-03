# Save the password so the drive will persist on reboot
Invoke-Expression -Command "cmdkey /add:adalab7435.file.core.windows.net /user:Azure\adalab7435 /pass:cDbn182dElr9qMSs85n7nchyGEmbvGZw+6BVKsnfkIhZ+8SySm/gBt9rLMCfK7caquYSmPzjVIurXW04iTeTTw=="
# Mount  dams-releases
New-PSDrive -Name x -PSProvider FileSystem -Root "\\adalab7435.file.core.windows.net\dams-releases"
# Mount dams-builds
New-PSDrive -Name y -PSProvider FileSystem -Root "\\adalab7435.file.core.windows.net\dams-builds"

New-PSDrive -Name Z -PSProvider FileSystem -Root "\\adalab7435.file.core.windows.net\engineering"

copy z:\repo\DA11AutomatedInstaller.exe c:\packages\
# Install DA 11
c:\packages\DA11AutomatedInstaller.exe
