
$File = "c:\packages\DAFileName.msi"

# Disable UAC
$osversion = (Get-CimInstance Win32_OperatingSystem).Version 
$version = $osversion.split(".")[0] 
 
if ($version -eq 10) { 
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 
} ElseIf ($Version -eq 6) { 
    $sub = $version.split(".")[1] 
    if ($sub -eq 1 -or $sub -eq 0) { 
        Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value "0" 
    } Else { 
        Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 
    } 
} ElseIf ($Version -eq 5) { 
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value "0" 
} Else { 
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 
}
 
 # Mount Azure share and copy DA to c:\packages
# Invoke-Expression -Command "cmdkey /add:adalab7435.file.core.windows.net /user:Azure\adalab7435 /pass:cDbn182dElr9qMSs85n7nchyGEmbvGZw+6BVKsnfkIhZ+8SySm/gBt9rLMCfK7caquYSmPzjVIurXW04iTeTTw=="
# New-PSDrive -Name E -PSProvider FileSystem -Root "\\adalab7435.file.core.windows.net\engineering"
# copy e:\repo\DesktopAuthority_11.0.0.463.exe C:\packages

# Add domain\sladmin to local Administrators
$domain = (Get-WmiObject Win32_ComputerSystem).Domain
$domain = $domain.Substring(0, $domain.IndexOf('.'))

$computer = "localhost"
$group = "Administrators"
$user = "sladmin"
$de = [ADSI]"WinNT://$computer/$Group,group"
$de.psbase.Invoke("Add",([ADSI]"WinNT://$domain/$user").path)

Remove-Item -path  C:\ProgramData\Quest  -Recurse 
# Start-Sleep -s 10

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class SFW {
 [DllImport("user32.dll")]
 [return: MarshalAs(UnmanagedType.Bool)]
 public static extern bool SetForegroundWindow(IntPtr hWnd);
}
"@

# Run DA installer as domain\admin
$username = "$domain\sladmin"
$password = "Lionfish1!"
$credentials = New-Object System.Management.Automation.PSCredential -ArgumentList @($username,(ConvertTo-SecureString -String $password -AsPlainText -Force))
Start-Process -FilePath $File -Credential ($credentials)
Start-Sleep -s 10

# Validate DA is running before proceding
#$started = $false
#Do {
#    $status = Get-Process DesktopAuthority_11.0.0.463 -ErrorAction SilentlyContinue
#    If (!($status)) { Write-Host 'Waiting for process to start' ; Start-Sleep -Seconds 1 }
#    Else { Write-Host 'Process has started' ; $started = $true }
#}
#Until ( $started )


# Welcome to DA
(New-Object -ComObject WScript.Shell).AppActivate((get-process DesktopAuthority_11.0.0.463).MainWindowTitle)
Start-Sleep -s 10
$wshell = New-Object -ComObject wscript.shell;
$wshell.SendKeys('{TAB}{TAB}{TAB}{TAB}{UP}{TAB}{TAB}{ENTER}')
Start-Sleep -s 26


# Forces New License Key Required window to foreground
$fw =  (get-process 'DAInstaller').MainWindowHandle
[SFW]::SetForegroundWindow($fw)
Start-Sleep -s 1
$wshell.SendKeys('{ENTER}')
$wshell.SendKeys('{ENTER}')
Start-Sleep -s 16

# Welcome to DA Prereqs 
$fw =  (get-process 'DAInstaller').MainWindowHandle
[SFW]::SetForegroundWindow($fw)
$wshell.SendKeys('{ENTER}')
Start-Sleep -s 4

# Enter DA License key
$fw =  (get-process 'DAInstaller').MainWindowHandle
[SFW]::SetForegroundWindow($fw)
Start-Sleep -s 4
$wshell.SendKeys('{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}')
$wshell.SendKeys('Y5dxKdq6mAnGgwoSADBqFsDl28jENSh7hH3Z5g2rIwvnIrYXGv6D94b{+}bhT1gJto9OlI31Ta7AJD4z2OyJHLl2w1TYKrXSAr3b6uGw==')
$wshell.SendKeys('{TAB}{TAB}{TAB}{TAB}')
$wshell.SendKeys('{ENTER}')
Start-Sleep -s 4

# Set up DB
$fw =  (get-process 'DAInstaller').MainWindowHandle
[SFW]::SetForegroundWindow($fw)
Start-Sleep -s 2
$wshell.SendKeys('{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}')
$wshell.SendKeys('Badger1!')
$wshell.SendKeys('{TAB}')
$wshell.SendKeys('Badger1!')
Start-Sleep -s 2
$wshell.SendKeys('{TAB}{TAB}{TAB}{TAB}{ENTER}')
Start-Sleep -s 8

# File Locations and Backup 
$fw =  (get-process 'DAInstaller').MainWindowHandle
[SFW]::SetForegroundWindow($fw)
Start-Sleep -s 2
$wshell.SendKeys('{ENTER}')

# DA Master Services
$domain = (Get-WmiObject Win32_ComputerSystem).Domain
$domain = $domain.Substring(0, $domain.IndexOf('.'))
$fw =  (get-process 'DAInstaller').MainWindowHandle
[SFW]::SetForegroundWindow($fw)
Start-Sleep -s 2
$wshell.SendKeys('{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}')
$wshell.SendKeys($domain)
$wshell.SendKeys('\sladmin')
$wshell.SendKeys('{TAB}{TAB}{TAB}')
$wshell.SendKeys('Badger1!')
$wshell.SendKeys('{TAB}')
$wshell.SendKeys($domain)
$wshell.SendKeys('\sladmin')
$wshell.SendKeys('{TAB}{TAB}{TAB}')
$wshell.SendKeys('Badger1!')
$wshell.SendKeys('{TAB}{TAB}{ENTER}')
Start-Sleep -s 5

# User or Group
$wshell.SendKeys('{ENTER}')
Start-Sleep -s 5

# Website Config
$wshell.SendKeys('{ENTER}')
Start-Sleep -s 5

# Off Network
$wshell.SendKeys('{ENTER}')
Start-Sleep -s 5

# Certificate
$wshell.SendKeys('{ENTER}')
Start-Sleep -s 5

# Install
$wshell.SendKeys('{ENTER}')
Start-Sleep -S 900





