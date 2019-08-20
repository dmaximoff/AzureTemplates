# Promote machine to DC
Install-ADDSForest  -domainname domtest.local -SafeModeAdministratorPassword (convertto-securestring "Badger1!" -asplaintext -Force) -Force
Start-Sleep -s 60
# Install AD DS tools
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools 
Start-Sleep -s 30
# Enable network discovery
netsh advfirewall firewall set rule group=”network discovery” new enable=yes
Start-Sleep -s 30

