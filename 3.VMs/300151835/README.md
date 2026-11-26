# VMs — Liza Benhammouche

**INF1085 · 300151835**

1. Ouvrir Proxmox sur le serveur du groupe et choisir **Create VM**.
2. Choisir un VMID libre et un nom, par exemple `linux-300151835`. Sélectionner l’ISO Linux, le CPU, la mémoire, le disque et le bridge selon les consignes du groupe.
3. Démarrer la VM, installer Linux et ouvrir une session dans sa console.
4. Sur l’hôte, vérifier la VM avec `qm list`. Dans la VM, lancer les commandes suivantes.

```bash
hostnamectl
ip -br address
ip route
lsblk
```

**À relever** — nœud, VMID, distribution, CPU, RAM, disque et IP. Ajouter les captures de Proxmox et de la console Linux.

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
