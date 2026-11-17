# Sécurisation des accès à Proxmox VE – Création d'un compte administrateur individuel

## 1. Informations générales

- **Étudiante :** Alexia Kabore
- **Numéro de dossier :** 300155109
- **Cours :** INF1085-201-26A-05
- **Plateforme :** Proxmox Virtual Environment 9.2.2
- **Serveur :** server46
- **Adresse IP du serveur :** 10.7.236.199
- **Compte créé :** B300155109
- **Realm d'authentification :** Linux PAM (`pam`)

## 2. Objectif du laboratoire

L'objectif de ce laboratoire est de sécuriser l'accès à Proxmox VE en utilisant un compte administrateur individuel plutôt qu'un compte partagé comme `root@pam`.

Le travail consiste à créer un compte Linux personnel, à l'ajouter dans Proxmox, à lui attribuer le rôle `Administrator`, puis à vérifier les accès à travers l'interface Web et SSH.

Une authentification par clé SSH Ed25519 est également configurée afin de permettre une connexion sécurisée sans saisir le mot de passe du compte à chaque connexion.

## 3. Création du compte Linux

La première étape consiste à créer un utilisateur Linux personnel sur le serveur Proxmox.

Commande exécutée :

```bash
adduser B300155109
```

Cette commande crée le compte Linux et demande de définir un mot de passe.

Pour vérifier la création du compte :

```bash
id B300155109
```

Le résultat confirme la création de l'utilisateur avec son propre identifiant UID et son groupe principal GID.

**Capture d'écran 1 – Création et vérification du compte Linux**

![Création du compte Linux](images/01-creation-compte-linux.png)

## 4. Ajout de l'utilisateur dans Proxmox

Après la création du compte Linux, l'utilisateur est ajouté à la configuration de Proxmox avec le realm PAM.

Commande exécutée :

```bash
pveum user add B300155109@pam
```

Pour vérifier la présence du compte :

```bash
pveum user list
```

Le compte `B300155109@pam` apparaît dans la liste des utilisateurs Proxmox et son état est activé.

**Capture d'écran 2 – Liste des utilisateurs Proxmox**

![Liste des utilisateurs Proxmox](images/02-liste-utilisateurs.png)

## 5. Attribution du rôle Administrator

Le rôle `Administrator` est attribué au compte personnel sur le chemin racine `/`.

Commande exécutée :

```bash
pveum aclmod / -user B300155109@pam -role Administrator
```

Cette attribution donne au compte les permissions d'administration sur l'environnement Proxmox.

Pour vérifier les permissions :

```bash
pveum acl list
```

Le résultat confirme que l'utilisateur `B300155109@pam` possède le rôle `Administrator` sur `/`, avec la propagation activée (`propagate = 1`).

**Capture d'écran 3 – Vérification des permissions ACL**

![Permissions ACL](images/03-permissions-acl.png)

## 6. Vérification des rôles Proxmox

La commande suivante permet de consulter les rôles disponibles sur le serveur :

```bash
pveum role list
```

Le rôle `Administrator` apparaît dans la liste des rôles Proxmox.

**Capture d'écran 4 – Liste des rôles Proxmox**

![Liste des rôles](images/04-liste-roles.png)

## 7. Test de connexion à l'interface Web

L'accès à l'interface Web est testé à partir de l'adresse suivante :

`https://10.7.236.199:8006`

Les informations utilisées sont :

- **Nom d'utilisateur :** `B300155109`
- **Mot de passe :** mot de passe défini lors de la création du compte Linux.
- **Realm :** Linux PAM standard authentication.

Le nom d'utilisateur est saisi sans `@pam`, car le realm sélectionné ajoute automatiquement cette information.

La connexion a été vérifiée avec succès et l'interface Proxmox est accessible avec le compte personnel.

**Capture d'écran 5 – Connexion réussie à Proxmox avec le compte individuel**

![Connexion Web Proxmox](images/05-connexion-web.png)

## 8. Test de connexion SSH

La connexion SSH est testée depuis Windows PowerShell à l'aide de la commande :

```powershell
ssh B300155109@10.7.236.199
```

Après avoir saisi le mot de passe, une session SSH est ouverte sur le serveur Proxmox.

Le terminal affiche une invite de commande associée à l'utilisateur :

```text
B300155109@server46:~$
```

Ce test confirme que le compte personnel peut également accéder au serveur à distance par SSH.

**Capture d'écran 6 – Connexion SSH réussie**

![Connexion SSH](images/06-connexion-ssh.png)

## 9. Configuration de l'authentification par clé SSH

Pour renforcer la sécurité et éviter de saisir le mot de passe du compte à chaque connexion, une paire de clés SSH Ed25519 existante est réutilisée.

La clé privée est conservée sur l'ordinateur Windows et la clé publique est installée sur le serveur Proxmox.

Les fichiers utilisés sont :

- `id_ed25519` : clé privée, conservée sur l'ordinateur.
- `id_ed25519.pub` : clé publique, installée sur le serveur.

La clé publique est transférée depuis Windows PowerShell avec la commande :

```powershell
Get-Content "$HOME\.ssh\id_ed25519.pub" | ssh B300155109@10.7.236.199 "umask 077; mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys"
```

Cette commande crée le dossier `.ssh` si nécessaire, ajoute la clé publique au fichier `authorized_keys` et applique les permissions nécessaires.

## 10. Vérification de la connexion par clé SSH

La connexion est testée en forçant l'authentification par clé publique et en désactivant l'authentification par mot de passe pour ce test.

Commande exécutée depuis Windows PowerShell :

```powershell
ssh -i "$HOME\.ssh\id_ed25519" -o PreferredAuthentications=publickey -o PasswordAuthentication=no B300155109@10.7.236.199
```

La connexion est établie avec succès sans demander le mot de passe du compte Linux.

**Capture d'écran 7 – Authentification SSH par clé réussie**

![Authentification par clé SSH](images/07-connexion-cle-ssh.png)

## 11. Conclusion

Ce laboratoire m'a permis de mettre en pratique la gestion des utilisateurs et des permissions dans Proxmox VE.

J'ai créé un compte Linux individuel, ajouté cet utilisateur dans Proxmox et attribué le rôle `Administrator`. J'ai ensuite vérifié l'accès à l'interface Web ainsi que la connexion SSH.

Enfin, j'ai configuré et testé l'authentification par clé SSH Ed25519 afin de sécuriser davantage les connexions à distance.

Cette configuration permet d'utiliser un compte personnel pour les opérations d'administration, tout en conservant le compte `root@pam` pour les interventions de maintenance et de récupération.

**Résultat :** toutes les étapes de création du compte, d'attribution des permissions et de vérification des accès Web et SSH ont été réalisées avec succès.
