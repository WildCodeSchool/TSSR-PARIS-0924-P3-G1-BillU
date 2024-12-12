# Charger le fichier de configuration CSV
$configPath = ".\Config_ADDS.csv"
$config = Import-Csv -Path $configPath

# Extraire les valeurs depuis le CSV
$ServerName = $config.ServerName
$IPAddress = $config.IPAddress
$DNSServer = $config.DNSServer
$DomainName = $config.DomainName
$DomainAdmin = $config.DomainAdmin
$DomainPassword = $config.DomainPassword

# Installation du rôle AD-DS
Write-Host "Installation du rôle AD-DS..." -ForegroundColor Green
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Verbose

# Vérification de l'installation
if (-not (Get-WindowsFeature -Name AD-Domain-Services).Installed) {
    Write-Host "Erreur : Le rôle AD-DS n'a pas été installé." -ForegroundColor Red
    exit 1
}

Write-Host "Le rôle AD-DS a été installé avec succès." -ForegroundColor Green

# Configuration réseau
Write-Host "Configuration de l'adresse IP et du DNS..." -ForegroundColor Green
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $DNSServer
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $DNSServer

# Ajout au domaine existant
Write-Host "Ajout du serveur au domaine existant : $DomainName" -ForegroundColor Green
$SecurePassword = ConvertTo-SecureString $DomainPassword -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($DomainAdmin, $SecurePassword)

Add-Computer -DomainName $DomainName -Credential $Credential -Force -Verbose

# Redémarrage pour appliquer les modifications
Write-Host "Redémarrage du serveur pour finaliser l'ajout au domaine..." -ForegroundColor Green
Restart-Computer -Force
