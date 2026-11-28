# --------------------------------------
# Validation INF1085 - Stockage NVMe
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

if (-not $SERVERS) {

    Write-Host `
        "La variable `$SERVERS n'a pas été trouvée dans students.ps1" `
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
$md += "| :a: #a-presence | Verification du stockage NVMe |"
$md += ""

$md += "## Legende"
$md += ""

$md += "| Symbole | Signification |"
$md += "|----------|-------------|"
$md += "| :white_check_mark: | VM stockée sur nvme-storage |"
$md += "| :x: | VM absente du stockage NVMe |"
$md += "| :no_entry: | Serveur Proxmox inaccessible |"

$md += ""
$md += "## :a: Presence"
$md += ""

$md += "| # | Boreal :id: | VMID | :link: PVE | :floppy_disk: NVMe |"
$md += "|---|-------------|------|----------|----------------|"

# --------------------------------------
# Build NVMe Cache
# --------------------------------------

$NVMeCache = @{}

foreach ($PveHost in ($WINDOWS_SERVERS | Select-Object -Unique)) {

    Write-Host ""
    Write-Host "Analyse du serveur PVE $PveHost..." `
        -ForegroundColor Cyan

    try {

$Command = @'
for vm in $(qm list | sed 1d | awk '{print $1}'); do
    qm config $vm | grep -q nvme-storage && echo $vm
done
'@

        $Output = ssh `
        -i ~/.ssh/b300098957@ramena `
        -o ConnectTimeout=10 `
        -o BatchMode=yes `
        "root@$PveHost" `
        $Command

        Write-Host "Output from ${PveHost}:"

        Write-Host "===== OUTPUT ====="
        Write-Host $Output
        Write-Host "LASTEXITCODE=$LASTEXITCODE"
        Write-Host "=================="

        if ($LASTEXITCODE -ne 0) {
            throw "Connexion SSH impossible"
        }

        foreach ($VmId in ($Output -split "`n")) {

            $VmId = $VmId.Trim()

            if (-not [string]::IsNullOrWhiteSpace($VmId)) {

                $NVMeCache[$VmId] = $PveHost

                Write-Host `
                    "VM $VmId utilise nvme-storage sur $PveHost" `
                    -ForegroundColor Green
            }
        }
    }
    catch {

        Write-Host "Erreur complète :" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red

        if ($_.InvocationInfo.PositionMessage) {
            Write-Host $_.InvocationInfo.PositionMessage `
                -ForegroundColor DarkYellow
        }
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

    # Format:
    # 10.7.236.196|ayoub|101

    $server_parts = $SERVERS[$i] -split '\|'

    $VmIP   = $server_parts[0]
    $VmUser = $server_parts[1]
    $VmId   = $server_parts[2]

    if (
        $VmId -ne "0" -and
        $NVMeCache.ContainsKey($VmId)
    ) {

        $PveHost = $NVMeCache[$VmId]

        $PveUrl = "https://$($PveHost):8006"

        $Status = ":white_check_mark:"

        $SuccessCount++

        Write-Host `
            "Étudiant $StudentID : VM $VmId sur $PveHost utilise nvme-storage" `
            -ForegroundColor Green
    }
    else {

        $PveHost = "-"

        $PveUrl = "-"

        $Status = ":x:"

        Write-Host `
            "Étudiant $StudentID : VM $VmId n'utilise pas nvme-storage" `
            -ForegroundColor Red
    }

    $md += "| $Counter | ../$StudentID/README.md :point_right: $url | $VmId | $PveUrl | $Status |"

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
$md += "| :abacus: | `$\displaystyle\sum_{i=1}^{$TotalStudents} s_i$ = $SuccessCount :chart_with_upwards_trend: = $Percentage% | | | |"

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
    "$SuccessCount / $TotalStudents VM utilisent nvme-storage." `
    -ForegroundColor Green

Write-Host `
    "Fichier : $OutputFile" `
    -ForegroundColor Yellow