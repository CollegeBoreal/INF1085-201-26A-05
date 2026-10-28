**Rapport de Laboratoire : Installation et Configuration de Proxmox VE 9 sur HP ProLiant DL360 G6**

*Documentation technique complète des opérations de déploiement, débogage noyau, diagnostic et câblage réseau*

**1\. Contextualisation et Objectifs**

![Figure : Objectifs et contexte du laboratoire Proxmox VE 9 sur HP DL360 G6](./images/image-001.png)

*Figure : Objectifs et contexte du laboratoire Proxmox VE 9 sur HP DL360 G6*

Le serveur HP ProLiant DL360 G6 est une plate-forme matérielle d'ancienne génération (commercialisée vers 2009–2010). L'installation d'une version récente d'hyperviseur telle que Proxmox VE 9 (basée sur un noyau Linux 6.x/7.x moderne) pose des défis majeurs de compatibilité matérielle.

**1.1 Problématiques fréquentes sur matériel hérité (Legacy)**

-   **•** Écran noir lors du chargement du noyau Linux.
-   **•** Blocage du processus de démarrage (Boot freeze).
-   **•** Erreurs liées aux tables ACPI et à la gestion des interruptions APIC.
-   **•** Mauvaise détection ou omission de certains cœurs processeurs.
-   **•** Erreurs de bus PCI et d'adressage mémoire.

**1.2 Objectifs réalisés dans ce laboratoire**

-   **1\.** Installer et stabiliser Proxmox VE 9 sur le serveur HP ProLiant DL360 G6.
-   **2\.** Ajuster la ligne de commande du noyau (cmdline) pour contourner les blocages vidéo.
-   **3\.** Diagnostiquer et valider le support processeur, la RAM et les fonctions APIC/MCE.
-   **4\.** Raccorder physiquement le serveur au réseau, configurer l'adressage IP et valider la connectivité (passerelle et Internet).
-   **5\.** Valider la gestion distante via SSH et l'interface Web Proxmox (PVE UI).

**2\. Infrastructure Matérielle et Câblage Réseau**

![Figure : Raccordement réseau du serveur sur le switch Cisco (Baie / Cabinet 2)](./images/Image%20WhatsApp%20du%2007-10-2026%20%C3%A0%2012.50.11%20(1).jpeg)

*Figure : Raccordement réseau du serveur sur le switch Cisco (Baie / Cabinet 2)*

Pour garantir un fonctionnement stable du nœud de virtualisation, les équipements matériels et le raccordement physique au sein de la baie de brassage ont été inspectés et configurés.

**2.1 Description de l'équipement**

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-003.jpeg)

*Figure : Vue arrière du serveur HP ProLiant DL360 G6 avec voyants d'alimentation et réseau actifs*

-   **• Serveur :** Serveur physique HP ProLiant DL360 G6 (identifié sous le nom d'hôte server237).
-   **• Switch :** Commutateur Cisco à 24/48 ports installé dans le Cabinet 2 de la baie de brassage.
-   **• Câblage :** Liaisons RJ45 Cat6/6A raccordées sur les cartes réseau intégrées Broadcom (bnx2). Les voyants d'activité vert/bleu confirment la liaison physique (Link State UP).

**3\. Débogage du Démarrage du Noyau et Paramètres (cmdline)**

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-004.jpeg)

*Figure : Console de commandes et inspection de /proc/cmdline*

Lors de la première tentative de démarrage, des incohérences d'affichage (écran noir) ont été observées en raison de la différence d'âge entre le GPU embarqué du serveur HP et les pilotes DRM modernes du noyau Linux.

**3.1 Diagnostic des erreurs de saisie initiale**

Lors des essais sur la console, la saisie directe de paramètres noyau tels que nolapic ou noapic a renvoyé des erreurs -bash: command not found. Il est essentiel de rappeler que ces options doivent être transmises via le gestionnaire de démarrage (GRUB / systemd-boot) et non exécutées comme des commandes Shell.

**3.2 Configuration finale retenue**

La vérification de la ligne de commande active du noyau via la commande cat /proc/cmdline a permis de valider l'injection du paramètre correct :

| root@server237:~# cat /proc/cmdline   BOOT\_IMAGE=/boot/vmlinuz-7.0.2-6-pve root=/dev/mapper/pve-root ro nomodeset quiet |
| --- |

| **Rôle du paramètre 'nomodeset' :**   L'option nomodeset empêche le noyau Linux de charger les pilotes graphiques spécifiques en mode KMS (Kernel Mode Setting) avant le démarrage de l'interface. Cela force le serveur à utiliser un framebuffer VESA/EFI générique, éliminant définitivement les problèmes d'écran noir sur le HP ProLiant DL360 G6. |
| --- |

**4\. Diagnostics Matériels, CPU, RAM et Sécurité**

