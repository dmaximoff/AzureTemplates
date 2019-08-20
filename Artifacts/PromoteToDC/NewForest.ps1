# Promote machine to DC
Install-ADDSForest  -domainname testdom.local -SafeModeAdministratorPassword (convertto-securestring "Badger1!" -asplaintext -Force) -Force
Start-Sleep -s 60


