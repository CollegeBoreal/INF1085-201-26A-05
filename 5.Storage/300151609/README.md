# 300151609 
# Ajout d’un stockage NVMe dans Proxmox VE

## Objectif

Dans ce projet, j’ai ajouté un disque NVMe au serveur Proxmox, je l’ai configuré comme stockage LVM-thin, puis j’ai déplacé le disque d’une machine virtuelle vers ce nouveau stockage.

> **Attention :** certaines commandes présentées dans ce projet effacent les signatures et modifient les partitions du disque. Il faut vérifier le bon disque et sauvegarder les données importantes avant de les utiliser.

---

## 1. Connexion au serveur

Je me suis connecté au serveur Proxmox avec SSH, puis j’ai utilisé la commande `lsblk` pour afficher les disques disponibles.

```bash
lsblk
```

Le disque `/dev/sda` contient le système Proxmox. Le disque `/dev/nvme0n1`, d’une capacité d’environ **953,9 Gio**, sera utilisé pour le nouveau stockage.

![Connexion SSH et liste des disques](images/WhatsApp%20Image%20220262-11-12%20at%203.38.19%20PM.jpeg)

---

## 2. Vérification du stockage existant

La commande `pvesm status` permet de voir les stockages déjà configurés dans Proxmox.

```bash
pvesm status
```

Avant l’ajout du NVMe, les stockages visibles étaient :

- `local` : stockage de type répertoire.
- `local-lvm` : stockage LVM-thin pour les disques des machines virtuelles.

![Disques et stockages existants](images/WhatsAp2p%20Image%202026-11-12%20at%203.38.19%20PM.jpeg)

Cette deuxième capture montre également le disque NVMe et l’état initial des stockages.

![Autre vue du stockage initial](images/WhatsApp%20Ima2ge%2020226-11-12%20at%203.38.19%20PM.jpeg)

---

## 3. Vérification des signatures du disque

Avant de préparer le disque NVMe, j’ai vérifié les signatures présentes avec :

```bash
wipefs -n /dev/nvme0n1
```

Le résultat a montré deux signatures :

- `isw_raid_member` : une signature liée à un RAID logiciel Intel.
- `PMBR` : une signature liée à une table de partition.

![Vérification des signatures du NVMe](images/WhatsAp1p%20Ima1ge%202026-11-12%20at%203.38.19%20PM.jpeg)

> **Important :** avant d’effacer une signature RAID, il faut confirmer que le disque n’est plus nécessaire à une configuration RAID existante.

---

## 4. Effacement des anciennes signatures

Après vérification du disque, les anciennes signatures ont été effacées :

```bash
wipefs -a /dev/nvme0n1
```

La commande `wipefs -n` a ensuite été utilisée pour vérifier les signatures restantes.

**Attention :** cette opération peut rendre les anciennes données inaccessibles. Elle n’effectue pas un effacement sécurisé du contenu du disque.

![Effacement des signatures du disque NVMe](images/1W1hatsApp%20Image%202026-11-12%20at%203.38.19%20PM.jpeg)

---

## 5. Création d’une partition GPT

J’ai utilisé `fdisk` pour créer une nouvelle table de partition GPT et une partition sur le disque NVMe.

```bash
fdisk /dev/nvme0n1
```

Dans `fdisk` :

1. `g` : créer une table GPT.
2. `n` : créer une nouvelle partition.
3. Accepter les valeurs proposées pour utiliser l’espace disponible.
4. `w` : enregistrer les modifications.

![Création de la partition GPT](images/Wha1tsApp%20Image%202026-11-12%20at%203.38.19%20PM.jpeg)

---

## 6. Création du volume physique et du groupe de volumes

Après la création de la partition, j’ai vérifié que `/dev/nvme0n1p1` était disponible.

J’ai ensuite créé un volume physique LVM et un groupe de volumes nommé `nvme-vg` :

```bash
lsblk /dev/nvme0n1
pvcreate /dev/nvme0n1p1
pvs
vgcreate nvme-vg /dev/nvme0n1p1
vgs
```

![Création de la partition et du groupe de volumes](images/WhatsApp%20Image%202026-1111-12%20at%203.38.19%20PM.jpeg)

---

## 7. Création du stockage LVM-thin

J’ai créé un pool LVM-thin nommé `data` dans le groupe `nvme-vg` :

