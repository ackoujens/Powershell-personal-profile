# CONFIG
# TODO set-PSReadlineOption not recognized
function Global:Set-MaxWindowSize
{
    if ($Host.Name -match "console")
       {
        $MaxHeight = $host.UI.RawUI.MaxPhysicalWindowSize.Height
        $MaxWidth = $host.UI.RawUI.MaxPhysicalWindowSize.Width

        $MyBuffer = $Host.UI.RawUI.BufferSize
        $MyWindow = $Host.UI.RawUI.WindowSize

        $MyWindow.Height = ($MaxHeight)
        $MyWindow.Width = ($Maxwidth-2)

        $MyBuffer.Height = (9999)
        $MyBuffer.Width = ($Maxwidth-2)

        $host.UI.RawUI.set_bufferSize($MyBuffer)
        $host.UI.RawUI.set_windowSize($MyWindow)
       }

    $CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $CurrentUserPrincipal = New-Object Security.Principal.WindowsPrincipal $CurrentUser
    $Adminrole = [Security.Principal.WindowsBuiltinRole]::Administrator
    If (($CurrentUserPrincipal).IsInRole($AdminRole)){$Elevated = "Administrator"}

    $Title = $Elevated + " $ENV:USERNAME".ToUpper() + ": $($Host.Name) " + $($Host.Version) + " - " + (Get-Date).toshortdatestring()
    $Host.UI.RawUI.set_WindowTitle($Title)
}

function Prompt{
	#write-host "[$(Get-Date -F "HH:mm:ss")]" -ForegroundColor Darkred -NoNewline "$(pwd)> "
  $Host.UI.RawUI.BackgroundColor = ($bckgrnd = 'Black')
  $Host.UI.RawUI.ForegroundColor = 'Darkred'
  $Host.PrivateData.ErrorForegroundColor = 'Red'
  $Host.PrivateData.ErrorBackgroundColor = $bckgrnd
  $Host.PrivateData.WarningForegroundColor = 'Magenta'
  $Host.PrivateData.WarningBackgroundColor = $bckgrnd
  $Host.PrivateData.DebugForegroundColor = 'Yellow'
  $Host.PrivateData.DebugBackgroundColor = $bckgrnd
  $Host.PrivateData.VerboseForegroundColor = 'Green'
  $Host.PrivateData.VerboseBackgroundColor = $bckgrnd
  $Host.PrivateData.ProgressForegroundColor = 'Cyan'
  $Host.PrivateData.ProgressBackgroundColor = $bckgrnd
  Clear-Host
}


# INFO
Write-Host "Current User: " whoami
Write-Host "Powershell V"$PSVersionTable.PSVersion.Major.$PSVersionTable.PSVersion.Minor


# MODULES
# NOTE Requires PS V5
function isModulePresent ($moduleName) {
  if (Get-Module -ListAvailable -Name $moduleName) {
    Write-Host "Module: " $moduleName  " available"
    return $true
  } else {
    Write-Host "Module:" $moduleName " is not installed"
    return $false
  }
}

function installModule ($moduleName) {
  if (!(isModulePresent $moduleName)) {
    Install-Module -Name $moduleName
  }
}

#installModule SMCmdletSnapIn


# UNORGANIZED
function getICTPhoneNo {
  Get-ADUser -Filter * -SearchBase $((Get-ADOrganizationalUnit -Filter {name -eq "Informatica"}).DistinguishedName) -Properties mobile | select name, mobile
}

function Reload-Profile{
    $reload = $true
    . $PROFILE
}
