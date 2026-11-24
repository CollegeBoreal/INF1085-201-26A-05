# Compte personnel sur Proxmox

Lyes Medjahed · 300153676 · Groupe 2

Le labo demande un compte Linux personnel enregistré dans le domaine PAM de Proxmox, le rôle Administrator et une connexion SSH par clé. Le compte prévu par la convention du cours est `B300153676@pam`.

| Vérification sur l’hôte | Résultat à chercher |
| --- | --- |
| `id B300153676` | UID et groupes du compte Linux |
| `pveum user list` | Entrée B300153676@pam |
| `pveum acl list` | Rôle Administrator associé au compte sur / |

Le test de connexion se fait depuis le poste étudiant avec `ssh B300153676@10.7.236.198`. L’existence du compte, ses droits et le test par clé restent à confirmer au labo.
