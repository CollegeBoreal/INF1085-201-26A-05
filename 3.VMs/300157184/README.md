# 🖥️ Création d’une machine virtuelle Linux avec Proxmox

## 📌 Description

Dans ce laboratoire, j’ai créé et configuré une machine virtuelle Linux sur un serveur Proxmox VE.

L’objectif est de comprendre les principales étapes de création d’une VM : récupération d’une image ISO, création de la VM, configuration des ressources, installation du système et vérification du fonctionnement.

---

## 🎯 Objectifs

* Comprendre le fonctionnement de Proxmox VE.
* Créer une machine virtuelle.
* Utiliser une image ISO pour installer Linux.
* Configurer le processeur et la mémoire.
* Configurer le stockage.
* Configurer l’interface réseau.
* Démarrer et gérer une VM.
* Diagnostiquer une erreur de démarrage.
* Vérifier que la machine virtuelle fonctionne correctement.

---

## 🏗️ Environnement

| Élément | Configuration |
| :--- | :--- |
| **Hyperviseur** | Proxmox VE |
| **Nœud** | server56 |
| **VM ID** | 106 |
| **Nom de la VM** | anta |
| **Système** | Linux |
| **CPU** | 1 socket / 1 core |
| **RAM** | 2 Go |
| **Disque** | 32 Go |
| **BIOS** | SeaBIOS |
| **Réseau** | VirtIO |

---

## 1. 📥 Récupération de l’image ISO

La première étape consiste à récupérer l’image ISO de la distribution Linux choisie. L’image ISO est utilisée comme support d’installation du système d’exploitation.

* **Distribution utilisée :** Ubuntu

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.VMs/300157184/images/Capture%20d%E2%80%99%C3%A9cran%202026-10-01%20214048.png?raw=true)

---

## 2. 📦 Ajouter l’ISO dans Proxmox

Après avoir récupéré l’image ISO, elle est ajoutée au stockage disponible dans Proxmox. L’ISO sera ensuite utilisée lors de la création de la machine virtuelle.

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.VMs/300157184/images/Capture%20d%E2%80%99%C3%A9cran%202026-10-01%20214759.png?raw=true))

---

## 3. 🖥️ Création de la machine virtuelle

Dans Proxmox, une nouvelle machine virtuelle est créée.

* **VM ID :** 106
* **Nom :** anta

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.VMs/300157184/images/Capture%20d%E2%80%99%C3%A9cran%202026-10-01%20212003.png?raw=true))

---

## 4. ⚙️ Configuration du processeur

La VM est configurée avec un seul processeur virtuel.

* **Sockets :** 1
* **Cores :** 1

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.VMs/300157184/images/Capture%20d%E2%80%99%C3%A9cran%202026-10-01%20215545.png?raw=true))

---

## 5. 🧠 Configuration de la mémoire

La mémoire RAM attribuée à la VM est :

* **RAM :** 2048 MiB (2GIB)

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.VMs/300157184/images/Capture%20d%E2%80%99%C3%A9cran%202026-10-01%20220055.png?raw=true)

---

## 6. 💾 Configuration du disque

Un disque virtuel de 32 Go est configuré pour la machine virtuelle.

* **Disque :** 32 Go

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.VMs/300157184/images/Capture%20d%E2%80%99%C3%A9cran%202026-10-01%20220508.png?raw=true)

---

## 7. 🌐 Configuration réseau

Une interface réseau virtuelle est configurée pour permettre à la VM de communiquer avec le réseau.

* **Interface :** VirtIO

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.VMs/300157184/images/Capture%20d%E2%80%99%C3%A9cran%202026-10-01%20220809.png?raw=true))

---

## 8. ▶️ Démarrage de la VM

Une fois la configuration terminée, la machine virtuelle est démarrée avec le bouton **Start**.

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.VMs/300157184/images/Capture%20d%E2%80%99%C3%A9cran%202026-10-01%20221046.png?raw=true))

---

## 9. ⚠️ Erreur rencontrée

Lors du premier démarrage, la VM n’a pas démarré correctement. L’erreur affichée par Proxmox était liée à QEMU/KVM et à une fonctionnalité du processeur.

```text
host doesn't support requested feature: CPUID[...].AES
TASK ERROR: start failed: QEMU exited with code 1
