# 🗑️ Supprimer un stockage LVM-Thin Proxmox

## 🎯 Objectif

Supprimer un stockage LVM-Thin ajouté précédemment avec :

```bash
pvesm add lvmthin nvme-storage \
    --vgname nvme-vg \
    --thinpool nvme-thinpool \
    --content images,rootdir
```

---

# ⚠️ Vérification préalable

Afficher les disques stockés dans le pool :

```bash
pvesm list nvme-storage
```

Vérifier qu'aucune VM n'utilise le stockage :

```bash
qm list
```

---

# 🖥️ Supprimer le stockage de Proxmox

Retirer le stockage de la configuration Proxmox :

```bash
pvesm remove nvme-storage
```

Vérifier :

```bash
pvesm status
```

Le stockage ne doit plus apparaître.

---

# 📋 Vérifier les volumes LVM

Afficher les volumes :

```bash
lvs
```

Exemple :

```text
LV            VG
data          nvme-vg
```

---

# 🗑️ Supprimer le Thin Pool

```bash
lvremove nvme-vg/data
```

Répondre :

```text
y
```

---

# 📦 Supprimer le groupe de volumes

```bash
vgremove nvme-vg
```

---

# 💾 Supprimer le volume physique

```bash
pvremove /dev/nvme0n1p2
```

---

# 🧹 Effacer les signatures LVM (optionnel)

Partition :

```bash
wipefs -a /dev/nvme0n1p2
```

Disque complet :

```bash
wipefs -a /dev/nvme0n1
```

⚠️ Cette opération efface toutes les signatures détectées.

---

# ✅ Vérification finale

Volumes physiques :

```bash
pvs
```

Groupes de volumes :

```bash
vgs
```

Volumes logiques :

```bash
lvs
```

Stockages Proxmox :

```bash
pvesm status
```

---

# ✅ Résultat attendu

- ✅ Stockage `nvme-storage` supprimé
- ✅ Thin Pool supprimé
- ✅ Groupe de volumes `nvme-vg` supprimé
- ✅ Volume physique supprimé
- ✅ Disque NVMe prêt à être réutilisé ou reconfiguré
