
# Création d'une VM Ubuntu Server sur Proxmox VE

| Champ | Information |
| --- | --- |
| Étudiant | Karim Bamba|
| Matricule | 300153972 |
| Programme | Techniques des systèmes informatiques – Collège Boréal |
| Cours | INF1085 |


>
>
---

## Objectif

Installer une machine virtuelle Ubuntu Server 24.04 LTS sur le serveur Proxmox VE de l'école, lui attribuer une adresse IP statique et l'administrer à distance par SSH avec une clé publique.

## Environnement

| Élément | Valeur |
| --- | --- |
| Hyperviseur | Proxmox VE `<version>` |
| Nœud | `<SERVEUR>` (`<IP_SERVEUR>`) |
| Système invité | Ubuntu Server 24.04.x LTS |
| Accès hors campus | VPN FortiClient |

---

## 1. Connexion au serveur Proxmox

Depuis un terminal, connexion SSH au nœud puis vérification de son adresse et de sa version :

```bash
ssh root@<IP_SERVEUR>
ip a
pveversion
```

![Connexion SSH au serveur Proxmox](images/01-ssh-proxmox.png)

L'interface Web est ensuite ouverte à l'adresse `https://<IP_SERVEUR>:8006`.

![Interface Web Proxmox](images/02-interface-web.png)

---

## 2. Téléversement de l'ISO Ubuntu

**Chemin :** `<SERVEUR>` → `local` → **ISO Images** → **Upload**

Le fichier `ubuntu-24.04.x-live-server-amd64.iso` est téléversé dans le stockage local pour pouvoir être monté dans la VM.

