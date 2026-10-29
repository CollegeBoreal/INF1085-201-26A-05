# Rapport Proxmox – server239

**Cours :** INF1085 – Collège Boréal
**Auteur :** Karim Bamba (300153972)
**Date :** 18 octobre 2026

---

## Contexte

Ce rapport résume le travail réalisé sur le serveur Proxmox du cours : connexion au serveur, création d'un utilisateur administrateur, clé SSH, bridge réseau et machine virtuelle.

| Élément | Valeur |
| --- | --- |
| Serveur | `server239` (Proxmox VE, basé sur Debian) |
| Adresse IP | `10.7.236.239` |
| Accès | SSH depuis Windows PowerShell, compte `root` |
| Utilisateur créé | `B300153972@pve` |

---

## 1. Connexion SSH au serveur

Connexion réussie en `root` sur `server239`. L'invite `root@server239:~#` confirme que les commandes s'exécutent sur le serveur.

```powershell
ssh root@10.7.236.239
```

https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.Root/300153972/images/Screenshot%202026-10-14%20113852.png?raw=true

### Problème rencontré : `Connection timed out`

Ce message signifie que le serveur ne répond pas du tout : le problème vient du réseau, pas du mot de passe.

Vérifications effectuées :

1. `ipconfig` : le PC doit avoir une adresse en `10.7.x.x`.
2. `ping 10.7.236.239` : vérifier que le serveur répond.
3. `Test-NetConnection 10.7.236.239 -Port 22` : vérifier que le port SSH est ouvert.

> **Important :** le serveur utilise une adresse privée du collège. Il faut être connecté au réseau **Boréal** (labo ou Wi‑Fi étudiant). Le réseau **Invité** et la connexion depuis la maison ne permettent pas d'y accéder.

### Première connexion

- SSH demande de confirmer l'empreinte (*fingerprint*) du serveur : répondre `yes`.
- Le serveur est ensuite ajouté aux *known hosts* et la question ne revient plus.
- `Permission denied` = mauvais mot de passe.

---

## 2. Utilisateur administrateur Proxmox

**Consigne :** créer un utilisateur avec droit Administrateur sur Proxmox.

### Commandes

```bash
pveum user add B300153972@pve
pveum passwd B300153972@pve
pveum acl modify / -user B300153972@pve -role Administrator
```

### Vérification

```bash
pveum user list
pveum acl list
```

Résultat : `B300153972@pve` possède le rôle **Administrator** sur `/`.

### Erreurs rencontrées et corrections

| Erreur | Cause | Correction |
| --- | --- | --- |
| `400 too many arguments` | Commande `pveum passwd add ...` : le mot `add` est de trop | `pveum passwd <userid>` |
| Utilisateur créé sans le préfixe **B** (`300153972@pve`) | Oubli lors de la création | Suppression puis recréation (voir ci-dessous) |

Commandes de correction :

```bash
pveum acl delete / -user 300153972@pve -role Administrator
pveum user delete 300153972@pve
pveum user add B300153972@pve
pveum passwd B300153972@pve
pveum acl modify / -user B300153972@pve -role Administrator
```

### Ajouter les informations de l'utilisateur

```bash
pveum user modify B300153972@pve --firstname Karim --lastname Bamba --email 300153972@monboreal.ca
```

---

## 3. Clé SSH

La clé privée reste sur le PC ; la clé publique est déposée sur le serveur. La connexion se fait ensuite sans le mot de passe `root`.

Commandes dans PowerShell (sur le PC) :

```powershell
ssh-keygen -t ed25519
type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh root@10.7.236.239 "cat >> ~/.ssh/authorized_keys"
ssh root@10.7.236.239
```

- Une phrase de passe (*passphrase*) protège la clé : SSH demande `Enter passphrase for key` au lieu du mot de passe `root`.
- Si SSH redemande `root@10.7.236.239's password`, la clé n'a pas été copiée correctement.

---

## 4. Bridge réseau `vmbr1`

Seul `vmbr0` existait sur le serveur. Le nouveau bridge est donc `vmbr1`. `vmbr0` est le bridge principal relié au réseau réel ; il ne doit pas être modifié, car le serveur est partagé.

Vérification des bridges existants :

```bash
ip -br link | grep vmbr
```

Création et application :

```bash
pvesh create /nodes/server239/network --iface vmbr1 --type bridge --autostart 1 --comments "B300153972"
pvesh set /nodes/server239/network
ip -br link | grep vmbr
```

Résultat attendu : `vmbr0` et `vmbr1` apparaissent. Les VMs branchées sur `vmbr1` communiquent entre elles, mais n'ont pas accès à Internet sans configuration supplémentaire.

---

## 5. Machine virtuelle

La VM se crée en ligne de commande avec `qm`, l'outil Proxmox de gestion des VMs.

1. Trouver un numéro de VM libre : `qm list`
2. Vérifier les stockages : `pvesm status`
3. Lister les ISO disponibles : `ls /var/lib/vz/template/iso`
4. Créer et démarrer la VM :

```bash
qm create 150 --name vm-B300153972 --memory 2048 --cores 2 \
  --net0 virtio,bridge=vmbr1 --scsi0 local-lvm:20 \
  --ide2 local:iso/NOM-ISO.iso,media=cdrom \
  --boot 'order=ide2;scsi0' --ostype l26
qm start 150
qm list
```

| Option | Rôle |
| --- | --- |
| `--memory 2048` | 2 Go de RAM |
| `--cores 2` | 2 cœurs CPU |
| `--scsi0 local-lvm:20` | Disque de 20 Go |
| `--net0 virtio,bridge=vmbr1` | Carte réseau branchée sur `vmbr1` |
| `--ide2 ...,media=cdrom` | ISO d'installation |

L'installation du système d'exploitation se fait ensuite dans l'interface web Proxmox, onglet **Console** de la VM.

---

## État d'avancement

| Étape | État |
| --- | --- |
| Connexion SSH au serveur | ✅ Fait |
| Utilisateur admin `B300153972@pve` | ✅ Fait |
| Nom et courriel de l'utilisateur | ⏳ À confirmer |
| Clé SSH | ✅ Fait |
| Bridge `vmbr1` | ⏳ À confirmer |
| Machine virtuelle | ⬜ À faire |

### Prochaines étapes

- [x] Vérifier que `B300153972@pve` est Administrator
- [ ] Confirmer que `vmbr1` apparaît avec `ip -br link | grep vmbr`
- [ ] Créer et démarrer la VM avec `qm create` et `qm start`
