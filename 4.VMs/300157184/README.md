🖥️ Installation de FortiClient VPN et configuration d’une VM Proxmox

🎯 Objectif

L’objectif de ce laboratoire est de se connecter au réseau du Collège Boréal à l’aide de FortiClient VPN, d’accéder à Proxmox VE, puis de démarrer et configurer une machine virtuelle.

⸻

1. 📥 Télécharger FortiClient VPN

Pour commencer, nous avons téléchargé FortiClient VPN pour Windows.

⸻

2. ⚙️ Installer FortiClient VPN

Après le téléchargement, nous avons lancé l’installation de FortiClient VPN.

Nous avons attendu que l’installation soit terminée.

⸻

3. 🔐 Se connecter au VPN

Après l’installation, nous avons ouvert FortiClient et établi une connexion au VPN.

Le VPN affiche :

* Nom du VPN : RAVPN
* État : VPN connecté
* Utilisateur : compte étudiant

Cette connexion permet d’accéder aux ressources internes du Collège Boréal.

⸻

4. 🖥️ Accéder à Proxmox

Une fois connecté au VPN, nous avons accédé à l’interface Web de Proxmox Virtual Environment.

Informations

* Proxmox VE : 9.2.2
* Nœud : server56

⸻

5. 💻 Sélectionner la machine virtuelle

Dans Proxmox, nous avons sélectionné la machine virtuelle :

VM 106 — anta

Configuration de la VM

Composant	Configuration
VM ID	106
Nom	anta
Mémoire	2 Go
CPU	1 socket / 1 core
Disque	32 Go
BIOS	SeaBIOS
Réseau	VirtIO

⸻

6. ▶️ Premier démarrage

Nous avons cliqué sur Start pour démarrer la machine virtuelle.

Cependant, le démarrage a échoué.

❌ Erreur

kvm: warning: host doesn't support requested feature: CPUID[...].AES
TASK ERROR: start failed: QEMU exited with code 1

🔎 Cause

La VM utilisait un modèle de processeur nécessitant la fonctionnalité AES, mais cette fonctionnalité n’était pas disponible sur le processeur de l’hôte.

Le modèle utilisé était :

x86-64-v2-AES

⸻

7. 🔧 Modifier le processeur

Pour résoudre le problème, nous sommes allés dans :

VM 106 → Hardware → Processors → Edit

Nous avons changé le Type du processeur pour utiliser un modèle compatible avec l’hôte.

⚠️ Le modèle x86-64-v2-AES provoquait l’erreur de démarrage.

⸻

8. ✅ Démarrer à nouveau la VM

Après avoir enregistré la nouvelle configuration, nous avons lancé la VM une deuxième fois.

Cette fois, le démarrage a réussi.

Résultat

Status: running

La VM fonctionne maintenant correctement.

⸻

9. 📋 Résultat final

La machine virtuelle 106 (anta) est maintenant démarrée sur Proxmox.

Élément	Résultat
FortiClient VPN	✅ Connecté
Accès Proxmox	✅ Réussi
VM 106	✅ Démarrée
Problème CPU	✅ Corrigé
QEMU	✅ Fonctionnel

⸻

🧠 Ce que j’ai appris

Ce laboratoire m’a permis de pratiquer :

* La connexion à un VPN
* L’utilisation de FortiClient
* L’accès à Proxmox VE
* La gestion d’une machine virtuelle
* La configuration du matériel d’une VM
* La gestion des CPU virtuels
* Le diagnostic d’une erreur QEMU/KVM
* La résolution d’un problème de compatibilité CPU

⸻

📁 Organisation du projet

projet-proxmox/
│
├── README.md
│
└── images/
    ├── 01-telechargement-forticlient.png
    ├── 02-installation-forticlient.png
    ├── 03-forticlient-connecte.png
    ├── 04-proxmox.png
    ├── 05-vm-106.png
    ├── 06-erreur-demarrage.png
    ├── 07-processeur.png
    └── 08-vm-running.png

⸻

🏁 Conclusion

Le problème rencontré lors du démarrage de la VM était lié à une fonctionnalité CPU AES non supportée par l’hôte.

Après modification du modèle de processeur dans Proxmox, la VM a pu démarrer correctement.

Laboratoire terminé ✅

