# Projects — Liza Benhammouche

**INF1085 · 300151835**

## Projet — Inventaire d’une VM Linux

Le script `inventaire.sh` enregistre le système, le nombre de processeurs logiques, la mémoire, les disques et les interfaces réseau. Il peut être exécuté avec un compte utilisateur ordinaire sur une VM Debian ou Ubuntu.


## Exécution et validation

L’inventaire est prévu pour la VM du groupe 2, joignable au labo sous `ubuntu@10.7.236.173`. Il utilise les commandes standard `uname`, `hostname`, `nproc`, `free`, `lsblk` et `ip`. Le script écrit d’abord dans un fichier temporaire, puis publie le rapport complet quand toutes les commandes ont réussi. Le nom du rapport peut être passé en argument.

```bash
bash -n inventaire.sh
bash inventaire.sh inventaire-300151835.txt
test -s inventaire-300151835.txt
grep -c '^=== ' inventaire-300151835.txt
```

La dernière commande doit afficher `5`. Le rapport attendu contient les sections **Système**, **Processeurs logiques**, **Mémoire**, **Disques** et **Réseau**. L’exécution sur la VM et la capture de ses résultats restent à valider.

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
