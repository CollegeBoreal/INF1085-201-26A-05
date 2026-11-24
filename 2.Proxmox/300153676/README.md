# Installation de Proxmox VE sur le DL360 G6

Lyes Medjahed · 300153676 · Groupe 2

La fiche du cours prévoit un démarrage sur la clé USB Proxmox, puis une installation sur le volume RAID. L’interface du groupe est accessible depuis le réseau du labo à `https://10.7.236.198:8006`.

## Questions de réflexion

1. `nomodeset` désactive le réglage du mode vidéo par le noyau. Il peut permettre à l’installateur de rester visible sur une ancienne carte graphique.
2. Un ancien BIOS peut fournir des tables ACPI incompatibles avec Linux. `acpi=off` désactive leur utilisation pour le dépannage.
3. ACPI décrit le matériel et gère notamment l’énergie. APIC sert à distribuer les interruptions aux processeurs.
4. `nolapic` désactive le contrôleur local d’interruptions. Sur ce matériel, cela peut empêcher Linux de démarrer les autres processeurs logiques.
5. `cat /proc/cmdline` affiche les paramètres utilisés pour le démarrage actuel.

## Vérification sur le serveur

`lscpu` indique les sockets et les cœurs détectés. `free -h` affiche la mémoire, `lsblk` les disques et `lspci` les périphériques PCI. Les sorties du serveur restent à relever.
