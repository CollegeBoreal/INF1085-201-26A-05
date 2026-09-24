# Installation de Proxmox VE sur un serveur HP ProLiant DL360 G6

Ce projet présente les différentes étapes de l'installation et de la configuration d'un serveur **HP ProLiant DL360 G6** avec **Proxmox Virtual Environment (VE)**.

---

## Étape 1 : Configuration du BIOS

Cette image montre le BIOS du serveur HP ProLiant DL360 G6. Cette étape permet de vérifier les composants matériels du serveur, notamment la mémoire RAM, les processeurs et les options de démarrage avant l'installation du système.

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300157184/images/WhatsApp%20Image%202026-09-24%20at%2018.37.39%20(2).jpeg?raw=true)  

---


## Étape 2 : Démarrage du serveur HP ProLiant

Cette image montre l'écran de démarrage du serveur HP ProLiant. Le système effectue les vérifications matérielles nécessaires afin de s'assurer que tous les composants fonctionnent correctement.

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300157184/images/WhatsApp%20Image%202026-09-24%20at%2018.37.39.jpeg?raw=true)

---

## Étape 3 : Installation de Proxmox VE

Cette image présente le menu d'installation de Proxmox Virtual Environment. À cette étape, nous lançons l'installation de l'hyperviseur qui permettra de créer et gérer des machines virtuelles.

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300157184/images/WhatsApp%20Image%202026-09-24%20at%2018.37.40.jpeg?raw=true)

---

## Étape 4 : Premier démarrage de Proxmox

Cette image montre le premier démarrage de Proxmox après l'installation. Une adresse IP est affichée afin d'accéder à l'interface Web de gestion.

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/2.Proxmox/300157184/images/WhatsApp%20Image%202026-09-24%20at%2018.37.40%20(2).jpeg?raw=true)

Exemple :

```text
https://192.168.100.2:8006/
```

---

## Étape 5 : Connexion administrateur

Cette image montre la connexion au serveur avec le compte administrateur `root`. Cette étape permet d'accéder à la ligne de commande Linux pour effectuer les configurations nécessaires.

images/root-login.jpg

---

## Étape 6 : Vérification de la connectivité réseau

Cette image montre l'exécution de la commande `ping` pour vérifier la communication entre le serveur et la passerelle réseau. Les réponses reçues confirment que la connexion réseau fonctionne correctement.

images/ping-test.jpg

```bash
ping 10.7.237.1
```

---

## Conclusion

L'installation de Proxmox VE sur le serveur HP ProLiant DL360 G6 a été réalisée avec succès. Le serveur est maintenant prêt à héberger des machines virtuelles et à être administré à distance.
