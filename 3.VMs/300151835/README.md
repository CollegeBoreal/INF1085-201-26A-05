# VMs — Liza Benhammouche

**INF1085 · 300151835**

1. Ouvrir Proxmox sur le serveur du groupe. Si la VM attribuée existe, ouvrir sa console. Si elle doit être créée, choisir **Create VM**.
2. Pour une nouvelle VM, choisir un VMID libre et un nom, par exemple `linux-300151835`. Sélectionner l’ISO Linux, le CPU, la mémoire, le disque et le bridge selon les consignes du groupe.
3. Démarrer la VM et ouvrir une session dans sa console. Installer Linux si la VM est neuve.
4. Sur l’hôte, vérifier la VM avec `qm list`. Dans la VM, lancer les commandes suivantes.

```bash
hostnamectl
ip -br address
ip route
lsblk
```

**À relever** — nœud, VMID, distribution, CPU, RAM, disque et IP. Ajouter les captures de Proxmox et de la console Linux.

## Vérifier la VM attribuée

Le tableau du groupe 2 associe ce numéro étudiant à `ubuntu@10.7.236.173`. Ouvrir la console de cette VM sur le nœud `10.7.236.198` et vérifier son adresse et le service SSH.

```bash
ip -br address
ip route
systemctl status ssh --no-pager
ss -ltn 'sport = :22'
```

Si le serveur OpenSSH manque, l’installer et démarrer le service depuis la console Ubuntu.

```bash
sudo apt update
sudo apt install openssh-server
sudo systemctl enable --now ssh
```

Depuis un poste qui a accès au réseau du collège, tester `ssh ubuntu@10.7.236.173`. Si la connexion expire, vérifier d’abord que la VM est démarrée, que son interface est reliée au bridge prévu et que son IP correspond à celle du tableau. Appliquer la consigne du cours pour autoriser la clé publique du professeur sur le compte Ubuntu, puis faire vérifier la connexion.

Le [contrôle SSH du cours](../.scripts/Check.md) du 26 novembre signale une connexion impossible pour cette VM. Le port 22 est également resté inaccessible lors d’un test depuis l’environnement de travail à distance.

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
