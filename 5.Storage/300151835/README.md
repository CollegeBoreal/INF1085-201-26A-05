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

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
