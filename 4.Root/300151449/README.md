# 🔐 4.Root — Administration Proxmox

**Étudiant :** 300151449  
**Serveur :** server197 — `10.7.236.197`  
**Date :** 26 novembre 2026

## 🎯 Objectif

Créer un compte personnel Linux et Proxmox, lui attribuer le rôle Administrator dans le cadre du laboratoire, puis vérifier les accès Web et SSH avec une clé ED25519.

## 1. Création de l’utilisateur Linux

Depuis PowerShell, je me suis connecté au serveur avec le compte root autorisé. Après quelques tentatives de connexion refusées, la connexion a réussi. J’ai vérifié le nom du serveur, créé mon compte et confirmé les informations.

```bash
ssh root@10.7.236.197
hostname
adduser B300151449
```

<img src="images/01-creation-debut.png" alt="01-creation-debut" width="350">

<img src="images/02-creation-verification.png" alt="02-creation-verification" width="350">

## 2. Vérification de l’utilisateur

Le compte existe : UID 1003, GID 1003, groupe secondaire users.

```bash
id B300151449
```

<img src="images/02-creation-verification.png" alt="02-creation-verification" width="350">

## 3. Ajout du compte dans Proxmox

Le compte B300151449@pam apparaît dans la liste des utilisateurs et est activé.

```bash
pveum user add B300151449@pam
pveum user list
```

<img src="images/03-ajout-proxmox.png" alt="03-ajout-proxmox" width="350">

## 4. Attribution du rôle Administrator

Le rôle Administrator est attribué sur / avec propagation activée (1).

```bash
pveum aclmod / -user B300151449@pam -role Administrator
pveum acl list
```

<img src="images/06-role-et-ssh.png" alt="06-role-et-ssh" width="350">

## 5. Connexion à l’interface Web

Je me suis déconnecté de root@pam, puis connecté à https://10.7.236.197:8006 avec B300151449 et le realm Linux PAM. Mon compte personnel est visible en haut à droite. La VM 103 est en cours d’exécution. Le navigateur affiche un avertissement de sécurité HTTPS.

<img src="images/04-interface-root.png" alt="04-interface-root" width="350">

<img src="images/05-interface-personnelle.png" alt="05-interface-personnelle" width="350">

## 6. Connexion SSH personnelle

Après avoir quitté la session root, je me suis connecté avec mon compte personnel. whoami confirme mon identité.

```bash
exit
ssh B300151449@10.7.236.197
whoami
```

<img src="images/06-role-et-ssh.png" alt="06-role-et-ssh" width="350">

## 7. Configuration de la clé SSH

Depuis PowerShell, j’ai vérifié le dossier .ssh, généré une paire ED25519 protégée par une phrase secrète et installé uniquement la clé publique sur le serveur. La clé privée reste sur mon PC.

```powershell
ls $HOME\.ssh
ssh-keygen -t ed25519
Get-Content "$HOME\.ssh\id_ed25519.pub" | ssh B300151449@10.7.236.197 "umask 077; mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys"
```

<img src="images/07-verification-cles.png" alt="07-verification-cles" width="350">

<img src="images/08-generation-cle.png" alt="08-generation-cle" width="350">

<img src="images/09-installation-cle.png" alt="09-installation-cle" width="350">

## 8. Connexion SSH avec la clé

La connexion réussit avec les méthodes par mot de passe et clavier interactif désactivées. Seule la phrase secrète de la clé est demandée.

```powershell
ssh -o PasswordAuthentication=no -o KbdInteractiveAuthentication=no B300151449@10.7.236.197
```

<img src="images/10-test-cle.png" alt="10-test-cle" width="350">

## 9. Vérification de l’utilisateur connecté

Les résultats confirment B300151449, UID/GID 1003 et server197.

```bash
whoami
id
hostname
```

<img src="images/11-identite.png" alt="11-identite" width="350">

## 10. Vérification des rôles Proxmox

Avec mon compte personnel, pveum est introuvable dans le PATH. Le chemin complet produit une erreur de chargement des ACL. Le rôle Administrator Proxmox ne confère pas automatiquement les privilèges root Linux. Je suis revenu dans la session root autorisée et la liste des rôles s’est affichée correctement, sans modifier les permissions Linux.

```bash
pveum role list
/usr/sbin/pveum role list
# Depuis la session root autorisée :
pveum role list
```

<img src="images/12-erreur-path.png" alt="12-erreur-path" width="350">

<img src="images/13-erreur-acl.png" alt="13-erreur-acl" width="350">

<img src="images/14-liste-roles.png" alt="14-liste-roles" width="350">

## 11. Vérification finale des permissions

Depuis root, les permissions effectives sont affichées et la liste ACL confirme Administrator pour B300151449@pam sur / avec propagation. La capture montre la fin de la liste des permissions.

```bash
pveum user permissions B300151449@pam
pveum acl list
```

<img src="images/15-permissions-finales.png" alt="15-permissions-finales" width="350">

## 📋 Récapitulatif

| Paramètre | Résultat |
| --- | --- |
| Serveur | server197 |
| Adresse IP | 10.7.236.197 |
| Compte Linux | B300151449 |
| UID / GID | 1003 / 1003 |
| Compte Proxmox | B300151449@pam |
| Rôle | Administrator |
| Chemin ACL | / |
| Propagation | 1 |
| Connexion Web personnelle | Réussie |
| Connexion SSH personnelle | Réussie |
| Authentification par clé ED25519 | Réussie |

## ✅ Conclusion

J’ai créé et vérifié mon compte personnel sur le serveur Proxmox. Je peux accéder à l’interface Web et me connecter en SSH avec ma clé ED25519. Les permissions Proxmox ont été confirmées depuis la session root autorisée. Les tests ont également montré la distinction entre les droits Proxmox et les privilèges Linux.
