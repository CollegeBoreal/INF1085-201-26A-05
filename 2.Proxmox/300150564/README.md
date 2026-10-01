# 🖥️ Installation de Proxmox VE 9 sur un HP ProLiant DL360 G6

**Ouassim Ahmed Benamira**  
**Matricule : 300150564**  
**Programme : TSIQ – Techniques des systèmes informatiques**

---

## 🎯 Objectif du laboratoire

L'objectif de ce laboratoire est d'installer **Proxmox VE 9** sur un serveur **HP ProLiant DL360 G6**.

Ce serveur étant relativement ancien, certains paramètres de démarrage sont nécessaires afin d'assurer la compatibilité avec le noyau Linux moderne utilisé par Proxmox.

À la fin de l'installation, plusieurs commandes Linux sont utilisées pour vérifier le bon fonctionnement des **processeurs, de la mémoire RAM, du stockage, des périphériques et du réseau**.

---

# 🔧 Partie 1 — Préparation du serveur

## 🔌 **Étape 1 — Démarrage du serveur HP ProLiant**

Le serveur **HP ProLiant DL360 G6** est démarré afin de vérifier son fonctionnement et d'accéder aux différentes options de configuration.

<img src="./images/IMG_2855.jpg" width="250">

<img src="./images/IMG_2856.jpg" width="250">

---

## ⚙️ **Étape 2 — Vérification de la configuration du serveur**

Lors du démarrage, les informations matérielles du serveur sont vérifiées avant de commencer l'installation de Proxmox.

<img src="./images/IMG_2857.jpg" width="250">

---

## 💾 **Étape 3 — Configuration du stockage**

Le contrôleur de stockage du serveur est configuré afin de préparer les disques pour l'installation de Proxmox VE.

<img src="./images/IMG_2860.jpg" width="250">

<img src="./images/IMG_2863.jpg" width="250">

---

# 🚀 Partie 2 — Installation de Proxmox VE 9

## 💿 **Étape 4 — Démarrage sur le support d'installation**

Le serveur est démarré à partir du support contenant l'image d'installation de **Proxmox VE 9**.

<img src="./images/IMG_2868.jpg" width="250">

---

## 🖥️ **Étape 5 — Lancement de l'installateur Proxmox**

Dans le menu de démarrage de Proxmox, l'option permettant de lancer l'installation de **Proxmox VE 9** est sélectionnée.

<img src="./images/IMG_2875.jpg" width="250">

---

## ⚙️ **Étape 6 — Paramètres de compatibilité**

Le serveur **HP ProLiant DL360 G6** étant ancien, les paramètres suivants sont utilisés pour permettre un démarrage stable :

```text
nomodeset acpi=off
```

- **`nomodeset`** : empêche l'initialisation avancée du mode graphique pendant le démarrage.
- **`acpi=off`** : désactive ACPI afin d'éviter certains problèmes de compatibilité avec l'ancien BIOS du serveur.

<img src="./images/IMG_2876.jpg" width="250">

---

## 💽 **Étape 7 — Sélection du disque d'installation**

Le disque destiné à recevoir **Proxmox VE 9** est sélectionné dans l'installateur.

<img src="./images/IMG_2877.jpg" width="250">

---

## 🌎 **Étape 8 — Configuration de la localisation**

Les paramètres de localisation sont configurés, notamment le **pays, le fuseau horaire et le clavier**.

<img src="./images/IMG_2878.jpg" width="250">

---

## 🔐 **Étape 9 — Configuration du compte administrateur**

Le compte administrateur **root** est configuré pour permettre l'administration du serveur Proxmox.

<img src="./images/IMG_2879.jpg" width="250">

> 🔒 Le mot de passe administrateur n'est pas affiché dans cette documentation.

---

## 🌐 **Étape 10 — Configuration du réseau**

Les paramètres réseau du serveur sont configurés afin de permettre l'accès à Proxmox depuis le réseau.

<img src="./images/IMG_2880.jpg" width="250">

---

## 📋 **Étape 11 — Vérification de la configuration**

Avant de lancer l'installation, un résumé permet de vérifier les paramètres sélectionnés.

<img src="./images/IMG_2881.jpg" width="250">

---

## ⏳ **Étape 12 — Installation de Proxmox VE 9**

