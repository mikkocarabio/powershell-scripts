# ***WARNING***
# This script stores password in clear text, please use with caution!



# Define the functions to be called
function Option1 {
    Write-Host "You selected option 1"
    $username = Read-Host -Prompt "Enter the username for auto-login"
    $password = Read-Host -Prompt "Enter the password for auto-login" -AsSecureString
    $domain = Read-Host - Prompt "Enter the domain name"
    $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName' -Value $username
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultPassword' -Value $password
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoAdminLogon' -Value '1'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultDomainName' -Value $domain
    Write-Host "Successfully added autologin registry keys!"
    Write-Host "Username: $username"
    Write-Host "DomainName: $domain"
    Write-Host "AutoAdminLogon: 1"
    Write-Host "`nPress any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Write-Host "`n"


}

function Option2 {
    $registryPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
    if (Test-Path "$registryPath\DefaultUserName") {
        Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName'
    }
    else {
        Write-Host "Registry string DefaultUsername does not exist!"
    }
    if (Test-Path "$registryPath\DefaultPassword") {
        Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultPassword'
    }
    else {
        Write-Host "Registry string DefaultPassword does not exist!"
    }
    if (Test-Path "$registryPath\DefaultDomainName") {
        Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultDomainName'
    }
    else {
        Write-Host "Registry string DefaultDomainName does not exist!"
    }
    if (Test-Path "$registryPath\AutoAdminLogon") {
        Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoAdminLogon'
    }
    else {
        Write-Host "Registry string AutoAdminLogon does not exist!"
    }
    Write-Host "Successfully Disabled Autologin!"
    Write-Host "`nPress any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Write-Host "`n"
}

# Show the option menu
Write-Host "***WARNING***" -ForegroundColor Red
Write-Host "THIS SCRIPT STORES PASSWORD IN CLEAR TEXT, PLEASE USE WITH CAUTION!!" -ForegroundColor Red
Write-Host "`nPress any key to continue..." 
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host "`n"
 
function Show-OptionMenu {
    $options = @(
        "- Autologin Setup",
        "- Disable Autologin",
        "- Exit"
    )
    $index = 1
    Write-Host "Please select an option:"
    foreach ($option in $options) {
        Write-Host "$index. $option"
        $index++
    }

    # Get the selected option from the user
    $selectedOption = Read-Host "Enter the number of the option you want to select"

    # Call the corresponding function
    switch ($selectedOption) {
        "1" { Option1 }
        "2" { Option2 }
        "3" { Exit }
        default { 
            Write-Host "`nInvalid option selected." -ForegroundColor Red
            Write-Host "`nPress any key to continue..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            Write-Host "`n"
        }
    }
}

# Keep showing the option menu until the user selects "Exit"
while ($selectedOption -ne "3") {
    Show-OptionMenu
}
