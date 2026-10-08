# TP – Configuration de base d’un serveur Ubuntu

## 1. Objectif du TP

Installer et configurer un serveur Ubuntu dans une machine virtuelle sur Proxmox, puis vérifier les paramètres de base du système et activer l’accès SSH.

## 2. Environnement de travail

- **Hyperviseur :** Proxmox VE
- **Système d’exploitation :** Ubuntu Server 24.04.5 LTS
- **Nom du serveur :** ubuntu-sever
- **Nom d’utilisateur :** rahma
- **Interface réseau :** ens18
- **Adresse IPv4 :** 10.7.237.147/23
- **Fuseau horaire :** America/Toronto
- **Langue du système :** Français canadien (fr_CA.UTF-8)
- **Service distant :** OpenSSH Server

## 3. Configuration réalisée

### 3.1 Mise à jour du système

```bash
sudo apt update
sudo apt upgrade -y
```

### 3.2 Configuration du fuseau horaire

```bash
sudo timedatectl set-timezone America/Toronto
timedatectl
```

Le fuseau horaire a été configuré sur `America/Toronto`.

### 3.3 Configuration du clavier

Le modèle de clavier MacBook/MacBook Pro a été sélectionné. La disposition choisie est `French (Canada)` et l’option `No compose key` a été conservée.

### 3.4 Configuration de la langue

```bash
sudo locale-gen fr_CA.UTF-8
sudo update-locale LANG=fr_CA.UTF-8
```

La locale française canadienne a été générée et définie comme langue du système.

### 3.5 Vérification du réseau

```bash
ip a
```

L’interface réseau `ens18` possède l’adresse IPv4 `10.7.237.147/23`.

### 3.6 Installation et activation du service SSH

```bash
sudo apt install openssh-server -y
sudo systemctl enable --now ssh
sudo systemctl status ssh
```

Le service SSH est actif et activé au démarrage. Il écoute sur le port TCP 22.

### 3.7 Test de connexion SSH locale

```bash
ssh localhost
```

La connexion SSH locale a été testée avec succès. La commande `exit` permet de fermer la session SSH.

## 4. Vérifications finales

Les commandes suivantes permettent de vérifier la configuration :

```bash
hostnamectl
timedatectl
locale
ip a
sudo systemctl status ssh
```

## 5. Conclusion

La configuration de base du serveur Ubuntu a été réalisée dans Proxmox. Le fuseau horaire a été configuré, la locale française canadienne a été générée, l’interface réseau a été vérifiée et le service SSH a été activé. Une connexion SSH locale a également été testée.

## 6. Captures d’écran

Ajouter les captures d’écran démontrant :

- La configuration du clavier et de la langue.
- Le fuseau horaire `America/Toronto`.
- L’adresse IP du serveur.
- L’état actif du service SSH.
- Le test de connexion SSH locale.
