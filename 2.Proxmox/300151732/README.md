# 🖥️ Installation de Proxmox VE

**Étape 2 · Proxmox · Administration Linux**

| | |
|---|---|
| **Nom** | Nabil Hafsi |
| **ID** | `300151732` |
| **Courriel** | 300151732@monboreal.ca |
| **Dépôt** | `INF1085-201-26A-05` |

---

## 1. 💾 Préparation de la clé USB

Création d'une clé USB bootable avec **Rufus** à partir de l'image `proxmox-ve_9.2-1.iso`.

<p align="center">
  <img src="images/01-cle-usb-rufus.png" alt="Rufus : clé USB bootable avec l'ISO de Proxmox VE 9.2" width="350">
</p>

---

## 2. 💽 Configuration des disques

Avant l'installation, le contrôleur **HP Smart Array P410i** est configuré : un volume logique en **RAID 5** de 273,4 Go est créé, puis la configuration est enregistrée avec `F8`.

<p align="center">
  <img src="images/02-configuration-raid5.jpg" alt="Smart Array P410i : volume logique RAID 5 de 273,4 Go" width="500">
</p>

---

## 3. 🔌 Démarrage sur l'ISO de Proxmox

Le serveur démarre sur la clé USB et affiche le menu d'installation de **Proxmox VE 9.2**.

<p align="center">
  <img src="images/03-menu-demarrage-proxmox.jpg" alt="Menu de démarrage de Proxmox VE 9.2" width="500">
</p>

---

## 4. ✏️ Paramètres de démarrage

Sur ce serveur ancien (HP ProLiant DL360 G6), la ligne de démarrage est modifiée avec la touche `e`, en ajoutant les paramètres **`nomodeset acpi=off`** à la fin de la ligne du noyau. Le démarrage se lance ensuite avec `Ctrl + X` ou `F10`.

| Paramètre | Rôle |
|---|---|
| `nomodeset` | Utilise un mode vidéo minimal, car le contrôleur graphique du serveur est très ancien |
| `acpi=off` | Désactive ACPI, dont les tables fournies par l'ancien BIOS sont incompatibles avec les noyaux récents |

<p align="center">
  <img src="images/04-grub-nomodeset-acpi-off.jpg" alt="Modification de la ligne GRUB avec nomodeset acpi=off" width="350">
</p>

---

## 5. 📜 Démarrage de l'installateur

Le journal de démarrage montre que l'installateur trouve l'image ISO, charge les pilotes, détecte les deux cartes réseau, obtient une offre DHCP, puis lance l'interface d'installation.

<p align="center">
  <img src="images/05-installateur-journal-demarrage.jpg" alt="Journal de démarrage de l'installateur Proxmox" width="500">
</p>

---

## 6. 🌐 Configuration du réseau

L'installateur demande l'interface de gestion, le nom d'hôte (FQDN), l'adresse IP avec son masque, la passerelle et le serveur DNS.

<p align="center">
  <img src="images/06-configuration-reseau.jpg" alt="Configuration réseau de l'installateur Proxmox" width="500">
</p>

---

## 7. ✅ Interface web de Proxmox

Une fois l'installation terminée, l'interface web est accessible dans un navigateur à l'adresse `https://10.7.236.198:8006` (version **Proxmox VE 9.2.2**, nœud `server198`). Le message « Non sécurisé » du navigateur est normal : Proxmox utilise un certificat auto-signé.

<p align="center">
  <img src="images/07-interface-web-proxmox.png" alt="Interface web de Proxmox VE 9.2.2" width="700">
</p>

---

<p align="center">
  <sub>Réalisé par <b>Nabil Hafsi</b> · ID <code>300151732</code> · Administration Linux</sub>
</p>
