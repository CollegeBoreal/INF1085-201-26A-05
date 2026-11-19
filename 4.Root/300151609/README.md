#300151609
Tous les administrateurs utilisent :

root@
Problèmes :

❌ Impossible de savoir qui a effectué une modification
❌ Partage du mot de passe
❌ Moins sécuritaire
❌ Plus difficile à dépanner
✅ Bonne pratique
Créer un compte par administrateur :


Chaque administrateur possède son propre compte.

👤 Créer un utilisateur Linux
avec son compte boreal 🆔
adduser B🆔
Vérifier :

id 🆔
🖥️ Ajouter l'utilisateur à Proxmox
pveum user add B🆔@pam
Afficher les utilisateurs :

pveum user list
🔑 Donner les droits administrateur
pveum aclmod / \
    -user B🆔@pam \
    -role Administrator
Vérifier :
<image src=images/proxmox-acl-permissions-administrator-ro-1.png
 width=50% height=50% > </image>
<image src=images/proxmox-acl-permissions-administrator-ro-4.png
 width=50% height=50% > </image>

pveum acl list
🌐 Connexion à l'interface Web
Accéder à :

https://IP_DU_SERVEUR:8006


https://10.7.237.200:8006


Utilisateur : B🆔@pam
Mot de passe : ********
💻 Connexion SSH
ssh B🆔@10.7.237.197
🔐 Utiliser une clé SSH
⚠️ 
<image src=images/proxmox-ve-web-interface-login-screensho-2.webp
 width=50% height=50% > </image>

Créer une paire de clés :

ssh-keygen -t ed25519
Copier la clé sur le serveur :

ssh-copy-id B🆔@10.7.237.197
Tester :

ssh B🆔@10.7.237.197
✅ Aucun mot de passe ne devrait être demandé.

🚨 Le compte root
Conserver :

root@pam
uniquement pour :

🔧 Dépannage
🔄 Réinitialisation de mots de passe
🛠️ Maintenance d'urgence
🚑 Récupération du système
✅ Recommandations
Méthode	Recommandation
Utiliser seulement root@pam	❌
Créer un compte par administrateur	✅
SSH avec mot de passe	⚠️
SSH avec clé publique	✅
Partager le compte root	❌
Utiliser les ACL Proxmox	✅
🧪 Vérifications
Lister les utilisateurs :

pveum user list
Lister les rôles :

pveum role list
Lister les permissions :

pveum acl list
Tester SSH :

ssh B🆔@10.7.237.197
🎓 Résultat attendu
✅ Chaque administrateur possède son propre compte

✅ Les actions sont traçables

✅ Les accès SSH sont sécurisés

✅ Le compte root est réservé aux urgences

✅ L'environnement Proxmox est plus sécuritaire
