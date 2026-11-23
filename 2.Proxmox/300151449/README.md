# 🖥️ Installation de Proxmox VE 9 sur HP ProLiant DL360 G6

**Nom :** MOHTARAM EL ALAOUI Abderrahim  
**Matricule :** 300151449  
**Cours :** INF1085 – Administration Linux  
**Établissement :** Collège Boréal

---

## 🎯 Objectif du laboratoire

Ce laboratoire porte sur l'installation de **Proxmox Virtual Environment 9** sur un serveur **HP ProLiant DL360 G6**.

Les objectifs sont de comprendre la préparation du serveur, l'installation de Proxmox, la configuration du réseau et les commandes Linux utilisées pour vérifier le fonctionnement du matériel.

Le serveur étant ancien, les paramètres de démarrage `nomodeset` et `acpi=off` sont étudiés afin de comprendre les problèmes de compatibilité possibles.

---

# 🔧 Partie 1 — Préparation du serveur

## Étape 1 — Démarrage du serveur

Le serveur HP ProLiant DL360 G6 est mis sous tension afin d'accéder aux paramètres du BIOS et de vérifier le fonctionnement du matériel.

![Démarrage du serveur](images/IMG_2855.jpg)

![Écran de démarrage](images/IMG_2856.jpg)

## Étape 2 — Vérification du matériel

Les informations matérielles sont consultées pendant le démarrage afin de vérifier les processeurs, la mémoire et les périphériques détectés.

![Configuration matérielle](images/IMG_2857.jpg)

## Étape 3 — Configuration du stockage

Le contrôleur de stockage permet de préparer les disques destinés à l'installation de Proxmox.

![Configuration du stockage](images/IMG_2860.jpg)

![Contrôleur de stockage](images/IMG_2863.jpg)

---

# 🚀 Partie 2 — Installation de Proxmox VE 9

## Étape 4 — Préparation du support d'installation

L'image ISO de Proxmox VE 9 peut être copiée sur une clé USB démarrable à l'aide de Rufus.

Le menu de démarrage du serveur est accessible avec la touche **F11**.

