
# 🔐 Comptes administrateurs Proxmox : bonnes pratiques

| Champ | Valeur |
|-------|--------|
| Étudiant | 300157184 (anta) |
| Groupe | 4 — Participation #3 |
| Compte Proxmox | `B300157184@pam` |
| Serveur Proxmox | `10.7.237.200` |
| Poste client | `anta@10.7.236.187` |

## 🎯 Objectif

Sécuriser l'accès à Proxmox VE avec un compte administrateur individuel au lieu du compte partagé `root@pam`, pour que chaque action soit traçable.

---

## 1. 👤 Créer l'utilisateur Linux

```bash
adduser B300157184
id B300157184
```

> 💡 Debian refuse les majuscules par défaut. Si `adduser` affiche une erreur `NAME_REGEX` :
> `adduser --allow-bad-names B300157184`

![Création de l'utilisateur Linux](images/01-adduser.png)

## 2. 🖥️ Ajouter l'utilisateur à Proxmox

```bash
pveum user add B300157184@pam
pveum user list
```

![Liste des utilisateurs Proxmox](images/02-user-list.png)

## 3. 🔑 Donner le rôle Administrator

```bash
pveum acl modify / --users B300157184@pam --roles Administrator
pveum acl list
```

> Ancienne syntaxe équivalente : `pveum aclmod / -user B300157184@pam -role Administrator`

![ACL Administrator](images/03-acl-list.png)

## 4. 🌐 Connexion à l'interface Web

- URL : https://10.7.237.200:8006
- Utilisateur : `B300157184`, royaume **Linux PAM standard authentication**

![Connexion Web UI](images/04-webui.png)

## 5. 💻 Connexion SSH avec clé publique

Depuis le poste client `anta@10.7.236.187` :

```bash
ssh-keygen -t ed25519
ssh-copy-id B300157184@10.7.237.200
ssh B300157184@10.7.237.200
```

✅ Aucun mot de passe n'est demandé.

![Connexion SSH par clé](images/05-ssh-key.png)

## 6. 🛡️ Accès sudo (pour utiliser `pveum` en SSH)

Le rôle Administrator ne donne des droits que dans Proxmox, pas dans Linux. En root :

```bash
apt install sudo
usermod -aG sudo B300157184
```

## 7. 🧪 Vérifications

```bash
pveum user list
pveum role list
pveum acl list
```

Dans le Web UI, le panneau **Tasks** affiche maintenant `B300157184@pam` comme auteur des actions.

![Traçabilité dans Tasks](images/06-tasks.png)

---

## ✅ Résultat

| Méthode | Recommandation |
|---------|:--------------:|
| Utiliser seulement `root@pam` | ❌ |
| Un compte par administrateur | ✅ |
| SSH avec mot de passe | ⚠️ |
| SSH avec clé publique | ✅ |
| Partager le compte root | ❌ |
| Utiliser les ACL Proxmox | ✅ |

- ✅ J'ai mon propre compte `B300157184@pam`
- ✅ Mes actions sont traçables
- ✅ Mon accès SSH utilise une clé ed25519
- ✅ `root@pam` est réservé au dépannage, à la maintenance d'urgence et à la récupération
