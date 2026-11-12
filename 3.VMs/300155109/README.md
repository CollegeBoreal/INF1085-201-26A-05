# Laboratoire 3 — Virtualisation et configuration d'un serveur Ubuntu

**Étudiante :** Alexia Kabore  
**Numéro de dossier :** 300155109  
**Cours :** INF1085-201-26A-05  
**Environnement de virtualisation :** Proxmox VE 9.2  
**Système d'exploitation :** Ubuntu Server 24.04.3 LTS  
**Nom de la machine virtuelle :** ubuntu-Alexia  
**Identifiant de la VM :** 105  

---

## 1. Objectif du laboratoire

L'objectif de ce laboratoire est de créer et de configurer une machine virtuelle sous Ubuntu Server à l'aide de Proxmox VE.

Le travail consiste notamment à :

- Créer une machine virtuelle et lui attribuer les ressources nécessaires.
- Installer Ubuntu Server 24.04.3 LTS.
- Vérifier les paramètres matériels et réseau de la machine.
- Installer et activer le service SSH.
- Autoriser l'accès SSH à l'aide d'une clé publique.
- Configurer une adresse IP statique pour assurer une connectivité réseau stable.

## 2. Environnement technique

Les outils et ressources utilisés sont les suivants :

| Élément | Configuration |
|---|---|
| Hyperviseur | Proxmox VE 9.2 |
| Système d'exploitation | Ubuntu Server 24.04.3 LTS |
| Processeur | 1 vCPU |
| Mémoire vive | 4000 Mo |
| Disque virtuel | 32 Go |
| Carte réseau | VirtIO |
| Interface réseau Ubuntu | ens18 |
| Service d'accès distant | OpenSSH Server |

### 2.1 Création de la machine virtuelle

Une machine virtuelle portant le nom `ubuntu-Alexia` a été créée dans Proxmox avec l'identifiant 105.

Les ressources matérielles suivantes lui ont été attribuées : un processeur virtuel, 4 Go de mémoire vive et un disque virtuel de 32 Go. La carte réseau virtuelle utilise le pont réseau `vmbr0`.

**Capture 1 — Configuration matérielle de la VM**

![Configuration matérielle de la VM](images/01-proxmox-vm.png)

## 3. Installation d'Ubuntu Server

Ubuntu Server 24.04.3 LTS a été installé sur le disque virtuel de la machine.

Après l'installation, le démarrage a été configuré pour utiliser le disque virtuel plutôt que l'image ISO d'installation.

**Capture 2 — Installation d'Ubuntu Server**

![Installation Ubuntu](images/02-installation-ubuntu.png)

**Capture 3 — Connexion à Ubuntu Server**

![Connexion Ubuntu](images/03-connexion-ubuntu.png)

## 4. Vérification des ressources et du réseau

Après l'installation, plusieurs commandes ont été utilisées pour vérifier le fonctionnement du système.

La commande `ip addr` permet d'afficher les interfaces réseau et leurs adresses IP.

La commande `free -h` permet de vérifier la mémoire vive disponible.

L'interface réseau utilisée par Ubuntu est `ens18`.

**Capture 4 — Vérification de l'adresse IP**

![Adresse IP](images/04-adresse-ip.png)

**Capture 5 — Vérification de la mémoire**

![Mémoire vive](images/05-memoire.png)

## 5. Configuration du service SSH

Le service OpenSSH Server a été installé afin de permettre l'administration distante de la machine virtuelle.

Son état a été vérifié avec la commande :

```bash
sudo systemctl status ssh
```

Le résultat a confirmé que le service SSH était actif.

Pour permettre son démarrage automatique avec le système, la commande suivante a été exécutée :

```bash
sudo systemctl enable ssh
```

**Capture 6 — Vérification du service SSH**

![Service SSH actif](images/06-service-ssh.png)

## 6. Configuration de l'accès par clé publique

Une clé publique SSH fournie par le professeur a été ajoutée au fichier `authorized_keys` du compte utilisateur `alexia`.

Le répertoire `.ssh` et le fichier `authorized_keys` ont reçu les permissions appropriées afin de sécuriser l'accès.

Les permissions utilisées sont :

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

Cette configuration permet au détenteur de la clé privée correspondante de s'authentifier auprès du compte autorisé, sans utiliser le mot de passe du compte pour l'authentification SSH.

**Capture 7 — Présence de la clé publique dans authorized_keys**

![Clé publique SSH](images/07-cle-publique.png)

## 7. Configuration de l'adresse IP statique

La configuration réseau initiale utilisait le protocole DHCP.

Une modification est prévue afin d'attribuer une adresse IP statique à l'interface `ens18`.

La configuration cible est la suivante :

| Paramètre | Valeur souhaitée |
|---|---|
| Interface | ens18 |
| Adresse IPv4 | 10.7.236.177 |
| Préfixe réseau | /23 |
| Passerelle | 10.7.236.1 |
| Serveur DNS | 8.8.8.8 |

Le fichier de configuration concerné est :

`/etc/netplan/50-cloud-init.yaml`

Cette configuration sera validée après son application et après les tests de connectivité réseau.

**Capture 8 — Configuration Netplan**

![Configuration Netplan](images/08-netplan.png)

**Capture 9 — Vérification de la nouvelle adresse IP et de la passerelle**

![Vérification réseau](images/09-verification-reseau.png)

## 8. Conclusion

Ce laboratoire a permis de créer une machine virtuelle sous Proxmox VE et d'y installer Ubuntu Server 24.04.3 LTS.

Les ressources matérielles ont été configurées, le service SSH a été installé et activé, et une clé publique a été ajoutée pour permettre l'authentification distante.

La dernière étape consiste à finaliser la configuration de l'adresse IP statique, puis à vérifier la connectivité réseau et l'accès SSH avec la nouvelle adresse.


