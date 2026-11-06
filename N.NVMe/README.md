# 💾 Gestion d'un disque NVMe sous Proxmox VE 9

## 🎯 Objectif

Apprendre à :

- Identifier un disque NVMe
- Vérifier son état de santé
- Initialiser un nouveau disque
- L'utiliser comme stockage pour les VM Proxmox
- Vérifier son utilisation

---

# 🔍 Identifier le disque NVMe

Afficher les disques : (i.e. nvme❔n❔)

```bash
lsblk
```
<details><summary>🖨️ Output</summary>
  
```lua
NAME                         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda                            8:0    0 273.4G  0 disk 
├─sda1                         8:1    0  1007K  0 part 
├─sda2                         8:2    0     1G  0 part 
└─sda3                         8:3    0 272.4G  0 part 
  ├─pve-swap                 252:0    0     8G  0 lvm  [SWAP]
  ├─pve-root                 252:1    0  78.1G  0 lvm  /
  ├─pve-data_tmeta           252:2    0   1.7G  0 lvm  
  │ └─pve-data-tpool         252:4    0 166.9G  0 lvm  
  │   └─pve-data             252:5    0 166.9G  1 lvm  
  └─pve-data_tdata           252:3    0 166.9G  0 lvm  
    └─pve-data-tpool         252:4    0 166.9G  0 lvm  
      └─pve-data             252:5    0 166.9G  1 lvm  
nvme0n1                      259:0    0 953.9G  0 disk
```
</details>

---

# 📊 Vérifier l'état du NVMe

Installer les outils NVMe :

```bash
apt update
apt install nvme-cli -y
```

Afficher la liste

```bash
nvme list
```

Exemple :

```text
Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1               AMD8N000711508N2M PC811 SK hynix 1024GB                    0x1          1.02  TB /   1.02  TB    512   B +  0 B   61002141
```


Afficher les informations SMART :

```bash
nvme smart-log /dev/nvme0n1
```

<details><summary>🖨️ Output</summary>

```lua
Smart Log for NVME device:nvme0n1 namespace-id:ffffffff
critical_warning			: 0
temperature				: 80 °F (300 K)
available_spare				: 100%
available_spare_threshold		: 50%
percentage_used				: 0%
endurance group critical warning summary: 0
Data Units Read				: 5940346 (3.04 TB)
Data Units Written			: 5630113 (2.88 TB)
host_read_commands			: 186670472
host_write_commands			: 183183831
controller_busy_time			: 13946
power_cycles				: 45
power_on_hours				: 7910
unsafe_shutdowns			: 27
media_errors				: 0
num_err_log_entries			: 0
Warning Temperature Time		: 0
Critical Composite Temperature Time	: 0
Temperature Sensor 1			: 80 °F (300 K)
Temperature Sensor 2			: 91 °F (306 K)
Thermal Management T1 Trans Count	: 0
Thermal Management T2 Trans Count	: 0
Thermal Management T1 Total Time	: 0
Thermal Management T2 Total Time	: 0
```
  
</details>

Informations utiles :

```text
temperature
percentage_used
data_units_read
data_units_written
media_errors
```

---

# 🌡️ Vérifier la température

```bash
nvme smart-log /dev/nvme0n1 | grep temperature
```

Exemple :

```text
temperature				: 80 °F (300 K)
```

### Températures NVMe typiques

| Température	| État |
|-|-|
| < 40 °C	 | ✅ Excellent
| 40-50 °C | ✅ Normal
| 50-60 °C | ⚠️ Chaud
| 60-70 °C | ⚠️ Très chaud
| > 70 °C  | ❌ Risque de throttling

---

# 🗑️ Effacer les signatures existantes

⚠️ Cette opération supprime les anciennes signatures RAID, LVM ou systèmes de fichiers.

```bash
wipefs -a /dev/nvme0n1
```
<details><summary>🖨️ Output </summary>

```lua
/dev/nvme0n1: 2 bytes were erased at offset 0x000001fe (dos): 55 aa
/dev/nvme0n1: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54
/dev/nvme0n1: 8 bytes were erased at offset 0xee77a55e00 (gpt): 45 46 49 20 50 41 52 54
/dev/nvme0n1: calling ioctl to re-read partition table: Success
```
</details>

