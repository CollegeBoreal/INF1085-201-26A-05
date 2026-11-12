# 🔐 root - Comptes administrateurs Proxmox : bonnes pratiques

| #️⃣ | Participations |
|-|-|
| 1️⃣ | [:tada: Participation](.scripts/Participation-group1.md) |
| 2️⃣ | [:tada: Participation](.scripts/Participation-group2.md) |
| 3️⃣ | [:tada: Participation](.scripts/Participation-group3.md) |
| 4️⃣ | [:tada: Participation](.scripts/Participation-group4.md) |
| 5️⃣ | [:tada: Participation](.scripts/Participation-group5.md) |

## 🗄️ Rack 2️⃣ - 📇 42U

| Rack | U#️⃣| 🏙️ Serveurs | 🏷️  | S/N #️⃣        | Host IP                                  | RAM  | CPU | HD      | Comments                             |
| ---- | -:| ------------| --: | ------------ | ----------------------------------------- | ---: | ---:| ------- | ------------------------------------ |
| 2️⃣   | 28 | 🅰️ G7️⃣      |  S7 | USE107NACM✅ | [10.7.236.197](https://10.7.236.197:8006) | 64GB | 16  | 273.4G  | $\color{green}\text{1TBNVMe}$  
| 2️⃣   | 27 | 🅰️ G6️⃣      | S39 | USE025N7B5✅ | [10.7.236.198](https://10.7.236.198:8006) | 64GB | 16  | 273.4G  | $\color{green}\text{1TBNVMe}$  
| 2️⃣   | 26 | 🅰️ G6️⃣      | S13 | MXQOO30BLP✅ | [10.7.236.199](https://10.7.236.199:8006) | 64GB | 16  | 273.4G  | $\color{green}\text{1TBNVMe}$  
| 2️⃣   | 25 | 🅰️ G7️⃣      |  S5 | USE135N8B0✅ | [10.7.236.200](https://10.7.236.200:8006) | 64GB | 16  | 273.4G  | $\color{green}\text{1TBNVMe}$  



## 🎯 Objectif

Apprendre à sécuriser l'accès à Proxmox VE en utilisant des comptes administrateurs individuels plutôt que le compte `root`.

---

# ❌ Mauvaise pratique

Tous les administrateurs utilisent :

```text
root@pam
```

Problèmes :

- ❌ Impossible de savoir qui a effectué une modification
- ❌ Partage du mot de passe
- ❌ Moins sécuritaire
- ❌ Plus difficile à dépanner

---

# ✅ Bonne pratique

Créer un compte par administrateur :

```text
djamel@pam
alice@pam
bob@pam
```

Chaque administrateur possède son propre compte.

---

# 👤 Créer un utilisateur Linux

* avec son compte boreal 🆔

```bash
adduser B🆔
```

Vérifier :

```bash
id 🆔
```

---

# 🖥️ Ajouter l'utilisateur à Proxmox

```bash
pveum user add B🆔@pam
```

Afficher les utilisateurs :

```bash
pveum user list
```

---

# 🔑 Donner les droits administrateur

```bash
pveum aclmod / \
    -user B🆔@pam \
    -role Administrator
```

Vérifier :

```bash
pveum acl list
```

---

# 🌐 Connexion à l'interface Web

Accéder à :

```text
https://IP_DU_SERVEUR:8006
```

Exemple :

```text
https://10.7.237.200:8006
```

Connexion :

```text
Utilisateur : B🆔@pam
Mot de passe : ********
```

---

# 💻 Connexion SSH

```bash
ssh B🆔@10.7.237.200
```

---

# 🔐 Utiliser une clé SSH

⚠️ Si tu as déjà une clé publique (i.e. ma_cle.pub) refère toi à [🔐](../X.Linux/3.keys)

Créer une paire de clés :

```bash
ssh-keygen -t ed25519
```

Copier la clé sur le serveur :

```bash
ssh-copy-id B🆔@10.7.237.200
```

Tester :

```bash
ssh B🆔@10.7.237.200
```

✅ Aucun mot de passe ne devrait être demandé.

---

# 🚨 Le compte root

Conserver :

```text
root@pam
```

uniquement pour :

- 🔧 Dépannage
- 🔄 Réinitialisation de mots de passe
- 🛠️ Maintenance d'urgence
- 🚑 Récupération du système

---

# ✅ Recommandations

| Méthode | Recommandation |
|----------|----------|
| Utiliser seulement `root@pam` | ❌ |
| Créer un compte par administrateur | ✅ |
| SSH avec mot de passe | ⚠️ |
| SSH avec clé publique | ✅ |
| Partager le compte root | ❌ |
| Utiliser les ACL Proxmox | ✅ |

---

# 🧪 Vérifications

Lister les utilisateurs :

```bash
pveum user list
```

Lister les rôles :

```bash
pveum role list
```

Lister les permissions :

```bash
pveum acl list
```

Tester SSH :

```bash
ssh B🆔@10.7.237.200
```

---

# 🎓 Résultat attendu

✅ Chaque administrateur possède son propre compte

✅ Les actions sont traçables

✅ Les accès SSH sont sécurisés

✅ Le compte `root` est réservé aux urgences

✅ L'environnement Proxmox est plus sécuritaire
