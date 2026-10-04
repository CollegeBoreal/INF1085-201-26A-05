# 300155909
# Documentation - Machine virtuelle Proxmox

## 1. Connexion au serveur Proxmox

```bash
ssh root@10.7.237.200
```

## 2. Vérification du stockage

```bash
pvesm status
```

## 3. Création du dossier de travail

```bash
mkdir rahma
cd rahma
```

## 4. Vérification de l'adresse IP

```bash
hostname -I
```

## 5. Vérification du stockage ISO

```bash
pvesm list local --content iso
```

## 6. Accès au répertoire des images ISO

```bash
cd /var/lib/vz/template/iso/
```

## 7. Test de la connexion Internet

```bash
ping -c 3 8.8.8.8
```

## 8. Configuration du DNS

```bash
cp /etc/resolv.conf /etc/resolv.conf.bak
printf "nameserver 1.1.1.1\nnameserver 8.8.8.8\n" > /etc/resolv.conf
```

## 9. Vérification de la résolution DNS

```bash
ping -c 3 enterprise.proxmox.com
```

## 10. Recherche des images ISO disponibles

```bash
curl -s https://enterprise.proxmox.com/iso/ | grep -o 'proxmox-ve_[^"]*\.iso' | sort -u
```

## 11. Téléchargement de l'ISO Proxmox

```bash
curl -L -O https://enterprise.proxmox.com/iso/proxmox-ve_9.2-1.iso
```

## 12. Vérification du stockage après le téléchargement

```bash
pvesm status
```

## 13. Obtention du prochain ID disponible

```bash
pvesh get /cluster/nextid
```

## 14. Création du pool de ressources

```bash
pvesh create /pools --poolid rahma
```

## 15. Création de la machine virtuelle

```bash
qm create 100 \
  --name ayoubVM \
  --pool rahma \
  --memory 8192 \
  --cores 4 \
  --cpu host \
  --ostype l26 \
  --scsihw virtio-scsi-single \
  --scsi0 local-lvm:64 \
  --ide2 local:iso/proxmox-ve_9.2-1.iso,media=cdrom \
  --net0 virtio,bridge=vmbr0 \
  --boot order='scsi0;ide2'
```

## 16. Démarrage de la machine virtuelle

```bash
qm start 100
```

## Configuration de la machine virtuelle

| Paramètre | Valeur |
|---|---|
| Nom | ayoubVM |
| VM ID | 100 |
| Mémoire | 8 GB |
| CPU | 4 cores |
| Disque | 64 GB |
| Stockage | local-lvm |
| Réseau | VirtIO |
| Bridge | vmbr0 |
| ISO | Proxmox VE 9.2-1 |

## Résultat

La machine virtuelle `ayoubVM` a été créée et démarrée avec succès sur le serveur Proxmox.