L'installation de **Proxmox VE 9** est ensuite lancée sur le serveur.

<img src="./images/IMG_2882.jpg" width="250">

---

# ⚠️ Partie 3 — Problème rencontré

## ⚠️ **Étape 13 — Erreur d'initialisation du volume**

Pendant l'installation, une erreur liée au stockage a été rencontrée :

```text
unable to initialize physical volume /dev/sda3
```

<img src="./images/IMG_2883.jpg" width="250">

Cette erreur indique que l'installateur n'a pas réussi à initialiser correctement le volume physique **`/dev/sda3`**.

Après vérification et correction du problème de stockage, l'installation a pu être poursuivie.

---

# ✅ Partie 4 — Premier démarrage de Proxmox

## 🟢 **Étape 14 — Démarrage réussi**

Après l'installation, le serveur démarre correctement sous **Proxmox Virtual Environment**.

<img src="./images/IMG_2884.jpg" width="250">

L'écran de connexion confirme que Proxmox VE est installé et fonctionnel.

---

# 🔍 Partie 5 — Vérification du système

## ⚙️ **Étape 15 — Vérification des paramètres du noyau**

La commande suivante permet de vérifier les paramètres réellement utilisés lors du démarrage du noyau Linux :

```bash
cat /proc/cmdline
```

<img src="./images/IMG_2886.jpg" width="250">

On peut notamment vérifier la présence de :

```text
nomodeset acpi=off
```

Cela confirme que les paramètres de compatibilité sont bien appliqués.

---

## 🧠 **Étape 16 — Vérification des processeurs**

La commande suivante affiche les informations détaillées concernant le processeur :

```bash
lscpu
```

<img src="./images/IMG_2889.jpg" width="250">

Le système détecte le processeur **Intel Xeon E5540 @ 2.53 GHz** ainsi que **8 CPU logiques**.

---

## 🔢 **Étape 17 — Vérification du nombre de processeurs disponibles**

La commande :

```bash
nproc
```

permet d'afficher le nombre de processeurs disponibles pour le système.

<img src="./images/IMG_2890.jpg" width="250">

Résultat obtenu :

```text
8
```

Le système dispose donc de **8 processeurs logiques disponibles**.

---

## 🟢 **Étape 18 — Vérification des CPU actifs**

La commande suivante permet de vérifier quels processeurs sont actuellement en ligne :

```bash
cat /sys/devices/system/cpu/online
```

<img src="./images/IMG_2894.jpg" width="250">

Résultat :

```text
0-7
```

Cela confirme que les **8 CPU logiques sont actifs**.

Les paramètres `nolapic` et `noapic` ne doivent pas être utilisés, car ils peuvent perturber la gestion des interruptions et le fonctionnement multiprocesseur.

---

## 🧮 **Étape 19 — Vérification de la mémoire RAM**

La commande suivante est utilisée :

```bash
lsmem
```

<img src="./images/IMG_2888.jpg" width="250">

Le système indique environ **66 Go de mémoire en ligne**, confirmant que la mémoire est reconnue par Linux.

---

## 💽 **Étape 20 — Vérification du stockage**

La commande suivante permet d'afficher les disques, les partitions et les volumes :

```bash
lsblk
```

<img src="./images/IMG_2891.jpg" width="250">

Le système détecte notamment :

- le disque principal d'environ **273,4 Go** ;
- les volumes **pve-root**, **pve-swap** et **pve-data** ;
- un disque NVMe d'environ **953,9 Go**.

---

## 🧩 **Étape 21 — Vérification des périphériques PCI**

La commande :

```bash
lspci
```

permet d'identifier les différents périphériques PCI présents dans le serveur.

<img src="./images/IMG_2892.jpg" width="250">

On retrouve notamment les contrôleurs **réseau, RAID, VGA et NVMe** du serveur.

---

## 📦 **Étape 22 — Vérification des modules Linux**

La commande :

```bash
lsmod
```

affiche les modules actuellement chargés par le noyau Linux.

<img src="./images/IMG_2893.jpg" width="250">

On retrouve notamment des modules associés au **NVMe, au stockage HP et aux interfaces réseau**.

---

## ⚡ **Étape 23 — Vérification des interruptions**

