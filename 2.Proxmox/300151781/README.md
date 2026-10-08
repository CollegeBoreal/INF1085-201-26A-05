# 🖥️ Installation de Proxmox VE 9 sur un HP ProLiant DL360 G6

**Allouti Lounes**  
**Matricule :** 300151781  
**Programme :** TSIQ – Techniques des systèmes informatiques  

---

## 🎯 Objectif du laboratoire
L'objectif de ce laboratoire est d'installer Proxmox VE 9 sur un serveur HP ProLiant DL360 G6.  
Ce serveur étant relativement ancien, certains paramètres de démarrage sont nécessaires afin d'assurer la compatibilité avec le noyau Linux moderne utilisé par Proxmox[cite: 21].  
À la fin de l'installation, plusieurs commandes Linux sont utilisées pour vérifier le bon fonctionnement des processeurs, de la mémoire RAM, du stockage, des périphériques et du réseau[cite: 21, 32, 39].

---

## 🔧 Partie 1 — Préparation du serveur

### 🔌 Étape 1 — Démarrage du serveur HP ProLiant
Le serveur HP ProLiant DL360 G6 est démarré afin de vérifier son fonctionnement et d'accéder aux différentes options de configuration[cite: 3, 8].

![Vue d'ensemble du serveur HP ProLiant DL360 G6 ouvert](images/image_3.png)[cite: 3]
![Disque dur 2.5 pouces monté dans son caddy](images/image_7.png)[cite: 7]

---

### ⚙️ Étape 2 — Vérification de la configuration du serveur
Lors du démarrage, les informations matérielles du serveur sont vérifiées dans le BIOS avant de commencer l'installation[cite: 9, 10, 12].

![Socket processeur LGA1366 ouvert](images/image.png)[cite: 1]
![Sockets processeurs préparés avec la pâte thermique](images/image_6.png)[cite: 6]
![Barrettes de mémoire RAM DDR3](images/image_4.png)[cite: 4]
![Détection initiale des processeurs Xeon et de la RAM au boot](images/image_10.png)[cite: 10]
![Confirmation BIOS des 64 GB de RAM configurés](images/image_12.png)[cite: 12]
![Répartition détaillée des cartes RAM par emplacement DIMM](images/image_14.png)[cite: 14]

---

### 💾 Étape 3 — Configuration du stockage
Le contrôleur de stockage intégré **HP Smart Array P410i** est configuré afin de préparer les disques pour l'installation[cite: 13, 15].

![Menu principal du contrôleur RAID HP Smart Array P410i](images/image_13.png)[cite: 13]
![Volume logique RAID 5 (273.4 GB) avant suppression](images/image_15.png)[cite: 15]
![Confirmation de suppression du volume RAID](images/image_16.png)[cite: 16]
![Écran prêt pour la création du nouveau volume RAID](images/image_18.png)[cite: 18]

---

## 🚀 Partie 2 — Installation de Proxmox VE 9

### 💿 Étape 4 — Démarrage sur le support d'installation
Création d'un support d'installation USB bootable avec l'image `proxmox-ve_9.2-1.iso` à l'aide de l'outil Rufus[cite: 11].

![Préparation du support USB bootable Proxmox VE 9 avec Rufus](images/image_11.png)[cite: 11]

---

### 🖥️ Étape 5 — Lancement de l'installateur Proxmox
Dans le menu de démarrage, l'installation de Proxmox VE est initialisée[cite: 21, 26].

---

### ⚙️ Étape 6 — Paramètres de compatibilité
Le serveur HP ProLiant DL360 G6 étant ancien, les paramètres de noyau suivants sont utilisés pour permettre un démarrage stable[cite: 21, 39] :
`nomodeset acpi=off`
- **`nomodeset`** : empêche l'initialisation avancée du mode graphique pendant le démarrage.
- **`acpi=off`** : désactive ACPI afin d'éviter les problèmes d'incompatibilité avec l'ancien BIOS du serveur.

---

### 💽 Étape 7 — Sélection du disque d'installation
Le disque cible (volume logique configuré sur la carte RAID) est sélectionné dans l'installateur.

---

### 🌎 Étape 8 — Configuration de la localisation
Configuration des paramètres de localisation (pays, fuseau horaire, disposition du clavier).

---

### 🔐 Étape 9 — Configuration du compte administrateur
Définition du mot de passe du compte administrateur `root` et de l'adresse courriel de contact.

---

### 🌐 Étape 10 — Configuration du réseau
Saisie des paramètres réseau requis pour le serveur[cite: 32, 36] :
- **IP :** `10.7.237.28/23`[cite: 32, 36]
- **Passerelle (Gateway) :** `10.7.237.1`[cite: 36]
- **DNS :** `8.8.8.8`[cite: 36]

![Tableau des adresses réseau du laboratoire](images/image_36.png)[cite: 36]

---

### 📋 Étape 11 — Vérification de la configuration
Vérification du récapitulatif des paramètres avant le lancement du processus d'écriture sur le disque.

---

### ⏳ Étape 12 — Installation de Proxmox VE 9
Lancement de la copie des fichiers et de l'installation du système Proxmox VE.

---

## ⚠️ Partie 3 — Problème rencontré

### ⚠️ Étape 13 — Erreur d'initialisation du volume
Pendant l'installation, une erreur liée au sous-système de stockage est survenue[cite: 22] :
> **`Installation failed! Proxmox VE could not be installed.`**  
> **`unable to initialize physical volume /dev/sda3`**[cite: 22]

![Message d'erreur d'initialisation /dev/sda3](images/image_22.png)[cite: 22]

Cette erreur indique que l'installateur n'a pas réussi à initialiser correctement le volume physique LVM sur la partition `/dev/sda3`[cite: 22]. Après réinitialisation complète de la grappe de disques sur le contrôleur RAID HP Smart Array[cite: 13, 17], la création de la table de partition s'est déroulée correctement et l'installation a pu aboutir[cite: 19, 20, 26].

---

## ✅ Partie 4 — Premier démarrage de Proxmox

### 🟢 Étape 14 — Démarrage réussi
Après la correction du stockage, le serveur redémarre correctement sous Proxmox Virtual Environment[cite: 26, 29].

![Fin d'installation en console et invite de retrait du support](images/image_26.png)[cite: 26]
![Validation BIOS post-installation avec 64 GB détectés](images/image_29.png)[cite: 29]

---

## 🔍 Partie 5 — Vérification du système

### ⚙️ Étape 15 — Vérification des paramètres du noyau
La commande suivante permet de vérifier les paramètres réellement appliqués lors du démarrage du noyau Linux :
```bash
cat /proc/cmdline
