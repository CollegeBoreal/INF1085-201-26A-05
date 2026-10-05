# 300156497
# Création d’une machine virtuelle Ubuntu sur Proxmox
# 1. Connexion au serveur Proxmox

Connexion au serveur Proxmox avec PowerShell :

ssh root@10.7.237.200

# 2. Vérification des machines virtuelles

Vérification des VM déjà présentes sur le serveur :

qm list

# 3. Vérification du stockage ISO

Vérification des fichiers ISO disponibles dans le stockage local :

ls -lh /var/lib/vz/template/iso

# 4. Accès au répertoire ISO

cd /var/lib/vz/template/iso

# 5. Téléchargement de l’ISO Ubuntu Server

wget https://releases.ubuntu.com/24.04/ubuntu-24.04.5-live-server-amd64.iso

ISO utilisée : ubuntu-24.04.5-live-server-amd64.iso
![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/3.VMs/300156497/images/4d308b62-13fb-41ae-abb6-fae955704d65.jpeg?raw=true)

# 6. Vérification de l’ISO

ls -lh

# 7. Création de la machine virtuelle

Création de la VM Ubuntu avec 1 processeur, conformément aux consignes :

qm create 101 --name Ubuntu-Server --memory 4096 --cores 1 --net0 virtio,bridge=vmbr0

# 8. Ajout du disque virtuel

Ajout d’un disque de 20 Go :

qm set 101 --scsihw virtio-scsi-pci --scsi0 local-lvm:20

# 9. Ajout de l’ISO Ubuntu

Association de l’ISO Ubuntu à la machine virtuelle :

qm set 101 --ide2 local:iso/ubuntu-24.04.5-live-server-amd64.iso,media=cdrom

# 10. Configuration du démarrage

qm set 101 --boot order='ide2;scsi0'

# 11. Démarrage de la VM

qm start 101

# 12. Vérification de l’état de la VM

qm status 101

Résultat :

status: running

La machine virtuelle Ubuntu est démarrée avec succès.

# 13. Vérification de la configuration

qm config 101

Cette commande permet de vérifier la configuration de la machine virtuelle.

# Conclusion

Une machine virtuelle Ubuntu Server a été créée sur le serveur Proxmox. La VM utilise 1 processeur et a été démarrée avec succès.
![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/3.VMs/300156497/images/cd8f0e18-2d89-4ad5-8bc1-31f0547bb73b.jpeg?raw=true)
