# --------------------------------------
# Validation INF1084 - Services Windows et AD DS
# --------------------------------------

# Forcer UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Pass parameter to students.ps1
. ../.scripts/students.ps1

# --------------------------------------
# VALIDATION
# --------------------------------------

# Importer les fonctions
. ../.scripts/functions.ps1
. ../.scripts/commons.ps1

# Importer les fonctions du lab
. .scripts/functions.ps1

if (-not $SERVERS) {
    Write-Host "La variable `$SERVERS n'a pas été trouvée dans students.ps1" -ForegroundColor Red
    exit
}

# --------------------------------------
# Authentification
# --------------------------------------

$User = "Administrator"

$Password = ConvertTo-SecureString `
    "Infra@2024" `
    -AsPlainText `
    -Force

$Credential = New-Object System.Management.Automation.PSCredential (
    $User,
    $Password
)

# --------------------------------------
# README
# --------------------------------------

$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"

$md = @()

$md += "# Precision au $timestamp"
$md += ""
$md += "| Table des matieres | Description |"
$md += "|--------------------|-------------|"
$md += "| :a: [Presence](#a-presence) | La VM est accessible |"
$md += "| :b: [Precision](#b-precision) | Verification des services AD |"
$md += ""
$md += "## Legende"
$md += ""
$md += "| Symbole | Signification |"
$md += "|----------|-------------|"
$md += "| :white_check_mark: | Service SSH actif |"
$md += "| :x: | Service SSH arrêté |"
$md += "| :no_entry: | Connexion SSH impossible |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| # | Boreal :id: | :link: IP | :lock: SSH |"
$md += "|---|-------------|-----------|------------|"

# --------------------------------------
# Validation
# --------------------------------------

$SuccessCount = 0
$Counter = 1

for ($i = 0; $i -lt $STUDENTS.Count; $i++) {

    $parts = $STUDENTS[$i] -split '\|'

    $server_parts = $SERVERS[$i] -split '\|'

    $ServerIP = $server_parts[0]
    $AdminIP  = $server_parts[1]

    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]

    $url = Get-GitHubAvatarLink `
        -GitHubID $GitHubID `
        -AvatarID $AvatarID

    Write-Host ""
    Write-Host "Connexion SSH à $AdminIP@$ServerIP ..." -ForegroundColor Cyan

    try {

        $SSHStatus = ssh `
            -i ~/.ssh/b300098957@ramena `
            -o ConnectTimeout=10 `
            -o BatchMode=yes `
            "$AdminIP@$ServerIP" `
            "systemctl is-active ssh 2>/dev/null"

        $SSHStatus = $SSHStatus.Trim()

        Write-Host "SSH : $SSHStatus"

        if ($SSHStatus -eq "active") {

            $SSHIcon = ":white_check_mark:"

            $SuccessCount++
        }
        else {

            $SSHIcon = ":x:"

        }

        $md += "| $Counter | [$StudentID](../$StudentID/README.md) :point_right: $url | $AdminIP@$ServerIP | $SSHIcon |"
    }
    catch {

        Write-Host "Échec SSH vers $AdminIP@$ServerIP" -ForegroundColor Red

        $md += "| $Counter | [$StudentID](../$StudentID/README.md) :point_right: $url | $AdminIP@$ServerIP | :no_entry:  |"
    }

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

$md += "| :abacus: | `$\displaystyle\sum_{i=1}^{$TotalStudents} s_i$ = $SuccessCount :chart_with_upwards_trend: = $Percentage% | | |"

# --------------------------------------
# Export
# --------------------------------------

$OutputFile = ".scripts/Check.md"

$md | Out-File `
    -FilePath $OutputFile `
    -Encoding utf8

Write-Host ""
Write-Host "README.md généré avec succès !" -ForegroundColor Green
Write-Host "$SuccessCount / $TotalStudents étudiants ont tous les services AD actifs." -ForegroundColor Green
Write-Host "Fichier : $OutputFile" -ForegroundColor Yellow