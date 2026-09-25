# 300156187
# Installation de Proxmox VE 9.2 sur un HP ProLiant DL360 G6

Documentation technique d’un laboratoire de virtualisation réalisé sur un serveur **HP ProLiant DL360 G6**. Le projet couvre le diagnostic matériel, la création d’un volume RAID 5, la préparation de la clé USB et le démarrage de l’installateur Proxmox VE 9.2.

## Table des matières

- [1. Objectif du projet](#1-objectif-du-projet)
- [2. Informations système](#2-informations-système)
- [3. Diagnostic au démarrage](#3-diagnostic-au-démarrage)
- [4. Configuration du RAID 5](#4-configuration-du-raid-5)
- [5. Préparation de la clé USB](#5-préparation-de-la-clé-usb)
- [6. Démarrage de Proxmox VE](#6-démarrage-de-proxmox-ve)
- [7. Suite de l’installation](#7-suite-de-linstallation)
- [8. Vérifications après installation](#8-vérifications-après-installation)
- [9. Dépannage](#9-dépannage)
- [10. Résumé](#10-résumé)

## 1. Objectif du projet

L’objectif est de transformer un serveur physique en plateforme de virtualisation pour un laboratoire informatique. Proxmox VE permettra ensuite de créer et d’administrer des machines virtuelles et des conteneurs à partir d’une interface Web.

**Étapes réalisées :**

1. Vérification des composants détectés au démarrage.
2. Analyse des alertes matérielles.
3. Création d’un volume logique RAID 5.
4. Préparation d’une clé USB d’installation avec Rufus.
5. Démarrage de l’installateur Proxmox VE 9.2.

---

## 2. Informations système

| Composant | Configuration observée |
|---|---|
| Serveur | HP ProLiant DL360 G6 |
| Processeurs | 2 × Intel Xeon E5540 |
| Fréquence | 2,53 GHz |
| Cœurs | 8 cœurs au total |
| Hyper-Threading | Activé |
| Mémoire détectée | 40 960 Mo |
| Contrôleur RAID | HP Smart Array P410i |
| Disques | 3 × 146,8 Go SAS |
| Volume logique | RAID 5, 293,56 Go |
| Hyperviseur | Proxmox VE 9.2 |

<div align="center">
  <img src="images/Bios.jpeg" alt="Figure 1" width="80%">
  <p><em>Figure 1 — Le BIOS détecte les deux processeurs Intel Xeon E5540 et 40 960 Mo de mémoire.</em></p>
</div>

---

<image src=images/1_.jpeg width=50% height=50% > </image>
