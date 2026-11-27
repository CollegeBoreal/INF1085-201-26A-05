# --------------------------------------
# Validation INF1085 - Utilisateurs Proxmox
# --------------------------------------

# Forcer UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Charger les étudiants
. ../.scripts/students.ps1

# --------------------------------------
# VALIDATION
# --------------------------------------

# Fonctions communes
. ../.scripts/functions.ps1
. ../.scripts/commons.ps1

# Fonctions du laboratoire
. .scripts/functions.ps1

if (-not $WINDOWS_SERVERS) {

    Write-Host `
        "La variable `$WINDOWS_SERVERS n'a pas été trouvée dans students.ps1" `
        -ForegroundColor Red

    exit
}

# --------------------------------------
# README
# --------------------------------------

$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"

$md = @()

$md += "# Precision au $timestamp"
$md += ""

$md += "| Table des matieres | Description |"
$md += "|--------------------|-------------|"
$md += "| :a: [Presence](#a-presence) | Serveur Proxmox accessible |"
$md += "| :b: [Precision](#b-precision) | Verification du compte Proxmox |"
$md += ""

$md += "## Legende"
$md += ""

$md += "| Symbole | Signification |"
$md += "|----------|-------------|"
$md += "| :white_check_mark: | Compte Proxmox trouvé |"
$md += "| :x: | Compte Proxmox absent |"
$md += "| :no_entry: | Connexion SSH impossible |"
$md += ""

$md += "## :b: Precision"
$md += ""

$md += "| # | Boreal :id: | :link: PVE IP | :closed_lock_with_key: Compte PVE |"
$md += "|---|-------------|---------------|-----------------------------|"

# --------------------------------------
# Build ACL Cache
# --------------------------------------

$ACLCache = @{}

foreach ($PveHost in $WINDOWS_SERVERS | Select-Object -Unique) {

    Write-Host ""
    Write-Host "Collecte ACL sur $PveHost ..." `
        -ForegroundColor Cyan

    try {

        $ACLs = ssh `
            -i ~/.ssh/b300098957@ramena `
            -o ConnectTimeout=10 `
            -o BatchMode=yes `
            "root@$PveHost" `
            "pveum acl list 2>/dev/null"

        if ($LASTEXITCODE -ne 0) {
            throw "Connexion SSH impossible"
        }

        foreach ($Line in ($ACLs -split "`n")) {

            if ($Line -match 'B\d+@pam') {

                $User = $Matches[0]

                $ACLCache[$User] = $PveHost
            }
        }

        Write-Host `
            "$PveHost : ACL collectées" `
            -ForegroundColor Green
    }
    catch {

        Write-Host `
            "$PveHost : SSH impossible" `
            -ForegroundColor Red
    }
}

# --------------------------------------
# Validation
# --------------------------------------

$SuccessCount = 0
$Counter = 1

for ($i = 0; $i -lt $STUDENTS.Count; $i++) {

    $parts = $STUDENTS[$i] -split '\|'

    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]

    $url = Get-GitHubAvatarLink `
        -GitHubID $GitHubID `
        -AvatarID $AvatarID

    $ExpectedUser = "B$StudentID@pam"

    if ($ACLCache.ContainsKey($ExpectedUser)) {

        $ServerFound = $ACLCache[$ExpectedUser]

        $Status = ":white_check_mark:"

        $SuccessCount++

        Write-Host `
            "$ExpectedUser trouvé sur $ServerFound" `
            -ForegroundColor Green
    }
    else {

        $ServerFound = "-"

        $Status = ":x:"

        Write-Host `
            "$ExpectedUser absent" `
            -ForegroundColor Red
    }

    $md += "| $Counter | [$StudentID](../$StudentID/README.md) :point_right: $url | [$ServerFound](https://$ServerFound:8006) | $Status |"

    $Counter++
}

# --------------------------------------
# Résumé
# --------------------------------------

$TotalStudents = $Counter - 1

if ($TotalStudents -gt 0) {

    $Percentage = [math]::Round(
        ($SuccessCount * 100) / $TotalStudents,
        2
    )
}
else {

    $Percentage = 0
}

$md += ""
$md += "| :abacus: | `$\displaystyle\sum_{i=1}^{$TotalStudents} s_i$ = $SuccessCount :chart_with_upwards_trend: = $Percentage% | | |"

# --------------------------------------
# Export
# --------------------------------------

$OutputFile = ".scripts/Check.md"

$md | Out-File `
    -FilePath $OutputFile `
    -Encoding utf8

Write-Host ""
Write-Host `
    "README.md généré avec succès !" `
    -ForegroundColor Green

Write-Host `
    "$SuccessCount / $TotalStudents étudiants possèdent un compte Proxmox valide." `
    -ForegroundColor Green

Write-Host `
    "Fichier : $OutputFile" `
    -ForegroundColor Yellow