# Completely remove SMBv1 support
# https://blogs.technet.microsoft.com/josebda/2015/04/21/the-deprecation-of-smb1-you-should-be-planning-to-get-rid-of-this-old-smb-dialect/
Remove-WindowsFeature FS-SMB1



# Disable server manager launch at logon
New-ItemProperty -Path 'HKLM:\Software\Microsoft\ServerManager' -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value '0x1' -Force

# Set shell to PowerShell instead of cmd 
# launch sconfig at logon
Set-ItemProperty -Path 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name Shell -Value 'powershell.exe -noexit -Command "Set-Location ${Env:USERPROFILE};start sconfig"'

# Harden user enumeration via NetSession
.\Common\NetCease\NetCease.ps1
Restart-Service -Name LanmanServer -Force

# Harden user enumeration via SAM-Remote (SAMR) protocol
.\Server-2016\SAMRi10\SAMRi10.ps1
