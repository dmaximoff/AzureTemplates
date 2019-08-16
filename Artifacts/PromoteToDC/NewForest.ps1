# Install AD DS tools
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools 
# Enable network discovery
netsh advfirewall firewall set rule group=”network discovery” new enable=yes
# Promote machine to DC
Install-ADDSForest  -domainname domtest.local -SafeModeAdministratorPassword (convertto-securestring "Badger1!" -asplaintext -Force) -Force