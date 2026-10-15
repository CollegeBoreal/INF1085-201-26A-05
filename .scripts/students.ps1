# --------------------------------------
# STUDENTS
# --------------------------------------

param(
    [int]$GroupSize = 8   # default if not provided
)

$STUDENTS = @(
"300141685|soulemaneBRY|157196575"
"300147065|Ahmedboreal|266599103"
"300150411|brhnkess|211593030"
"300150477|Trafalgar-D-Low|195692630"
"300150564|wassimbnr|102555452"
"300151315|toumiayoub1111-spec|329685188"
"300151449|abderrahimalaoui|231569522"
"300151496|anisouhocine|236670164"
"300151505|300151505|232939190"
"300151609|Ramzi34000|231497021"
"300151732|nabil17581|231499758"
"300151781|lounesallouti|257377074"
"300151835|benhammoucheliza928-eng|255944310"
"300153676|lyes-ik|255968971"
"300154023|silaje123|267740367"
"300155086|ynsakliii|200866288"
"300155109|AlexiaKabore|231572626"
"300155466|rekhilahana34-tech|232940163"
"300155524|Berihan-1995|236676877"
"300155909|rahouma20t-debug|266869186"
"300155927|garvey200|236671775"
"300156187|idirislamchili|273896373"
"300156497|mounakaci|231499918"
"300156615|waliii81|231570011"
"300156967|malika2714|231502729"
"300157117|lounisrayan|266407954"
"300157184|topanta|275812708"
"300157275|benkarayahia01-hue|307787126"
"300157301|Amhn25|258898045"
"300157330|toufikmekbel|231571164"
"300157374|yanisna|255961683"
"300157416|lounisyounes|232939450"
"300157424|MA-JID-06|258873685"
)

# --------------------------------------
# CONFIG
# --------------------------------------
$GROUP_SIZE = $GroupSize

# --------------------------------------
# FUNCTION - Dynamic grouping
# --------------------------------------

function New-Groups {
    param (
        [array]$Items,
        [int]$Size
    )

    $groups = @()

    for ($i = 0; $i -lt $Items.Count; $i += $Size) {
        $end = [Math]::Min($i + $Size - 1, $Items.Count - 1)
        $groups += ,@($Items[$i..$end])
    }

    return $groups
}

# --------------------------------------
# BUILD STUDENT GROUPS
# --------------------------------------
$GROUPS = New-Groups -Items $STUDENTS -Size $GROUP_SIZE

# --------------------------------------
# SERVERS
# --------------------------------------

$SERVERS = @(
"10.7.236.160|ubuntu"
"10.7.236.161|ubuntu"
"10.7.236.162|ubuntu"
"10.7.236.163|ubuntu"
"10.7.236.164|ubuntu"
"10.7.236.165|ubuntu"
"10.7.236.166|ubuntu"
"10.7.236.167|ubuntu"
"10.7.236.168|anishcn"
"10.7.236.169|ubuntu"
"10.7.236.170|ramzi"
"10.7.236.171|ubuntu"
"10.7.236.172|ubuntu"
"10.7.236.173|ubuntu"
"10.7.236.174|ubuntu"
"10.7.236.175|ubuntu"
"10.7.236.176|ubuntu"
"10.7.236.177|ubuntu"
"10.7.236.178|ubuntu"
"10.7.236.179|ubuntu"
"10.7.236.180|ubuntu"
"10.7.236.181|garvey200"
"10.7.236.182|ubuntu"
"10.7.236.183|ubuntu"
"10.7.236.184|ubuntu"
"10.7.236.185|ubuntu"
"10.7.236.186|ubuntu"
"10.7.236.187|anta"
"10.7.236.188|ubuntu"
"10.7.236.189|ubuntu"
"10.7.236.190|ubuntu"
"10.7.236.191|ubuntu"
"10.7.236.192|ubuntu"
"10.7.236.193|ubuntu"
)

$SERVER_GROUPS = New-Groups -Items $SERVERS -Size $GROUP_SIZE

# --------------------------------------
# WINDOWS SERVERS (1 per group)
# --------------------------------------

$WINDOWS_SERVERS = @(
"10.7.236.197"
"10.7.236.198"
"10.7.236.199"
"10.7.236.200"
"10.7.236.200"
)

# --------------------------------------
# OPTIONAL: MERGED LAB OBJECT (🔥 recommandé)
# --------------------------------------

$LAB_GROUPS = for ($i = 0; $i -lt $GROUPS.Count; $i++) {
    [PSCustomObject]@{
        Id        = $i + 1
        Students  = $GROUPS[$i]
        Servers   = $SERVER_GROUPS[$i]
        Proxmox   = $WINDOWS_SERVERS[$i]
    }
}

# --------------------------------------
# PROF / LMS
# --------------------------------------

$PK_PROF="b300098957@ramena"
$LMS_COURSE=11
