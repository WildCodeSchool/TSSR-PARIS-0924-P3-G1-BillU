# Demander la machine d'intervention
Clear-Host
# Définition des couleurs
$RED = "`e[31m"
$BLUE = "`e[34m"
$GREEN = "`e[32m"
$NC = "`e[0m"  # Aucune couleur

# Fonction de log avec gestion du niveau de criticité et de l'Event ID
function Write-Log {
    param (
        [string]$Message,
        [string]$Severity = "INFO",  # INFO, ALERT, ERROR
        [int]$EventID = 1000         # Par défaut ID d'événement = 1000
    )
    $LOG_DATE = Get-Date -Format "yyyy-MM-dd"
    $LOG_FILE = "$LogDirectory\log_evt_$LOG_DATE.log"
    
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logMessage = "$timestamp - [$Severity] (Event ID: $EventID) - $Message"
    
    # Enregistrement dans le fichier de log
    Add-Content -Path $LOG_FILE -Value $logMessage
    
    # Affichage également dans la console
    Write-Host $logMessage
}


# Fonction pour gérer le Menu utilisateur
function Menu-GestionUser {
    while ($true) {
        Clear-Host
        Write-Host "===== Menu de l'utilisateur =====" -ForegroundColor Red
        Write-Output "1) Création et mise à jour auto des utilisateurs"
        Write-Output "2) Modification manuel des utilisateurs"
        Write-Output "3) Desactivation de l'utilisateur"
        Write-Output "4) Résactivation de l'utilisateur"
        Write-Output "5) Revenir au menu principal"
        Write-Output "6) Quitter"

        $choice = Read-Host -Prompt "Choisissez une option"

        switch ($choice) {
            1 { C:\Users\Administrator\Documents\CreationUser.ps1 }
            2 { C:\Users\Administrator\Documents\ModifyUser.ps1 }
            3 { C:\Users\Administrator\Documents\DisableUser.ps1 }
            4 { C:\Users\Administrator\Documents\ReactiveUser.ps1 }
            5 { return  }
            6 { exit }
            default { Write-Output "Option incorrecte" }
        }
    }
}

# Fonction pour gérer le Menu Gestion de l'ordinateur
function Menu-GestionComputer {
    while ($true) {
        Clear-Host
        Write-Host "===== Menu de l'ordinateur =====" -ForegroundColor Red
        Write-Output "1) Création et mise à jour des ordinateurs"
        Write-Output "2) Modification d'un ordinateurs"
        Write-Output "3) Desactivation d'un ordinateur"
        Write-Output "4) Revenir au menu principal"
        Write-Output "5) Quitter"

        $choice = Read-Host -Prompt "Choisissez une option"

         switch ($choice) {
            1 { C:\Users\Administrator\Documents\creationComputer.ps1 }
            2 { C:\Users\Administrator\Documents\modifyUser.ps1 }
            3 { C:\Users\Administrator\Documents\disableUser.ps1 }
            4 { return  }
            5 { exit }
            default { Write-Output "Option incorrecte" }
        }
    }
}



# Fonction pour gérer le Menu groupes
function Menu-GestionGroup {
    while ($true) {
        Clear-Host
        Write-Host "===== Menu de l'utilisateur =====" -ForegroundColor Red
        Write-Output "1) Création et mise à jour des groupes"
        Write-Output "2) Modification du nom de groupes"
        Write-Output "3) Desactivation de groupe"
        Write-Output "4) Modification des membres du groupes"
        Write-Output "5) Revenir au menu principal"
        Write-Output "6) Quitter"

        $choice = Read-Host -Prompt "Choisissez une option"

         switch ($choice) {
            1 { C:\Users\Administrator\Documents\creationGroup.ps1 } 
            2 { C:\Users\Administrator\Documents\modifyGroupName.ps1 }
            3 { C:\Users\Administrator\Documents\disableGroup.ps1 }
            4 { C:\Users\Administrator\Documents\modifyGroupMember.ps1 }
            5 { return  }
            6 { exit }
            default { Write-Output "Option incorrecte" }
        }
    }
}




# Fonction pour gérer le Menu des OU
function Menu-GestionOU {
    while ($true) {
        Clear-Host
        Write-Host "===== Menu des OU =====" -ForegroundColor Red
        Write-Output "1) Création et mise à jour des OU"
        Write-Output "2) Modification de l'OU"
        Write-Output "3) Desactivation de l'OU"
        Write-Output "4) Revenir au menu principal"
        Write-Output "5) Quitter"

        $choice = Read-Host -Prompt "Choisissez une option"

        switch ($choice) {
            1 { C:\Users\Administrator\Documents\creationOU.ps1 }
            2 { C:\Users\Administrator\Documents\modifyUser.ps1 }
            3 { C:\Users\Administrator\Documents\suppressionOU.PS1 }
            4 { return  }
            5 { exit }
            default { Write-Output "Option incorrecte" }
        }
    }
}



# Menu Journal
function Journal {
    while ($true) {
        Clear-Host
        Write-Output "${RED}------- Menu Journal -------${NC}"
        Write-Output "1) Événements sur l'utilisateur"
        Write-Output "2) Événements sur l'ordinateur"
        Write-Output "3) Revenir au menu principal"
        
        $choice = Read-Host -Prompt "Choisissez une option"

        switch ($choice) {
            1 { Write-Output "Ligne de commande log utilisateur" } # Remplacez par la commande appropriée
            2 { Write-Output "Ligne de commande log ordinateur" } # Remplacez par la commande appropriée
            3 { return }
            default { Write-Output "Option incorrecte" }
        }
    }
}

# Menu principal
while ($true) {
    Clear-Host
    Write-Host "===== Menu Principal =====" -ForegroundColor Red
    Write-Output "1) Gestion de l'utilisateur"
    Write-Output "2) Gestion des ordinateurs"
    Write-Output "3) Gestion des groupes"
    Write-Output "4) Gestion des OU"
    Write-Output "5) Gestion des dossiers de partages"
    Write-Output "6) Consultation des journaux"
    Write-Output "7) Sortir"

    $choice = Read-Host -Prompt "Choisissez une option"

    switch ($choice) {
        1 { Menu-GestionUser }
        2 { Menu-GestionComputer }
        3 { Menu-GestionGroup }
        4 { Menu-GestionOU }
        5 { Menu-GestionDossier }
        6 { Journal }
        7 { exit }
        default { Write-Output "Option incorrecte" }
    }
}
