
# 🌍 Projet – Déploiement d'AfriMarché sur une VM Proxmox

**🆔 Étudiante :** 300157184
**🖥️ Serveur :** server56 — Proxmox VE 9.2.2
**💻 VM :** 100 (VM-300157184)
**🌐 Site :** http://10.7.236.206
**🔑 Accès SSH :** `ssh anta@10.7.236.206`

---

## 🎯 Objectif

Héberger sur **mon propre serveur Linux** le prototype web d'**AfriMarché**, une boutique de produits 100 % africains (épicerie, beauté, artisanat, mode).

Ce projet relie deux cours :

| Cours | Ma réalisation |
|---|---|
| **INF1083 – Application mobile** | Conception de l'application AfriMarché (NativeScript) et de son prototype cliquable en HTML, CSS et JavaScript |
| **INF1085 – Linux / Proxmox** | Préparation d'une VM Linux, installation d'un serveur web Apache et mise en ligne du prototype |

![AfriMarché servi par ma VM](images/03-afrimarche-vm.png)

---

## 🧱 Architecture

```
        Navigateur (PC)
              │
              ▼
  http://10.7.236.206  (réseau du collège)
              │
┌─────────────┴──────────────────────────┐
│  Proxmox VE — server56                 │
│  ┌──────────────────────────────────┐  │
│  │ VM 100 — Kali Linux              │  │
│  │ Disque : nvme-storage (32 Go)    │  │
│  │                                  │  │
│  │ Apache2  →  /var/www/html        │  │
│  │   ├── index.html                 │  │
│  │   ├── style.css                  │  │
│  │   └── script.js                  │  │
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

| Élément | Technologie |
|---|---|
| Hyperviseur | Proxmox VE 9.2.2 |
| Système | Kali Linux Rolling (installation minimale) |
| Ressources VM | 1 vCPU · 2 Go RAM · 32 Go sur `nvme-storage` |
| Serveur web | Apache 2.4.69 |
| Site | HTML · CSS · JavaScript (prototype AfriMarché) |
| Installés pour la suite | PHP 8.4, MariaDB |

---

## 1️⃣ Préparation de la VM

### Réseau : correction de l'interface

La configuration réseau utilisait `ens18`, mais l'interface de la VM s'appelle `eth0`. La VM n'avait donc pas d'adresse IP.

```bash
ip a                                   # eth0 : state DOWN, pas d'IP
sudo sed -i s/ens18/eth0/g /etc/network/interfaces
sudo ifup eth0
```

### IP fixe

Pour que l'adresse du site ne change plus, j'ai remplacé le DHCP par une IP statique dans `/etc/network/interfaces` :

```
auto eth0
iface eth0 inet static
    address 10.7.236.206/23
    gateway 10.7.237.1
```

Vérification après `sudo reboot` :

```bash
ip a show eth0
# inet 10.7.236.206/23 ... valid_lft forever
```

---

## 2️⃣ Installation du serveur web

### Dépôts Kali

L'installation minimale n'avait aucun dépôt APT configuré (`Unable to locate package`). J'ai ajouté le dépôt officiel :

```bash
echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list
sudo apt update
```

### Apache, PHP et MariaDB

```bash
sudo apt install -y apache2 mariadb-server php libapache2-mod-php php-mysql
sudo systemctl enable --now apache2 mariadb
```

> Sur Kali, les services réseau ne démarrent pas automatiquement par sécurité. `enable --now` les démarre et les active au démarrage.

![Apache fonctionne](images/01-apache-it-works.png)

---

## 3️⃣ Déploiement d'AfriMarché

### Envoi des fichiers (depuis mon PC, dans VS Code)

```powershell
cd 300157184
scp -r prototype anta@10.7.236.206:/tmp/afri
```

### Mise en ligne (sur la VM)

```bash
ssh anta@10.7.236.206
sudo rm -rf /var/www/html/*
sudo cp -r /tmp/afri/* /var/www/html/
sudo chmod -R a+rX /var/www/html
```

> `chmod -R a+rX` donne à Apache le droit de lire les fichiers et d'entrer dans les dossiers. Sans cela, le navigateur reçoit une erreur `403 Forbidden`.

![Déploiement en SSH](images/02-deploiement-ssh.png)

---

## 🐞 Problèmes rencontrés et solutions

| Problème | Cause | Solution |
|---|---|---|
| Connexion impossible à la VM | Mot de passe oublié | Montage du disque depuis Proxmox (`losetup`, `mount`) et `chroot … passwd` |
| `Login incorrect` avec le bon mot de passe | Clavier de la console différent (`@` devenait `«`) | Mot de passe en lettres minuscules seulement |
| Pas d'adresse IP | Config réseau sur `ens18`, interface réelle `eth0` | Remplacer `ens18` par `eth0` |
| IP qui change | DHCP | IP statique `10.7.236.206/23` |
| `Unable to locate package apache2` | Aucun dépôt APT | Ajout du dépôt `kali-rolling` |
| Page « Index of / » vide | Les fichiers n'avaient pas été envoyés (`/tmp/afri` absent) | Relancer `scp` depuis le bon dossier sur Windows |
| `403 Forbidden` | Droits de lecture manquants | `sudo chmod -R a+rX /var/www/html` |

---

## 🔄 Mettre le site à jour

```powershell
# Sur mon PC
scp -r prototype anta@10.7.236.206:/tmp/afri
```
```bash
# Sur la VM
sudo rm -rf /var/www/html/*
sudo cp -r /tmp/afri/* /var/www/html/
sudo chmod -R a+rX /var/www/html
```

---

## ✅ Résultat

- ✅ VM opérationnelle avec IP fixe et accès SSH
- ✅ Apache installé et démarré automatiquement
- ✅ Prototype AfriMarché servi par ma propre VM sur http://10.7.236.206
- ✅ Recherche, catégories, fiche produit, panier et profil fonctionnent dans le navigateur

## 🚀 Améliorations possibles

- Ajouter **HTTPS** avec un certificat (Apache + `mod_ssl`)
- Stocker le catalogue et les commandes dans **MariaDB** avec une petite API en **PHP**
- Automatiser le déploiement avec un script
- 
