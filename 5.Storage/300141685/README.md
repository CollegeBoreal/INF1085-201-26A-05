# Labo 5.Storage - 300141685

## Serveur
server197 (10.7.236.197)

## 1. Disques du système
Commande `lsblk` : le disque NVMe `nvme0n1` (953.9G) est déjà configuré en LVM-Thin.
![lsblk](images/01-lsblk.png)

## 2. Stockages Proxmox
Commande `pvesm status` : le stockage `nvme-storage` (LVM-Thin) est actif.
![pvesm status](images/02-pvesm-status.png)

## 3. Ma VM avant le déplacement
Commande `qm config 126` : le disque `scsi0` est sur `local-lvm`.
![qm config avant](images/03-qm-config-avant.png)

## 4. Déplacement du disque
Commande `qm move_disk 126 scsi0 nvme-storage` : le disque est copié vers le NVMe (100%).
![move disk](images/04-move-disk.png)

## 5. Ma VM après le déplacement
Commande `qm config 126` : le disque `scsi0` est maintenant sur `nvme-storage`.
![qm config après](images/05-qm-config-apres.png)

## 6. Vérification sur le stockage NVMe
Commande `pvesm list nvme-storage` : `vm-126-disk-0` apparaît dans le stockage NVMe.
![pvesm list](images/06-pvesm-list.png)

## Réponses aux questions de réflexion
1. HDD : disque mécanique, lent, grande capacité. SSD SATA : sans pièces mécaniques, plus rapide. NVMe : branché en PCI Express, très rapide.
2. Une partition divise un disque pour organiser l'espace.
3. Un système de fichiers organise et stocke les données sur le disque.
4. PV = Physical Volume, VG = Volume Group, LV = Logical Volume.
5. LVM-Thin permet d'allouer l'espace à la demande (thin provisioning), ce qui économise de la place.
6. `pvesm status`
7. Le NVMe est beaucoup plus rapide, donc les VM sont plus performantes.
