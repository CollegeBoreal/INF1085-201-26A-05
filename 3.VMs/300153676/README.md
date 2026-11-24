# Machine virtuelle Ubuntu

Lyes Medjahed · 300153676 · Groupe 2

| Paramètre attribué | Valeur |
| --- | --- |
| Hôte Proxmox | 10.7.236.198 |
| Adresse prévue pour la VM | 10.7.236.174 |
| Compte prévu | ubuntu |

Dans Proxmox, `qm list` permet de retrouver le numéro réel de la VM. Dans la console Ubuntu, `hostname` et `ip -br address` permettent de vérifier le nom et l’adresse configurée. Depuis le réseau du labo, la commande de connexion est `ssh ubuntu@10.7.236.174`.

La création de la VM, son adresse effective et la connexion avec la clé publique fournie par le professeur restent à confirmer sur le serveur.
