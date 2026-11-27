# Storage — Liza Benhammouche

**INF1085 · 300151835**

1. Sur l’hôte Proxmox attribué, confirmer le VMID, le disque à déplacer et l’espace libre sur `nvme-storage`.

```bash
qm list
qm config VMID
pvesm status
```

2. Remplacer `VMID` et `scsi0` par les valeurs relevées. Déplacer uniquement le disque de ta VM, puis attendre la fin de la copie.

```bash
qm move_disk VMID scsi0 nvme-storage
qm config VMID
pvesm list nvme-storage
```

3. Vérifier que le disque actif pointe vers `nvme-storage` et que la VM démarre.

**À relever** — configuration avant/après et état de démarrage de la VM.

## Questions de réflexion

1. **HDD, SSD SATA et SSD NVMe** — Le HDD utilise des plateaux mécaniques. Le SSD SATA utilise de la mémoire flash reliée en SATA. Le SSD NVMe utilise de la mémoire flash reliée en PCIe et offre généralement un débit supérieur et une latence plus faible.
2. **Partition** — Elle divise un disque en zones utilisables séparément.
3. **Système de fichiers** — Il organise les fichiers et les répertoires et gère leur stockage.
4. **PV, VG, LV** — Un PV est un volume physique. Un VG regroupe un ou plusieurs PV. Un LV est un volume logique créé à partir de l’espace d’un VG.
5. **LVM-Thin** — Il alloue les blocs à mesure que les VM écrivent des données et permet de créer des instantanés. Il faut surveiller l’espace du pool.
6. **Stockages Proxmox** — `pvesm status`.
7. **Intérêt du NVMe** — Sa faible latence et son débit accélèrent les lectures et écritures des VM, en particulier quand plusieurs VM sollicitent le stockage.

## Vérifier le stockage du groupe 2

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
pvs
vgs
lvs -o lv_name,vg_name,lv_attr,data_percent,metadata_percent
pvesm status
```

Le stockage attendu est `nvme-storage` de type `lvmthin`. S’il manque, identifier le disque réservé au laboratoire et confirmer qu’il est libre avant d’appliquer la [procédure du cours](../README.md). Après la migration, comparer `qm config VMID` avant et après, puis démarrer la VM et vérifier SSH. Si le disque source apparaît encore sous `unusedN`, confirmer le fonctionnement du nouveau disque et la disponibilité d’une sauvegarde avant de demander la suppression de la copie source pour libérer `local-lvm`.

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
