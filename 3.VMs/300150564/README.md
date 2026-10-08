# 🖥️ **Création d'une VM Ubuntu Server sur Proxmox VE**

**Nom :** Ouassim Ahmed Benamira  
**Matricule :** 300150564  
**Programme :** TSIQ – Techniques des systèmes informatiques  

---

## 🎯 **Objectif**

Créer une machine virtuelle **Ubuntu Server 24.04.5 LTS** sur le serveur **Proxmox VE 9.2.2**.

---

## 🔐 **Étape 1 — Connexion au serveur Proxmox**

Connexion au serveur `server56` avec SSH :

```bash
ssh root@10.7.237.200
```

Vérification du réseau et de Proxmox :

```bash
ip a
pveversion
```

<img src="./images/01-connexion-ssh.jpg" width="300">

<img src="./images/02-verification-proxmox.png" width="350">

**Adresse IP du serveur :** `10.7.237.200/23` ✅

---

## 🌐 **Étape 2 — Interface Web Proxmox**

Connexion à l'interface Web de **Proxmox VE 9.2.2** et sélection du serveur `server56`.

<img src="./images/03-interface-proxmox.png" width="350">

---

## 📀 **Étape 3 — Ajout de l'ISO Ubuntu**

Dans :

**server56 → local (server56) → ISO Images**

Ajout de l'image :

```text
ubuntu-24.04.5-live-server-amd64.iso
```

<img src="./images/04-iso-ubuntu.png" width="300">

---

## 🛠️ **Étape 4 — Création de la VM**

Une nouvelle machine virtuelle est créée avec les paramètres suivants :

- **Nom :** Ouassim
- **VM ID :** 125
- **OS :** Ubuntu Server 24.04.5 LTS
- **Disque :** 32 GiB
- **RAM :** 4 Go
- **CPU :** 2 vCPU
- **Réseau :** VirtIO
- **Bridge :** vmbr0

### **Sélection de l'ISO**

<img src="./images/05-selection-ubuntu.png" width="300">

### **Configuration du disque**

<img src="./images/07-disque-vm.png" width="300">

### **Configuration de la mémoire**

<img src="./images/08-memoire-vm.png" width="300">

### **Configuration du réseau**

<img src="./images/09-reseau-vm.png" width="300">

---

## ✅ **Étape 5 — VM créée**

La machine virtuelle **125 (Ouassim)** apparaît maintenant dans Proxmox.

<img src="./images/10-vm-creee.png" width="350">

---

## ⚠️ **Étape 6 — Problème de compatibilité CPU**

Au premier démarrage, la VM affiche l'erreur :

```text
host doesn't support requested feature: CPUID...ECX.aes
Host doesn't support requested features
TASK ERROR: start failed: QEMU exited with code 1
```

<img src="./images/11-erreur-cpu.png" width="350">

Le profil `x86-64-v2-AES` n'était pas compatible avec le processeur du serveur.

### 🔧 **Solution**

Dans :

**VM 125 → Hardware → Processors**

Le type de CPU a été changé pour :

```text
Type: host
```

Après cette modification, la VM démarre correctement. ✅

---

## 🚀 **Étape 7 — Démarrage d'Ubuntu Server**

La VM démarre correctement et charge Ubuntu Server.

<img src="./images/12-demarrage-ubuntu.png" width="350">

Le système arrive ensuite sur :

```text
Ubuntu 24.04.5 LTS ubuntu-server tty1
```

<img src="./images/13-ubuntu-server.png" width="350">

---

## 📋 **Configuration finale**

| Composant | Configuration |
|---|---|
| **VM** | Ouassim |
| **VM ID** | 125 |
| **OS** | Ubuntu Server 24.04.5 LTS |
| **CPU** | 2 vCPU – Type `host` |
| **RAM** | 4 Go |
| **Disque** | 32 GiB |
| **Réseau** | VirtIO / vmbr0 |

---

## ✅ **Conclusion**

La machine virtuelle **Ubuntu Server** a été créée et démarrée avec succès sur **Proxmox VE 9.2.2**.

Un problème de compatibilité CPU a été rencontré au premier démarrage. Le changement du type de processeur vers `host` a permis de résoudre le problème et de démarrer correctement la VM.
