# 300155109

# Installation de Proxmox VE 9.2 sur un HP ProLiant DL360 G6
## Étape 1 : Inspection du matériel


Nous avons ouvert le serveur afin d'observer et d'identifier ses différents composants matériels.
Cette étape permet de savoir de quel matériel on dispose avant d'installer quoi que ce soit.

![Vue du serveur](<img width="2048" height="1536" alt="[WhatsApp Image 2026-09-24 at 1 09 20 PM (1) - Copy" src="https://github.com/user-attachments/assets/ee8dcf19-99ba-488b-8c94-bf10c61850f0](https://raw.githubusercontent.com/CollegeBoreal/INF1085-201-26A-05/7aaec8ec8373977ef68b82795cef39f1f9f818bd/2.Proxmox/300155109/images/WhatsApp%20Image%202026-09-24%20at%201.09.20%20PM%20(1).jpeg)" />
)

---

## 2.Vérification dans le BIOS

![BIOS HP](<img width="1600" height="1200" alt="WhatsApp Image 2 2026-09-28 at 7 16 46 PM" src="https://github.com/user-attachments/assets/ba167cfa-70a2-4be6-9d16-af8e039ccc77" />
)

**Explication :**  
Ensuite, nous avons  démarré le serveur et avons accédé au BIOS (ROM-Based Setup Utility, version 3.00). L'écran de droite confirme les informations du serveur :

Modèle : HP ProLiant DL360 G6
BIOS : P64 du 01/03/2010
Mémoire : 8192 Mo (8 Go)
Processeur 1 : Intel 2,40 GHz avec 12 Mo de cache L3
Processeur 2 : non installé

Cela nous a  permis de nous assurer que la RAM et le processeur sont bien reconnus. Le menu de gauche contient aussi Standard Boot Order (IPL), qui sert à choisir le périphérique de démarrage (ici, le support contenant l'ISO de Proxmox).

---

## 3.Démarrage de l'installateur (GRUB)

![Menu GRUB](<img width="2048" height="1536" alt="WhatsApp Image  10 2026-09-28 at 7 16 47 PM" src="https://github.com/user-attachments/assets/d7708203-5c83-4da1-9aa4-822e3838d863" />
)

**Explication :**  
Après avoir démarré sur l'ISO de Proxmox VE 9.2, le menu GRUB s'affiche. nous avons appuyé sur la touche e sur l'entrée « Install Proxmox VE (Graphical) » pour modifier les paramètres de démarrage avant de lancer l'installation. On voit les lignes linux /boot/linux26 ro ramdisk_size=16777216 rw quiet splash=silent et initrd /boot/initrd.img. Une fois les modifications faites, on démarre avec Ctrl+X ou F10. C'est utile sur un vieux serveur comme le G6, où l'installateur graphique peut avoir des problèmes d'affichage ou de compatibilité.

---

## 4. Mot de passe administrateur et email

![Mot de passe root et email](<img width="2048" height="1536" alt="WhatsApp Image  11 2026-09-28 at 7 16 47 PM" src="https://github.com/user-attachments/assets/43425d6d-a0e3-4acd-8a77-1db1ea7dc734" />
)

**Explication :**  
Après avoir lancé l'installation depuis le menu GRUB, l'installateur graphique de Proxmox VE s'est ouvert. Proxmox Virtual Environment est une plateforme de virtualisation open source basée sur Debian (GNU/Linux).Pendant l'installation graphique, une des étapes demande de créer le compte administrateur. nous avons entré le mot de passe du compte root (8 caractères minimum, avec lettres, chiffres et symboles), puis nous avons ajouté une adresse email. Cette adresse sert à recevoir les alertes du serveur, comme les échecs de sauvegarde. Le mot de passe root sert ensuite à se connecter à Proxmox, notamment à l'interface web.

---

## 5.Test de connexion réseau

![Test de connexion réseau](<img width="2048" height="1536" alt="WhatsApp Image  15 2026-09-24 at 18 38 09" src="https://github.com/user-attachments/assets/61d09523-d2fe-41da-b902-32cfa18cfa41" />
)

**Explication :**  
Ici on observe que le serveur est bien connecté au réseau, et l'interface web est accessible à l'adresse https://10.7.237.24:8006..



**Explication :**  
Cette image montre la carte graphique ainsi qu'un SSD au format M.2. Le SSD est utilisé pour le stockage des données, des fichiers et du système d'exploitation. Contrairement à la RAM, les données enregistrées sur le SSD restent conservées lorsque le serveur est éteint.
