# 📡 Configuration VPN FortiClient & Virtualisation Proxmox VE

Ce document détaille la procédure d'accès à distance à l'environnement de virtualisation du Collège Boréal via VPN, ainsi que la résolution de problèmes et le démarrage d'une machine virtuelle sous Proxmox VE.

---

## 📌 Table des matières

- [1. Installation de FortiClient VPN](#1-installation-de-forticlient-vpn)
- [2. Connexion au réseau VPN](#2-connexion-au-réseau-vpn)
- [3. Accès à Proxmox VE](#3-accès-à-proxmox-ve)
- [4. Sélection et spécifications de la VM](#4-sélection-et-spécifications-de-la-vm)
- [5. Premier démarrage et résolution d'erreur](#5-premier-démarrage-et-résolution-derreur)
- [6. Correction du processeur CPU](#6-correction-du-processeur-cpu)
- [7. Redémarrage et vérification finale](#7-redémarrage-et-vérification-finale)
- [8. Bilan du laboratoire](#8-bilan-du-laboratoire)
- [📁 Organisation du dépôt](#-organisation-du-dépôt)

---

## 1. Installation de FortiClient VPN

### 1.1 Téléchargement
1. Téléchargez le client VPN officiel pour Windows.
2. Bouton utilisé : **`Télécharger VPN pour Windows`**

![Téléchargement FortiClient](images/01-telechargement-forticlient.png)

### 1.2 Installation
1. Exécutez le fichier d'installation.
2. L'écran d'installation affiche le message : `Installing FortiClient VPN`.
3. Patientez jusqu'à la fin du processus.

![Installation FortiClient](images/02-installation-forticlient.png)

---

## 2. Connexion au réseau VPN

Ouvrez l'application FortiClient VPN et établissez la connexion avec le réseau du Collège Boréal.

| Paramètre | Valeur |
| :--- | :--- |
| **Nom du VPN** | `RAVPN` |
| **Adresse IP attribuée** | `10.25.4.15` |
| **État** | `VPN connecté` |

![VPN Connecté](images/03-forticlient-connecte.png)

---

## 3. Accès à Proxmox VE

Une fois le tunnel VPN établi, ouvrez votre navigateur pour accéder à l'interface d'administration Web :

* **Plateforme :** Proxmox Virtual Environment `9.2.2`
* **Nœud (Node) :** `server56`

![Interface Proxmox](images/04-proxmox.png)

---

## 4. Sélection et spécifications de la VM

Dans l'arborescence de Proxmox, sélectionnez la machine virtuelle suivante : **`VM 106 — anta`**

### Spécifications matérielles initiales
* **Mémoire RAM :** 2 Go
* **CPU :** 1 socket / 1 core
* **Disque dur :** 32 Go
* **Carte réseau :** VirtIO
* **BIOS :** SeaBIOS

![Sélection VM 106](images/05-vm-106.png)

---

## 5. Premier démarrage et résolution d'erreur

Cliquez sur **Start** pour lancer la machine virtuelle.

### ❌ Erreur rencontrée
Le démarrage échoue prématurément avec le message suivant dans la console :

```text
kvm: warning: host doesn't support requested feature: CPUID[...].AES
TASK ERROR: start failed: QEMU exited with code 1