![Support d'installation](images/IMG_2868.jpg)

## Étape 5 — Lancement de Proxmox

Dans le menu d'installation, sélectionner **Install Proxmox VE**.

![Menu Proxmox](images/IMG_2875.jpg)

## Étape 6 — Paramètres de compatibilité

Sur ce serveur ancien, les paramètres suivants peuvent être nécessaires :

```text
nomodeset acpi=off
```

- `nomodeset` : empêche l'initialisation avancée du mode graphique.
- `acpi=off` : désactive ACPI pour contourner certains problèmes de compatibilité avec le BIOS.

Dans le menu de démarrage, appuyer sur `e`, ajouter les paramètres à la ligne Linux, puis démarrer avec `Ctrl + X` ou `F10`.

![Paramètres de démarrage](images/IMG_2876.jpg)

## Étape 7 — Sélection du disque

Le disque destiné à recevoir Proxmox est sélectionné dans l'installateur.

![Sélection du disque](images/IMG_2877.jpg)

## Étape 8 — Configuration de la localisation

Configurer le pays, le fuseau horaire et la disposition du clavier.

![Localisation](images/IMG_2878.jpg)

## Étape 9 — Compte administrateur

Le compte `root` permet d'administrer Proxmox. Un mot de passe et une adresse courriel sont configurés pendant l'installation.

![Configuration administrateur](images/IMG_2879.jpg)

## Étape 10 — Configuration réseau

Les paramètres réseau indiqués dans le laboratoire sont :

| Paramètre | Valeur |
|---|---|
| Réseau | `10.7.236.0/23` |
| Passerelle | `10.7.237.1` |
| DNS | `8.8.8.8` |
| Bridge Proxmox | `vmbr0` |

L'adresse IP de gestion dépend du serveur attribué.

![Configuration réseau](images/IMG_2880.jpg)

## Étape 11 — Vérification de la configuration

Avant l'installation, vérifier le disque, le nom d'hôte et les paramètres réseau.

![Résumé de configuration](images/IMG_2881.jpg)

## Étape 12 — Installation de Proxmox

L'installateur copie les fichiers du système sur le disque sélectionné.

![Installation Proxmox](images/IMG_2882.jpg)

---

# ⚠️ Partie 3 — Dépannage

## Étape 13 — Erreur possible du stockage

La documentation du laboratoire présente l'erreur suivante :

```text
unable to initialize physical volume /dev/sda3
```

Cette erreur peut nécessiter une vérification des partitions et de la configuration du stockage.

![Exemple d'erreur du stockage](images/IMG_2883.jpg)

---

# ✅ Partie 4 — Premier démarrage

## Étape 14 — Console Proxmox

Après une installation réussie, le serveur affiche une console Proxmox.

L'interface Web est accessible à l'adresse :

```text
https://ADRESSE_IP_DU_SERVEUR:8006
```

![Console Proxmox](images/IMG_2884.jpg)

---

# 🔍 Partie 5 — Vérifications Linux

Les commandes suivantes permettent de vérifier le fonctionnement d'un serveur Proxmox. Les captures ci-dessous illustrent des résultats de référence.

## Étape 15 — Paramètres du noyau

```bash
cat /proc/cmdline
```

Cette commande affiche les paramètres réellement utilisés au démarrage du noyau.

![Paramètres du noyau](images/IMG_2886.jpg)

## Étape 16 — Informations CPU

```bash
lscpu
```

Cette commande affiche le modèle du processeur, les sockets, les cœurs et les processeurs logiques.

![Informations CPU](images/IMG_2889.jpg)

## Étape 17 — Nombre de processeurs

```bash
nproc
```

Exemple de résultat dans la documentation :

```text
8
```

![Nombre de processeurs](images/IMG_2890.jpg)

## Étape 18 — Processeurs actifs

```bash
cat /sys/devices/system/cpu/online
```

Exemple :

```text
0-7
```

Cette valeur indique huit processeurs logiques actifs.

![Processeurs actifs](images/IMG_2894.jpg)

## Étape 19 — Mémoire RAM

```bash
lsmem
```

Cette commande affiche les plages de mémoire détectées par Linux.

![Mémoire RAM](images/IMG_2888.jpg)

## Étape 20 — Disques et partitions

```bash
lsblk
```

Cette commande affiche les disques, les partitions et les volumes, notamment `pve-root`, `pve-swap` et `pve-data` lorsqu'ils sont présents.

![Stockage](images/IMG_2891.jpg)

## Étape 21 — Périphériques PCI

```bash
lspci
```

Cette commande permet d'identifier les contrôleurs réseau, graphiques et de stockage.

![Périphériques PCI](images/IMG_2892.jpg)

## Étape 22 — Modules Linux

```bash
lsmod
```

Cette commande affiche les modules actuellement chargés par le noyau Linux.

![Modules Linux](images/IMG_2893.jpg)

## Étape 23 — Interruptions matérielles

```bash
cat /proc/interrupts
```

Cette commande permet d'examiner les interruptions gérées par le système.

![Interruptions](images/IMG_2895.jpg)

---

# 🌐 Partie 6 — Vérification du réseau

## Étape 24 — Interfaces réseau

```bash
ip a
```

Cette commande affiche les interfaces réseau et leurs adresses IP.

![Interfaces réseau](images/IMG_2896.jpg)

## Étape 25 — Bridge Proxmox

Le bridge `vmbr0` permet de connecter le serveur et les machines virtuelles au réseau.

![Bridge vmbr0](images/IMG_2897.jpg)

## Étape 26 — Test de connectivité

```bash
ping -c 4 10.7.237.28
```

Cette commande teste la communication avec une machine du réseau du laboratoire.

![Test de connectivité](images/IMG_2898.jpg)

---

# 📝 Questions de réflexion

## 1. À quoi sert `nomodeset` ?

Le paramètre `nomodeset` empêche l'activation immédiate du Kernel Mode Setting (KMS). Il peut résoudre certains problèmes d'affichage sur du matériel ancien.

## 2. Pourquoi un ancien BIOS peut-il nécessiter `acpi=off` ?

Certains anciens BIOS possèdent des tables ACPI incompatibles avec les noyaux Linux modernes. Le paramètre `acpi=off` peut permettre de contourner ces problèmes.

## 3. Quelle est la différence entre ACPI et APIC ?

**ACPI** sert principalement à la configuration du matériel et à la gestion de l'alimentation.

**APIC** sert à la gestion et à la distribution des interruptions matérielles entre les processeurs.

## 4. Pourquoi `nolapic` peut-il réduire le nombre de processeurs visibles ?

Le paramètre `nolapic` désactive le contrôleur local d'interruptions. Cela peut empêcher Linux d'utiliser correctement plusieurs processeurs.

## 5. Quelle commande permet de vérifier les paramètres utilisés au démarrage ?

```bash
cat /proc/cmdline
```

Cette commande affiche la ligne de commande transmise au noyau Linux.

---

# ✅ Conclusion

Ce laboratoire permet de comprendre les principales étapes de l'installation de **Proxmox VE 9** sur un serveur **HP ProLiant DL360 G6**.

L'étude des paramètres `nomodeset` et `acpi=off` montre l'importance de la compatibilité matérielle. Les commandes Linux présentées permettent de vérifier les processeurs, la mémoire, les disques, les périphériques PCI et le réseau.

Les résultats d'une installation et des vérifications personnelles restent à ajouter après leur réalisation.

---

## 📚 Références

- Collège Boréal — INF1085, `2.Proxmox/README.md`.
- Documentation illustrative et photographies : étudiant 300150564, `2.Proxmox/300150564/README.md`.
- Site officiel : https://www.proxmox.com/
