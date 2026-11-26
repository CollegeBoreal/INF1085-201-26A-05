# Projects — Liza Benhammouche

**INF1085 · 300151835**

## Projet proposé — Inventaire d’une VM Linux

Le script `inventaire.sh` enregistre le système, le nombre de processeurs logiques, la mémoire, les disques et les interfaces réseau. Il peut être exécuté avec un compte utilisateur ordinaire sur une VM Debian ou Ubuntu.

```bash
bash -n inventaire.sh
bash inventaire.sh
test -s inventaire-300151835.txt && head -n 15 inventaire-300151835.txt
```

**À vérifier dans la VM** — le rapport existe, les cinq sections sont visibles et leurs valeurs correspondent à la configuration de la VM. Ajouter une capture de l’exécution et du rapport. Avant publication, masquer dans les captures les détails de machine et de réseau qui doivent rester privés.

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
