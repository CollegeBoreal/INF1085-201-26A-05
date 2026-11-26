# Root — Liza Benhammouche

**INF1085 · 300151835**

1. Confirmer le nom Linux avec le professeur. Les commandes ci-dessous utilisent `b300151835`. Depuis une session d’administration sur le nœud attribué, créer le compte s’il n’existe pas, l’enregistrer dans Proxmox et lui attribuer le rôle demandé.

```bash
adduser b300151835
id b300151835
pveum user add b300151835@pam
pveum aclmod / -user b300151835@pam -role Administrator
pveum user list
pveum acl list
```

2. Tester la connexion Web sur le port 8006 avec `b300151835@pam`.
3. Depuis le client SSH, créer une paire de clés si nécessaire et installer sa clé publique. Remplacer `IP_DU_NOEUD` par l’IP attribuée.

```bash
ssh-keygen -t ed25519
ssh-copy-id b300151835@IP_DU_NOEUD
ssh b300151835@IP_DU_NOEUD
```

**À relever** — rôle affiché, connexion Web et session SSH. Garder le mot de passe et la clé privée hors des captures.

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
