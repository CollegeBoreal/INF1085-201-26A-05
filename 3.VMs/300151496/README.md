# 300151496
<image src= images/222.jpeg width=50% height=50% > </image>

<image src= images/23.jpeg width=50% height=50% > </image>

<image src=images/WhatsApp%20Image%202026-10-02%20at%2012.43.36.jpeg width=50% height=50% > </image>


**Le point de départ**
Serveur Proxmox physique (nœud `server56`, Proxmox VE 9.2.2) joignable au 10.7.237.200. Depuis ton PC, connexion en SSH via PowerShell : `ssh root@10.7.237.200`. Objectif : créer une VM pour le module Linux et y installer Ubuntu Server.

**1. Trouver un numéro de VM libre**
`pvesh get /cluster/nextid` → **103**. Cette commande demande à Proxmox le prochain identifiant disponible. (On a d'abord corrigé une faute de frappe : espace manquant après `get` et `clouster` au lieu de `cluster`.)

**2. Lister les ISO disponibles**
`pvesm list local --content iso` → 3 images trouvées : proxmox-ve_9.2-1.iso, ubuntu-24.04.5-live-server-amd64.iso, ubuntu-24.04.5.1-desktop-amd64.iso. Choix : l'ISO **Ubuntu Server** — version sans interface graphique, adaptée au module Linux.

**3. Vérifier le stockage**
`pvesm status` → deux stockages actifs : `local` (fichiers, ISO) et `local-lvm` (disques des VM).

**4. Créer la VM 103**
`qm create 103 --name ubuntu-linux --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci --scsi0 local-lvm:20 --cdrom local:iso/ubuntu-24.04.5-live-server-amd64.iso --boot order='ide2;scsi0' --ostype l26`
Ce que fait chaque option : nom `ubuntu-linux`, 2 Go de RAM, 2 cœurs CPU, carte réseau virtuelle sur le pont vmbr0, disque de 20 Go sur local-lvm, ISO branchée comme lecteur CD, démarrage prioritaire sur le CD pour lancer l'installation, profil système Linux.

**5. Démarrer la VM**
`qm start 103`

**6. Ouvrir la console via l'interface web**
https://10.7.237.200:8006 tapé dans la barre d'adresse du navigateur, connexion en root, clic sur la VM 103 puis bouton « Console ». (L'avertissement de certificat est normal : Proxmox utilise un certificat auto-signé.)

**7. Installer Ubuntu Server 24.04** (écran par écran)
Langue English → clavier par défaut → réseau en DHCP → proxy laissé vide → miroir par défaut → stockage « Use an entire disk » avec LVM → profil : nom, nom de serveur `ubuntu-linux`, compte utilisateur et mot de passe (obligatoire : c'est le compte admin pour `sudo`) → Ubuntu Pro ignoré → « Install OpenSSH server » coché → aucun snap → installation → Reboot.

**8. Finalisation**
`qm set 103 --delete ide2 --boot order=scsi0` — détache l'ISO pour que la VM démarre désormais sur son disque dur. Si tu ne l'as pas encore fait, lance cette commande dans ton SSH.

**Résultat** : la VM 103 « ubuntu-linux » tourne avec Ubuntu Server 24.04 installé (2 Go RAM, 2 cœurs, 20 Go de disque) — ta machine pour le module Linux, joignable en SSH.


