# Spécifiez le chemin de votre dossier partagé
$basePath = "K:\DossiersDepartement"

# Importez le module Active Directory (si ce n'est pas déjà fait)
Import-Module ActiveDirectory

# Récupérer toutes les Unités Organisationnelles (OU) dans Active Directory
$OUs = Get-ADOrganizationalUnit -Filter * -Properties Name, DistinguishedName

# Pour chaque OU, créez un dossier et définissez les permissions NTFS
foreach ($OU in $OUs) {
    # Nom de l'OU
    $departmentName = $OU.Name
    
    # Créer le dossier correspondant au département si nécessaire
    $folderPath = Join-Path -Path $basePath -ChildPath $departmentName
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath
        Write-Host "Dossier créé pour l'OU : $departmentName"
    } else {
        Write-Host "Le dossier pour l'OU $departmentName existe déjà."
    }
    
    # Récupérer les utilisateurs de l'OU
    $users = Get-ADUser -Filter * -SearchBase $OU.DistinguishedName
    
    # Définir les permissions NTFS pour que seul les membres de l'OU aient accès
    $acl = Get-Acl $folderPath

    # Supprimer les permissions existantes
    $acl.SetAccessRuleProtection($true, $false) # Active protection et empêche l'héritage

    foreach ($user in $users) {
        $userName = $user.SamAccountName
        $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
            "$env:COMPUTERNAME\$userName", 
            "Modify", 
            "ContainerInherit, ObjectInherit", 
            "None", 
            "Allow"
        )
        $acl.AddAccessRule($accessRule)
    }
    
    # Appliquer les nouvelles permissions
    Set-Acl -Path $folderPath -AclObject $acl
    Write-Host "Permissions définies pour les utilisateurs de l'OU : $departmentName"
}

Write-Host "Script terminé"