**4.1 Pilotes et modules noyau chargés**

L'analyse des modules affichés sur la console confirme la bonne prise en charge des composants matériels critiques :

-   **• hpsa / scsi\_transport\_sas :** Pilote officiel pour le contrôleur RAID/SAS HP Smart Array.
-   **• bnx2 :** Pilote réseau pour les cartes Broadcom Gigabit embarquées.
-   **• nvme\_core / ehci\_pci :** Prise en charge du stockage NVMe / USB EHCI / UHCI.

**4.2 Analyse des interruptions APIC et MCE**

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-005.jpeg)

*Figure : Matrice des interruptions Threshold APIC, MCE et événements virtuels*

L'inspection de la table des interruptions (Threshold APIC interrupts, Machine Check Exceptions / Polls) montre une répartition homogène des événements sur l'ensemble des cœurs processeurs sans erreur bloquante.

**4.3 Capacité Mémoire (lsmem) et Atténuations de Sécurité CPU**

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-006.jpeg)

*Figure : Analyse de la mémoire RAM (lsmem) et statut des vulnérabilités processeur*

L'exécution de la commande lsmem et des rapports de vulnérabilité du noyau révèle :

-   **• RAM disponible :** 66 GiB de mémoire vive au total (66G online, block size 2G), entièrement reconnue et opérationnelle.
-   **• Statut des vulnérabilités :** Plusieurs failles récentes (Meltdown, MMIO stale data, Retbleed, SRBDS, TAA, TSX async abort, Vmscape) sont signalées 'Not affected' en raison de l'architecture spécifique du CPU.
-   **• Correctifs appliqués :** Des protections logicielles telles que Retpolines et usercopy/swapgs barriers sont automatiquement appliquées par le noyau Proxmox pour Spectre v1 et Spectre v2.

**5\. Configuration Réseau et Validation de la Connectivité**

**5.1 Configuration de l'interface bridge (vmbr0)**

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-007.jpeg)

*Figure : Test de ping initial et résolution du routage vers la passerelle*

Le serveur est configuré avec l'adresse IP statique suivante :

-   **• Adresse IP locale :** 10.7.236.237 / subnet /23 (masque 255.255.254.0)
-   **• Passerelle par défaut (Gateway) :** 10.7.237.1

**5.2 Déroulement des tests de connectivité (Ping)**

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-008.jpeg)

*Figure : Validation de la connectivité Internet externe (8.8.8.8) réussie*

-   **1\. Échec initial :** Un premier ping vers les serveurs DNS de Google (8.8.8.8) échoue avec le message 'Destination Host Unreachable', indiquant une absence temporaire de route externe.
-   **2\. Validation passerelle :** Un ping vers la passerelle 10.7.237.1 confirme le parfait fonctionnement de la liaison locale (12 paquets transmis, 12 reçus, 0% perte, délai moyen de 0.32 ms).
-   **3\. Validation Internet :** Un second test vers 8.8.8.8 confirme le rétablissement de l'accès Internet (4 paquets transmis, 4 reçus, 0% perte, temps moyen 3.12 ms).

**6\. Prise en Main à Distance et Interfaces d'Administration**

**6.1 Connexion SSH depuis un poste client Windows**

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-009.jpeg)

*Figure : Session SSH réussie depuis l'invite de commande de la machine client*

Depuis le poste de travail (utilisateur MURTADA) :

-   **• Dépannage IP :** Tentatives sur une mauvaise IP ayant produit un 'Connection timed out'.
-   **• Connexion établie :** La commande ssh root@10.7.236.237 s'est connectée avec succès après validation du fingerprint ED25519 (SHA256:1PUBww8ixbVzCCpUVLHawInqDMM8XWcv03+KHm29L6w).
-   **• Environnement :** Linux server237 7.0.2-6-pve (Debian GNU/Linux).

**6.2 Console Physique et Web UI Proxmox VE**

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-010.jpeg)

*Figure : Écran d'accueil de la console physique Proxmox Virtual Environment*

![](./Documentation_Proxmox_VE9_HP_DL360_G6_v2_images/image-011.jpeg)

*Figure : Console système Proxmox authentifiée sous l'utilisateur root*

| **Accès à l'Interface d'Administration Web Proxmox (PVE) :**   • URL Web : https://10.7.236.237:8006/   • Utilisateur : root   • Port d'écoute : 8006 (HTTPS) |
| --- |

**7\. Conclusion**

L'installation et la configuration de Proxmox VE 9 sur le serveur HP ProLiant DL360 G6 ont été réalisées avec succès. Malgré le décalage générationnel de la plate-forme matérielle, les ajustements effectués au niveau du noyau (nomodeset) et la validation étape par étape du réseau ont permis d'obtenir un nœud d'hypervision totalement fonctionnel, stable et accessible à distance via SSH et l'interface Web.
