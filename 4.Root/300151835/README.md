# Root — Liza Benhammouche

**INF1085 · 300151835**

1. Les commandes ci-dessous utilisent `B300151835`, selon le format indiqué dans le cours. Depuis une session d’administration sur le nœud attribué, créer le compte s’il n’existe pas, l’enregistrer dans Proxmox et lui attribuer le rôle demandé.

```bash
adduser --allow-bad-names B300151835
id B300151835
pveum user add B300151835@pam
pveum aclmod / -user B300151835@pam -role Administrator
pveum user list
pveum acl list
```

2. Tester la connexion Web sur le port 8006 avec `B300151835@pam`.
3. Depuis le client SSH, créer une paire de clés si nécessaire et installer sa clé publique. Les commandes ci-dessous ciblent le nœud du groupe 2.

```bash
ssh-keygen -t ed25519
ssh-copy-id B300151835@10.7.236.198
ssh B300151835@10.7.236.198
```

**À relever** — rôle affiché, connexion Web et session SSH. Garder le mot de passe et la clé privée hors des captures.

## Rôle et vérification

Le domaine PAM utilise le compte Linux créé sur le nœud Proxmox du groupe 2, `10.7.236.198`. L’entrée Proxmox et la permission ACL sont deux étapes distinctes. Dans la liste des ACL, vérifier la présence de l’utilisateur, du rôle `Administrator` et du chemin `/`. Tester ensuite la connexion sur le domaine **Linux PAM** de l’interface Web et ouvrir une session SSH avec le même compte.

L’option `--allow-bad-names` permet de créer le nom avec la majuscule demandée. Pour un compte existant, employer la casse exacte de son nom dans les commandes Linux, PAM et SSH.

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
