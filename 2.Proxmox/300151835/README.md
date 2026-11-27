# Proxmox — Liza Benhammouche

**INF1085 · 300151835**

1. Confirmer le disque d’installation sur le serveur du groupe 2. Le réseau du labo est `10.7.236.0/23`, la passerelle `10.7.237.1` et le DNS `8.8.8.8`.
2. Sur le serveur attribué, démarrer l’ISO de Proxmox VE 9 avec les paramètres validés en classe. Choisir le disque système confirmé, configurer le nom d’hôte et le réseau, puis installer et redémarrer.
3. Ouvrir l’interface HTTPS sur le port 8006. Dans le terminal de l’hôte, relever les valeurs affichées.

```bash
pveversion
ip -br address
ip route
cat /proc/cmdline
lscpu
nproc
lsmem
lsblk
lspci
lsmod
```

## Questions de réflexion

1. `nomodeset` désactive la configuration vidéo précoce par le noyau, ce qui peut contourner un écran noir.
2. `acpi=off` peut contourner des problèmes de compatibilité avec les tables ACPI d’un ancien BIOS. Ce réglage peut désactiver des fonctions de gestion du matériel et de l’énergie.
3. ACPI décrit le matériel et la gestion de l’énergie. APIC gère les interruptions.
4. `nolapic` désactive le contrôleur APIC local. Selon la plateforme, cela peut empêcher l’activation de certains processeurs logiques.
5. `cat /proc/cmdline` affiche les paramètres réellement transmis au noyau.

**À relever** — version, IP, sockets, processeurs logiques, RAM, disques et paramètres de démarrage.

## Paramètres du groupe 2

| Paramètre | Valeur du cours |
| --- | --- |
| Hôte Proxmox | `10.7.236.198/23` |
| Passerelle | `10.7.237.1` |
| DNS | `8.8.8.8` |
| Interface de gestion | [Proxmox VE](https://10.7.236.198:8006) |

Les paramètres de dépannage `nomodeset acpi=off` figurent dans la procédure du DL360 G6. Après le démarrage, vérifier les paramètres actifs et le nombre de CPU détectés.

```bash
cat /proc/cmdline
cat /sys/devices/system/cpu/online
lscpu
```

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
