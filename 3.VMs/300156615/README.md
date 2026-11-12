\# Création d'une VM sur Proxmox : walid (300156615)

\*\*Cours :\*\* INF1085, Administration Linux

\*\*Serveur :\*\* server46 (10.7.236.199), Proxmox VE 9.2.2

\## 1. Connexion à Proxmox

Je me suis connecté au serveur avec SSH, puis à l'interface web (https://10.7.236.199:8006) avec le compte root et le domaine Linux PAM. Le serveur n'est joignable que depuis le Wi-Fi du laboratoire (réseau 10.7.236.0/23). Depuis le Wi-Fi général, le ping et SSH expirent.

\## 2. Terminal Proxmox (Shell)

J'ai utilisé le terminal intégré de l'interface web pour vérifier les ISO (`pvesm list local --content iso`) et les VM (`qm list`).

!\[Terminal Proxmox](images/01-shell-proxmox.jpeg)

\*\*Problème rencontré :\*\* les commandes collées affichaient des caractères parasites (`^\[\[200\~` au début et `\~` à la fin), donc `qm list\~` était refusée (« unknown command »). Cause : le mode de collage du terminal du navigateur (bracketed paste). Solution : `bind 'set enable-bracketed-paste off'`

\## 3. Template cloud-init (VM 9000)

J'ai d'abord téléchargé l'image Ubuntu 22.04 (cloud image) et créé la VM 9000 (ubuntu-jammy-template). Son disque, importé sur local-lvm, fait 2252 Mo.

!\[VM 9000](images/02-template-9000.jpeg)

| Élément | Valeur |
|---|---|
| Mémoire | 2 Gio |
| Processeurs | 2 (1 socket, 2 cœurs) |
| BIOS / machine | SeaBIOS / i440fx |
| Contrôleur SCSI | VirtIO SCSI |
| Disque (scsi0) | local-lvm:vm-9000-disk-0, 2252 Mo |
| Réseau (net0) | VirtIO, bridge vmbr0 |

\*\*Problèmes rencontrés :\*\*

\- Un deuxième import du disque s'est bloqué (processus qm importdisk figé). Je l'ai arrêté avec kill.

\- La commande pvesm free a gelé pendant que LVM attendait un verrou. Je l'ai interrompue avec Ctrl+C.

\- Le template restait incomplet (pas de lecteur cloud-init, démarrage réglé sur le réseau).

J'ai donc choisi une méthode plus simple : créer la VM directement à partir de l'ISO Ubuntu Server déjà présente sur le serveur (ubuntu-24.04.3-live-server-amd64.iso).

\## 4. Création de la VM 184 (walid)

À compléter après la création de la VM.

\## Conclusion

J'ai appris à me connecter à un serveur Proxmox, à vérifier ses ISO et ses VM, et à diagnostiquer des blocages (import de disque figé, collage dans le terminal). La création de la VM finale sera ajoutée une fois terminée.

