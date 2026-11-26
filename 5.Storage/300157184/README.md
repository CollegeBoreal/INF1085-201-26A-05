#  Lab 5.Storage – Déplacer une machine virtuelle vers le stockage NVMe

** Étudiante :** 300157184
** Serveur :** server56 — Proxmox VE 9.2.2
** VM :** 100 (VM-300157184)
** Accès SSH :** `ssh anta@10.7.236.206`

---

##  Objectif

Déplacer le disque de ma machine virtuelle de `local-lvm` vers `nvme-storage` afin d'améliorer les performances.

---

##  Vérifier le disque actuel de la VM

Dans **VM 100 → Hardware**, le disque `scsi0` se trouve sur `local-lvm` :

```
scsi0: local-lvm:vm-100-disk-0,iothread=1,size=32G
```

![Hardware avant](images/01-hardware-avant.png)

---

## 2️ Déplacer le disque vers nvme-storage

**Hardware → Hard Disk (scsi0) → Disk Action → Move Storage**

- **Target Storage :** `nvme-storage`
- **Delete source :** ☑️ coché (supprime l'ancien disque de `local-lvm` après la copie)

Commande équivalente :

```bash
qm move_disk 100 scsi0 nvme-storage --delete 1
```

![Move disk](images/02-move-disk.png)

---

## Copie du disque

La copie de 32 GiB s'est faite en environ 1 minute, puis l'ancien volume a été supprimé :

```
mirror-scsi0: transferred 32.0 GiB of 32.0 GiB (100.00%) in 1m, ready
mirror-scsi0: Completed successfully.
removing source volume 'local-lvm:vm-100-disk-0' after successful copy
Logical volume "vm-100-disk-0" successfully removed.
TASK OK
```

![Task OK](images/03-task-ok.png)

---

##  Vérifier le résultat

```bash
qm config 100
pvesm list nvme-storage
qm status 100
```

Résultats :

```
scsi0: nvme-storage:vm-100-disk-0,iothread=1,size=32G

Volid                        Format  Type    Size         VMID
nvme-storage:vm-100-disk-0   raw     images  34359738368  100

status: running
```

![Vérification](images/04-verification.png)

---

## 🧠 Résumé

```
Avant :                  Après :
local-lvm                nvme-storage
   │                        │
   └── VM 100               └── VM 100
```

## ✅ Résultat attendu

- ✅ VM identifiée (VM 100 – VM-300157184)
- ✅ Disque déplacé vers `nvme-storage`
- ✅ Configuration mise à jour (`scsi0: nvme-storage:vm-100-disk-0`)
- ✅ VM opérationnelle (`status: running`)
- ✅ Stockage NVMe utilisé
- 