![Téléversement de l'ISO](images/03-upload-iso.png)

---

## 3. Création de la VM

Assistant **Create VM**, avec les paramètres suivants :

| Onglet | Paramètre | Valeur |
| --- | --- | --- |
| General | Nom / VM ID | `<NOM_VM>` / `<VM_ID>` |
| OS | Image ISO | ubuntu-24.04.x-live-server-amd64.iso |
| Disks | Taille | 32 GiB |
| CPU | Cœurs / Type | `<nb>` / `<type>` |
| Memory | RAM | 4096 MiB |
| Network | Bridge / Modèle | `vmbr0` / VirtIO (paravirtualized) |

VirtIO est choisi parce que c'est un pilote paravirtualisé : il offre de meilleures performances réseau qu'une carte émulée (ex. Intel E1000).

![Paramètres de la VM](images/04-create-vm.png)
![Résumé avant création](images/05-confirmation.png)

---

## 4. Problèmes rencontrés et solutions

### VM ID déjà utilisé

```
unable to create VM <ID>: VM <ID> already exists on node '<SERVEUR>'
```

**Cause :** le serveur est partagé ; chaque VM ID doit être unique sur le nœud.
**Solution :** choisir un ID libre (`<VM_ID>`).

![Erreur VM ID](images/06-erreur-vmid.png)

### Incompatibilité du type de CPU

```
host doesn't support requested feature: CPUID...ECX.aes
TASK ERROR: start failed: QEMU exited with code 1
```

**Cause :** le type de CPU par défaut (`x86-64-v2-AES`) exige l'instruction AES-NI, que les processeurs Xeon du serveur ne supportent pas.
**Solution :** **VM** → **Hardware** → **Processors** → **Type** : `<type choisi>` (ex. `x86-64-v2` ou `host`). La VM démarre ensuite normalement.

![Correction du type de CPU](images/07-cpu-type.png)

> Supprime cette section si tu n'as pas eu ces erreurs.

---

## 5. Installation d'Ubuntu Server

| Étape de l'installateur | Choix |
| --- | --- |
| Réseau | Interface `ens18` détectée, IP temporaire par DHCP (`<IP_DHCP>`) |
| Miroir | `http://ca.archive.ubuntu.com/ubuntu/` (test réussi) |
| Stockage | Disque entier de 32 GiB avec LVM |
| Profil | Utilisateur `<UTILISATEUR>`, hostname `<HOSTNAME>` |
| SSH | **Install OpenSSH server** coché |

![Installation - réseau](images/08-install-reseau.png)
![Installation - stockage](images/09-install-stockage.png)
![Installation - profil](images/10-install-profil.png)
![Installation terminée](images/11-install-terminee.png)

À la fin de l'installation, l'ISO est retirée du lecteur CD/DVD virtuel (**Hardware** → **CD/DVD Drive** → *Do not use any media*) pour éviter que la VM redémarre sur l'installateur.

---

## 6. Premier démarrage et tests réseau

Connexion avec `<UTILISATEUR>` dans la console Proxmox, puis :

```bash
ip a                 # vérifier l'IP de ens18
ping -c 4 8.8.8.8    # tester l'accès Internet
```

Résultat : 4 paquets reçus, 0 % de perte.

![Premier démarrage et ping](images/12-premier-demarrage.png)

---

## 7. Configuration de la clé SSH

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys      # coller la clé publique
chmod 600 ~/.ssh/authorized_keys
ls -ld ~/.ssh && ls -l ~/.ssh/authorized_keys
```

Résultat attendu :

```
drwx------ ... .ssh
-rw------- ... authorized_keys
```

Ces permissions sont obligatoires : si le dossier ou le fichier est accessible par d'autres utilisateurs, OpenSSH refuse la clé.

![Permissions SSH](images/13-cle-ssh.png)

Vérification du service :

```bash
sudo systemctl status ssh
```

Le service est `active (running)` et écoute sur le port 22.

![Service SSH actif](images/14-service-ssh.png)

---

## 8. Adresse IP statique avec Netplan

Fichier : `/etc/netplan/50-cloud-init.yaml`

```yaml
network:
  version: 2
  ethernets:
    ens18:
      dhcp4: false
      addresses:
        - <IP_STATIQUE>/23
      routes:
        - to: default
          via: <PASSERELLE>
      nameservers:
        addresses:
          - 8.8.8.8
```

Application et vérification :

```bash
sudo netplan try      # applique avec retour arrière automatique si erreur
sudo netplan apply
ip a
```

> Netplan utilise le YAML : l'indentation se fait **uniquement avec des espaces**. Une tabulation ou un décalage provoque une erreur de syntaxe.

![Configuration Netplan](images/15-netplan.png)

---

## 9. Validation du réseau

```bash
ping -c 4 8.8.8.8      # passerelle + Internet
ping -c 4 google.com   # résolution DNS
```

Les deux tests réussissent avec 0 % de perte : la passerelle, l'accès Internet, le DNS et l'IP statique sont fonctionnels.

![Tests réseau](images/16-tests-reseau.png)

---

## 10. Connexion SSH depuis Windows

Depuis PowerShell :

```powershell
ssh <UTILISATEUR>@<IP_STATIQUE>
```

La connexion réussit : la VM est administrable à distance.

![Connexion SSH depuis PowerShell](images/17-ssh-powershell.png)

---

## Configuration finale

| Composant | Valeur |
| --- | --- |
| Nœud Proxmox | `<SERVEUR>` – Proxmox VE `<version>` |
| VM | `<NOM_VM>` (ID `<VM_ID>`) |
| OS | Ubuntu Server 24.04.x LTS |
| Ressources | 4 Go RAM, 32 GiB disque (LVM) |
| Réseau | `ens18`, VirtIO, bridge `vmbr0` |
| Adresse IP | `<IP_STATIQUE>/23` |
| Passerelle / DNS | `<PASSERELLE>` / 8.8.8.8 |
| SSH | Actif, port 22, authentification par clé |

## Conclusion

La VM Ubuntu Server est installée sur Proxmox, configurée avec une adresse IP statique et accessible par SSH depuis Windows.

Les difficultés rencontrées (VM ID déjà pris, type de CPU incompatible, syntaxe YAML) m'ont permis de comprendre trois points pratiques : les ressources d'un serveur partagé doivent être uniques, le CPU virtuel doit correspondre aux capacités du matériel réel, et la configuration Netplan doit être validée avant d'être appliquée.