---

# 📝 Créer une partition GPT

```bash
fdisk /dev/nvme0n1
```
<details><summary>🖨️ Output </summary>

```lua

Welcome to fdisk (util-linux 2.41.5).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS (MBR) disklabel with disk identifier 0x540e625f.

Command (m for help): m

Help:

  DOS (MBR)
   a   toggle a bootable flag
   b   edit nested BSD disklabel
   c   toggle the dos compatibility flag

  Generic
   d   delete a partition
   F   list free unpartitioned space
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table
   i   print information about a partition
   e   resize a partition
   T   discard (trim) sectors

  Misc
   m   print this menu
   u   change display/entry units
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty MBR (DOS) partition table
   s   create a new empty Sun partition table

Command (m for help): g
Created a new GPT disklabel (GUID: DEFC724C-5E36-4F3D-9E76-2BCCBCEB924E).

Command (m for help): n
Partition number (1-128, default 1): 
First sector (2048-2000409230, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-2000409230, default 2000408575): 

Created a new partition 1 of type 'Linux filesystem' and of size 953.9 GiB.
Partition #1 contains a ntfs signature.

Do you want to remove the signature? [Y]es/[N]o: Y

The signature will be removed by a write command.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

</details>

Commandes :

```text
g
n
Enter
Enter
Enter
w
```

Vérifier :

```bash
lsblk
```

Résultat attendu :

```text
nvme0n1                       259:0    0 953.9G  0 disk 
├─nvme0n1p1                   259:1    0    16M  0 part 
└─nvme0n1p2                   259:2    0 953.9G  0 part
```

---

# 💾 Utiliser le NVMe comme stockage Proxmox

## Créer le volume physique

Utiliser la partition la plus large `953.9G`

```bash
pvcreate /dev/nvme0n1p2
```

---

## Créer un groupe de volumes

```bash
vgcreate nvme-vg /dev/nvme0n1p2
```
> Physical volume "/dev/nvme0n1p2" successfully created.

---

## Créer un pool LVM Thin

```bash
lvcreate -l 100%FREE -T nvme-vg/data
```
```text
  Thin pool volume with chunk size 512.00 KiB can address at most 127.00 TiB of data.
  WARNING: Pool zeroing and 512.00 KiB large chunk size slows down thin provisioning.
  WARNING: Consider disabling zeroing (-Zn) or using smaller chunk size (<512.00 KiB).
  Logical volume "data" created.
```

---

## Vérifier

```bash
lvs
```

Exemple :

```text
  LV             VG      Attr       LSize    Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  data           nvme-vg twi-a-tz-- <953.62g             0.00   10.42
```

---

# 🖥️ Ajouter le stockage dans Proxmox

Interface Web :

```text
Datacenter
└── Storage
    └── Add
         └── LVM-Thin
