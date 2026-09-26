# 300156497
# Installation de Proxmox VE 9 sur un HP ProLiant DL360 G6
![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300156497/images/a121690f-fbbb-4668-9e2e-4899d23fd609.jpeg?raw=true) Cette étape montre l'écran principal du BIOS HP (ROM-Based Setup Utility v3.00).  
On y voit la détection du matériel mis à jour : le serveur dispose désormais de 16 384 MB de RAM (16 Go) et de deux processeurs Intel 2.53GHz activés.

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300156497/images/79b3c051-2560-43e9-b079-6d528ed95fb6.jpeg?raw=true) Écran d'accueil du support d'installation de Proxmox VE 9.2. Sélectionner Install Proxmox VE (Graphical) puis valider avec Entrée pour démarrer l'installation

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300156497/images/34c795f6-3938-4535-a423-740794ed5582.jpeg?raw=true) Chargement de l'installateur Proxmox VE 9.2 et du disque mémoire initial (ramdisk). Le serveur prépare l'environnement pour lancer l'interface d'installation graphique

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300156497/images/78ecd7b9-3404-476d-a8cf-0f4c31404fb3.jpeg?raw=true) Initialisation des services du noyau et recherche d'une adresse IP via DHCP sur les cartes réseau. Le serveur prépare l'affichage de l'interface graphique d'installation de Proxmox

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300156497/images/1c1a3112-6d7a-43e2-a18c-ae52bef47a28.jpeg?raw=true) Saisie du mot de passe administrateur (⁠root⁠) et de l'adresse email pour les alertes système dans l'assistant Proxmox

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300156497/images/f466d9f5-469f-463b-a8fd-4e2d2894b3ea.jpeg?raw=true) Vérification de la configuration réseau via la commande ⁠ip addr⁠ sur la console de commande Proxmox (⁠root@server46⁠). On aperçoit l'interface bridge ⁠vmbr0⁠ configurée avec l'adresse IP ⁠192.168.100.2/24

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300156497/images/df9e753f-ed20-4e0c-9cff-a2bc0944a44e.jpeg?raw=true) Test de connectivité réseau via la commande ⁠ping 10.7.237.1⁠ depuis le serveur Proxmox (⁠10.7.237.24⁠). La réception continue des réponses confirme que la passerelle est joignable et que la configuration réseau est pleinement fonctionnelle.
