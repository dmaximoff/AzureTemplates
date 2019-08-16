# Promote machine to DC
Install-ADDSForest  -domainname domtest.local -SafeModeAdministratorPassword (convertto-securestring "Badger1!" -asplaintext -Force) -Force