La commande suivante permet d'afficher les interruptions gérées par le système :

```bash
cat /proc/interrupts
```

<img src="./images/IMG_2895.jpg" width="250">

Cette vérification permet d'observer la gestion des interruptions matérielles entre les processeurs.

---

# 🌐 Partie 6 — Vérification du réseau

## 🌍 **Étape 24 — Vérification des interfaces réseau**

La commande suivante affiche les interfaces et les adresses IP configurées :

```bash
ip a
```

<img src="./images/IMG_2896.jpg" width="250">

Les interfaces physiques ainsi que le bridge réseau **`vmbr0`** de Proxmox sont visibles.

---

## 🔗 **Étape 25 — Vérification du bridge Proxmox**

L'interface **`vmbr0`** est le bridge réseau utilisé par Proxmox pour permettre la communication du serveur et des futures machines virtuelles avec le réseau.

<img src="./images/IMG_2897.jpg" width="250">

---

## 📡 **Étape 26 — Test de connectivité**

Un test `ping` est effectué afin de confirmer le fonctionnement de la connexion réseau :

```bash
ping 10.7.237.28
```

<img src="./images/IMG_2898.jpg" width="250">

La réception des réponses confirme que la communication réseau fonctionne correctement. ✅

---

# 📝 Questions de réflexion

## ❓ **1. À quoi sert le paramètre `nomodeset` ?**

Le paramètre **`nomodeset`** empêche le noyau Linux d'activer immédiatement le **Kernel Mode Setting (KMS)** pour la carte graphique.

Il est particulièrement utile sur du matériel ancien lorsqu'un pilote graphique provoque un **écran noir, un blocage ou un problème d'affichage** pendant le démarrage.

---

## ❓ **2. Pourquoi un ancien BIOS peut-il nécessiter `acpi=off` ?**

Un ancien BIOS peut contenir des tables **ACPI** qui ne sont pas entièrement compatibles avec les noyaux Linux modernes.

L'utilisation de :

```text
acpi=off
```

désactive ACPI et peut permettre au système de démarrer correctement lorsqu'un problème de compatibilité empêche le démarrage normal.

---

## ❓ **3. Quelle est la différence entre ACPI et APIC ?**

**ACPI (Advanced Configuration and Power Interface)** est principalement utilisé pour la configuration du matériel et la gestion de l'alimentation.

**APIC (Advanced Programmable Interrupt Controller)** est utilisé pour gérer et distribuer les interruptions matérielles entre les processeurs.

En résumé :

**ACPI → configuration et alimentation**  
**APIC → gestion des interruptions**

---

## ❓ **4. Pourquoi `nolapic` peut-il réduire le nombre de processeurs visibles ?**

Le **LAPIC (Local APIC)** permet à chaque processeur de gérer les interruptions nécessaires au fonctionnement multiprocesseur.

L'utilisation du paramètre :

```text
nolapic
```

désactive cette fonctionnalité et peut empêcher Linux d'utiliser correctement plusieurs processeurs.

Le système peut alors fonctionner avec un nombre réduit de CPU disponibles.

---

## ❓ **5. Quelle commande permet de vérifier les paramètres réellement utilisés lors du démarrage du noyau Linux ?**

La commande est :

```bash
cat /proc/cmdline
```

Elle affiche la ligne de commande réellement transmise au noyau Linux lors du démarrage.

Dans ce laboratoire, elle permet notamment de vérifier la présence de :

```text
nomodeset acpi=off
```

---

# ✅ Conclusion

L'installation de **Proxmox VE 9** sur le serveur **HP ProLiant DL360 G6** a permis de mettre en pratique l'installation et la configuration d'un hyperviseur sur un serveur physique.

En raison de l'ancienneté du matériel, les paramètres :

```text
nomodeset acpi=off
```

ont été utilisés afin d'améliorer la compatibilité avec le noyau Linux.

Les différentes vérifications effectuées avec `lscpu`, `nproc`, `lsmem`, `lsblk`, `lspci`, `lsmod`, `ip a` et `ping` ont permis de confirmer le fonctionnement des principaux composants du serveur.

Le serveur **Proxmox VE 9 est maintenant installé et opérationnel**, et peut être utilisé pour la création et la gestion de machines virtuelles. ✅