```bash
lvcreate -l 100%FREE -T nvme-vg/data
lvs nvme-vg
```

Le pool utilise l’espace libre du groupe de volumes. LVM a affiché un avertissement de performance concernant la taille des blocs et le remplissage par des zéros, mais la création a réussi.

J’ai ensuite ajouté le pool à Proxmox avec le nom `nvme-storage` :

```bash
pvesm add lvmthin nvme-storage \
  --vgname nvme-vg \
  --thinpool data \
  --content images,rootdir

pvesm status
```

Le nouveau stockage apparaît comme **actif** dans Proxmox.

![Création et ajout du stockage NVMe](images/WhatsApp%20Image%202026-11-12%20at%203.38.119%20PM.jpeg)

> Il faut surveiller l’espace de données et de métadonnées du pool. Comme `100%FREE` a été utilisé, le groupe de volumes n’a pas d’espace libre pour agrandir automatiquement le pool sans ajouter ou libérer de capacité.

---

## 8. Vérification du disque de la machine virtuelle

Avant le déplacement, j’ai vérifié la configuration de la machine virtuelle **133** :

```bash
qm config 133
```

Son disque `scsi0`, d’une taille de **32 Gio**, se trouvait sur `local-lvm`.

![Configuration du disque de la VM avant le déplacement](images/WhatsApp%20Image%202026-11-12%20at%203.38.139%20PM.jpeg)

---

## 9. Déplacement du disque vers le NVMe

Le disque `scsi0` de la VM 133 a été déplacé de `local-lvm` vers `nvme-storage`.

La capture montre que la copie des **32 Gio** s’est terminée avec succès. L’ancien volume sur `local-lvm` a ensuite été supprimé.

![Progression et réussite du déplacement](images/WhatsApp%20Image%202026-11-12%20at%203.38.19%202PM.jpeg)

> La commande qui a lancé le déplacement n’est pas visible dans la capture. Avant un déplacement de disque, il est recommandé de disposer d’une sauvegarde vérifiée.

---

## 10. Vérification après le déplacement

Après la copie, j’ai vérifié la configuration de la VM et l’état du stockage :

```bash
qm config 133 | grep scsi0
pvesm status
```

Le disque apparaît maintenant sur `nvme-storage` :

```text
scsi0: nvme-storage:vm-133-disk-0,iothread=1,size=32G
```

![Vérification du disque après le déplacement](images/WhatsApp%20Image%202026-11-12%20at%203.38.191%20PM.jpeg)

Le déplacement change l’emplacement du disque, mais n’augmente pas automatiquement sa taille.

---

## 11. Vérification réseau dans la machine Ubuntu

Une autre capture montre un problème séparé dans une machine Ubuntu : la commande `apt` semblait bloquée.

Un réglage DNS temporaire a été appliqué à l’interface `ens18` :

```bash
sudo resolvectl dns ens18 8.8.8.8 1.1.1.1
ping -c 3 google.com
```

Le `ping` a ensuite réussi. Cela montre que la résolution DNS et le ping fonctionnaient à ce moment-là, mais ne prouve pas que le problème de `apt` était complètement résolu.

La capture montre également des messages du noyau concernant une tâche bloquée et des ralentissements RCU. Leur cause n’est pas établie par la capture.

![Vérification DNS et messages du système Ubuntu](images/WhatsApp%20Image%202026-11-12%20at%203.38.19%20PM.jpeg)

---

## Résultat

- Le disque NVMe a été configuré en stockage **LVM-thin**.
- Le stockage `nvme-storage` est apparu comme actif dans Proxmox.
- Le disque de la VM 133 a été déplacé vers le nouveau stockage.
- La configuration finale de la VM indique que `scsi0` utilise `nvme-storage`.
- ---

## 12. Vérification et nettoyage des anciens disques de la VM 197

J’ai vérifié que la VM 197 était en cours d’exécution et j’ai affiché les volumes associés à cette VM sur `local-lvm`.

La capture montre ensuite la suppression de trois disques marqués comme inutilisés : `unused0`, `unused1` et `unused2`.

Après la suppression, j’ai vérifié que :

- La VM 197 était toujours en cours d’exécution.
- Son disque actif `scsi0` était sur `nvme-storage`.
- Le disque actif avait une taille de 32 Gio.

![Vérification du stockage de la VM 197](images/Screenshot%202026-11-12%20160723.png)

