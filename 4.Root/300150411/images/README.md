
# Création d'un utilisateur avec des droits administrateur sur Proxmox

**Étudiant :** Bourhane Kessouri  
**Matricule :** 300150411  
**Cours :** INF1085-201-26A-05 – Administration Linux  
**Serveur :** server46  
**Adresse IP :** 10.7.236.199

## 🎯 Objectif

Le but de ce laboratoire est de créer un compte personnel sur le serveur Proxmox avec des droits administrateur.

Cette méthode permet à chaque étudiant d'utiliser son propre compte au lieu de partager le compte root. Elle permet aussi de mieux sécuriser les connexions au serveur.

## 📋 Étapes du laboratoire

### 1. Création de l'utilisateur

La première étape consiste à se connecter au serveur avec le compte root.

Ensuite, j'utilise la commande suivante pour créer mon utilisateur avec mon matricule :

```bash
adduser b300150411
```

Je dois ensuite choisir un mot de passe et confirmer sa création. Les autres informations demandées peuvent être laissées vides en appuyant sur Entrée.
<image src=images/12344.jpg width=50% height=50% > </image>


### 2. Attribution des droits administrateur

Après la création du compte, je dois ajouter mon utilisateur au groupe sudo.

Pour cela, j'utilise :

```bash
usermod -aG sudo b300150411
```

Cette commande permet à mon compte d'utiliser les commandes administrateur avec sudo.

Pour vérifier l'ajout au groupe, j'utilise :

```bash
id b300150411
```

Le résultat doit afficher le groupe sudo parmi les groupes de mon utilisateur.

### 3. Installation de sudo

Pendant le laboratoire, un problème peut apparaître si la commande sudo n'est pas installée sur le serveur.

Pour régler ce problème, je dois retourner sur le compte root :

```bash
su -
```

Ensuite, je mets à jour les paquets :

```bash
apt update
```

Puis j'installe sudo :

```bash
apt install -y sudo
```

Cette installation permet d'utiliser les commandes administrateur avec mon compte personnel.

### 4. Vérification des droits administrateur

Pour terminer, je dois me reconnecter avec mon compte personnel et vérifier que les droits administrateur fonctionnent.

La commande utilisée pour tester les droits est :

```bash
sudo qm list
```

Cette commande permet d'afficher la liste des machines virtuelles présentes sur le serveur Proxmox.

Si la commande fonctionne après avoir entré mon mot de passe, cela confirme que mon compte peut utiliser les droits administrateur.

## Conclusion

Ce laboratoire m'a permis de comprendre comment créer un utilisateur Linux et lui donner des droits administrateur.

J'ai appris à utiliser les commandes adduser, usermod et sudo.

J'ai également compris qu'il est préférable que chaque étudiant utilise son propre compte au lieu de partager le compte root.

Cette méthode permet de mieux organiser les accès et d'améliorer la sécurité du serveur Proxmox.
