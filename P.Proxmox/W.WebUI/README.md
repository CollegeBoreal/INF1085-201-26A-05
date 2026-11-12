# 🖥️ Résolution rapide des problèmes de l'interface Web Proxmox (PVE WebUI)

## Symptôme

L'interface Web Proxmox :

```text
https://IP_DU_SERVEUR:8006
```

devient lente, ne se met plus à jour ou semble figée.

---

# 🔄 Actualiser le navigateur

Forcer le rechargement :

```text
Ctrl + F5
```

ou

```text
Ctrl + Shift + R
```

---

# 🔧 Redémarrer les services Web Proxmox

```bash
systemctl restart pveproxy
systemctl restart pvedaemon
```

Vérifier :

```bash
systemctl status pveproxy
systemctl status pvedaemon
```

---

# 📊 Actualiser les informations du nœud

Si les VM, les disques ou les stockages ne se mettent plus à jour :

```bash
systemctl restart pvestatd
```

Vérifier :

```bash
systemctl status pvestatd
```

---

# 💾 Vérifier les stockages

Afficher les stockages :

```bash
pvesm status
```

Scanner les volumes LVM :

```bash
pvesm scan lvm
```

---

# 🧠 Vérifier les ressources système

Mémoire :

```bash
free -h
```

Disques :

```bash
df -h
```

Charge système :

```bash
top
```

---

# 📋 Vérifier les journaux

Service Web :

```bash
journalctl -u pveproxy -n 50
```

Daemon Proxmox :

```bash
journalctl -u pvedaemon -n 50
```

---

# 🚑 Réparation rapide

Dans la majorité des cas :

```bash
systemctl restart pvestatd
systemctl restart pveproxy
systemctl restart pvedaemon
```

Puis :

```bash
pvesm status
```

et actualiser le navigateur.

---

# ✅ Résultat attendu

- Interface Web accessible
- Inventaire des VM mis à jour
- Stockages visibles
- Utilisation CPU/RAM actualisée
- Création et modification de VM fonctionnelles