```

Paramètres :

```text
ID           : nvme-storage
Volume Group : nvme-vg
Thin Pool    : data
```

---

# 📈 Vérifier les stockages

```bash
pvesm status
```

---

# 📋 Voir les disques des VM

```bash
pvesm list nvme-storage
```

---

# 🔍 Vérifier le disque utilisé par une VM

Exemple VM 101 :

```bash
qm config 101
```

Résultat :

```text
scsi0: nvme-storage:vm-101-disk-0,size=20G
```

---

# 🧹 Trouver les disques inutilisés

Afficher tous les disques :

```bash
pvesm list nvme-storage
```

Afficher les VM :

```bash
qm list
```

Comparer les deux listes.

---

# 🚀 Tester les performances

Mesure simple :

```bash
hdparm -Tt /dev/nvme0n1
```

---

# 📊 Résumé rapide

Lister les NVMe :

```bash
nvme list
```

Afficher la santé :

```bash
nvme smart-log /dev/nvme0n1
```

Créer une partition :

```bash
fdisk /dev/nvme0n1
```

Créer un volume LVM :

```bash
pvcreate /dev/nvme0n1p1
vgcreate nvme-vg /dev/nvme0n1p1
lvcreate -l 100%FREE -T nvme-vg/data
```

Afficher les stockages Proxmox :

```bash
pvesm status
```

Afficher les VM :

```bash
qm list
```

---

# ✅ Résultat attendu

✅ Disque NVMe détecté

✅ Santé du disque vérifiée

✅ Partition GPT créée

✅ Stockage LVM-Thin configuré

✅ Stockage ajouté à Proxmox

✅ Prêt à héberger les disques des machines virtuelles

---

# 💾 Ajout d'un disque NVMe comme stockage Proxmox

## 🎯 Objectif

Ajouter un disque NVMe de 1 To comme stockage **LVM-Thin** afin d'héberger les disques des machines virtuelles Proxmox.

---

# 🔍 Vérification du disque

Identifier le disque :

```bash
lsblk
```

Résultat :

```text
nvme0n1 953.9G
```

Vérification SMART :

```bash
smartctl -a /dev/nvme0n1
```

Résultats observés :

```text
SMART PASSED
Temperature: 30°C
Media Errors: 0
Percentage Used: 0%
```

✅ Le disque est en excellente santé.

---

# 🧹 Suppression de l'ancien système de fichiers

Vérification :

```bash
blkid /dev/nvme0n1p2
```

Résultat :

```text
TYPE="ntfs"
LABEL="DATA"
```

Le disque provenait d'une ancienne installation Windows.

Suppression de la signature NTFS :

```bash
wipefs -a /dev/nvme0n1p2
```

Vérification :

```bash
blkid /dev/nvme0n1p2
```

Résultat :

```text
PARTLABEL="Basic data partition"
PARTUUID="..."
```

✅ La signature NTFS a été supprimée.

---

# ⚠️ Problème rencontré

La commande :

```bash
pvcreate -ff -y /dev/nvme0n1p2
```

semblait bloquée.

Investigation :

```bash
cat /proc/$(pidof pvcreate)/stack
```

Résultat :

```text
locks_lock_inode_wait
```

Le problème était un verrou LVM actif et non un problème matériel.

---

# 💽 Création du stockage LVM

Création du volume physique :

```bash
pvcreate -ff -y /dev/nvme0n1p2
```

Résultat :

```text
Physical volume "/dev/nvme0n1p2" successfully created.
```

---

# 📦 Création du groupe de volumes

```bash
vgcreate nvme-vg /dev/nvme0n1p2
```

Résultat :

```text
Volume group "nvme-vg" successfully created
```

---

# 📁 Création du Thin Pool

```bash
lvcreate -l 100%FREE -T nvme-vg/data
```

Résultat :

```text
Logical volume "data" created.
```

✅ Le Thin Pool est prêt à recevoir les disques des machines virtuelles.

---

# 🖥️ Ajout dans Proxmox

Interface Web :

```text
Datacenter
└── Storage
    └── Add
         └── LVM-Thin
```

Paramètres :

```text
ID           : nvme-storage
Volume Group : nvme-vg
Thin Pool    : data
```

Contenu :

```text
☑ Disk image
☑ Container
```

---

# ✅ Vérification

Afficher les stockages :

```bash
pvesm status
```

Résultat attendu :

```text
local
local-lvm
nvme-storage
```

---

# 🚀 Utilisation

Créer un disque de VM sur le NVMe :

```bash
qm set 101 --scsi1 nvme-storage:20
```

Vérifier :

```bash
qm config 101
```

Exemple :

```text
scsi1: nvme-storage:vm-101-disk-0,size=20G
```

---

# ✅ Résultat final

- ✅ Disque NVMe de 1 To détecté
- ✅ Santé du disque vérifiée
- ✅ Ancienne partition NTFS supprimée
- ✅ Volume physique LVM créé
- ✅ Groupe de volumes `nvme-vg` créé
- ✅ Thin Pool `data` créé
- ✅ Stockage `nvme-storage` prêt pour Proxmox
- ✅ Prêt à héberger les machines virtuelles Linux
