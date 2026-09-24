# 300151496





<image src= image/WhatsApp%20Image%202026-09-24%20at%2016.20.07%20(1).jpeg width=50% height=50% > </images>

<image src=image/WhatsApp%20Image%202026-09-24%20at%2016.20.07%20(1).jpeg
 width=50% height=50% > </image>

 Compte-rendu d'installation : 
 
 Proxmox VE sur HP ProLiant DL360 G61. 
 
 Préparation du matériel et environnement de travailSupport d'installation :
 
 Création d'une clé USB bootable à l'aide de Rufus contenant l'image ISO de Proxmox VE 8.2.   Plateforme matérielle : Serveur rack HP ProLiant DL360 G6 équipé de 2 processeurs Intel Xeon (2.53 GHz) et de 48 Go de mémoire RAM.
 
 Étape 1 – Configuration du BIOS (HP RBSU)Action : Démarrage du serveur et accès à l'utilitaire ROM-Based Setup Utility (v3.00).   
 
 Objectif : Navigation dans le menu System Options > Standard Boot Order (IPL) afin de positionner la clé USB en première option de démarrage.   3. Étape 2 – Amorçage de l'ISO Proxmox VEAction : Boot sur la clé USB SanDisk.  
 
 Résultat :
 
 Affichage du menu d'accueil du programme d'installation Proxmox VE 8.2. Sélection du mode d'installation graphique (Install Proxmox VE (Graphical)).   4.
 
 Étape 3 – Chargement du Noyau (GRUB)Action : Séquence de démarrage du gestionnaire GRUB (v2.12).
 
 Résultat : Chargement en mémoire RAM du noyau Linux et du système de fichier initial (initrd.img) nécessaire au lancement de l'assistant
 
 Étape 4 – Lancement de l'assistant et partitionnementAction : 
 
 Initialisation du programme d'installation graphique Proxmox VE Installer.  
 
 Résultat : Étape du partitionnement du disque hôte (create partitions) pour la préparation du système de fichiers et du stockage virtuel (KVM / LXC).

