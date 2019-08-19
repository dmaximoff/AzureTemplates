# Install MS Redistributable C++
.\vcredist_x86.exe /q
# Install .Net 4.6 SP1
NDP461-KB3102436-x86-x64-AllOS-ENU.exe /q /norestart
# Install SQL Backward Compatibility
.\SQLServer2005_BC_x64.msi /q

# Sets Computer Browser service to Automatic and Running
Set-Service -Name Browser -StartupType Automatic
Set-Service -Name Browser -Status Running

