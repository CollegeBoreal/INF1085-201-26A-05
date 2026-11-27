# Diagnostics — Liza Benhammouche

**INF1085 · 300151835**

1. Relever les voyants et messages du HP ProLiant DL360 G6. Noter s’il passe le POST, le test automatique au démarrage.
2. Avec le professeur, couper l’alimentation avant toute manipulation. Vérifier une configuration de référence qui démarre avec un processeur et un module mémoire dans le premier socket.
3. Tester CPU2 seul dans ce même socket avec le même module mémoire. Si le POST réussit, examiner le deuxième socket et son circuit mémoire. Si le POST échoue avec CPU2 mais réussit avec le processeur de référence, CPU2 devient le suspect principal.

| Observation | Résultat |
| --- | --- |
| Voyants ou code de diagnostic | À relever |
| POST de référence | À relever |
| POST avec CPU2 | À relever |
| Conclusion | À compléter |

## Interpréter le diagnostic

| Résultat du test comparatif | Conclusion |
| --- | --- |
| Les deux processeurs passent le POST dans le premier socket. | Tester le deuxième socket et la mémoire qui lui est associée. |
| Seul le processeur de référence passe le POST dans le premier socket. | CPU2 est la cause la plus probable. |
| Les deux processeurs échouent dans le premier socket. | Reprendre la configuration de référence et vérifier l’alimentation, la mémoire et la carte système avant de conclure. |

Un voyant CPU oriente le diagnostic vers le processeur ou son socket. Un code mémoire oriente d’abord le diagnostic vers le module DIMM, son emplacement ou le circuit mémoire.

## Captures

Après le laboratoire, ajouter les preuves dans `images/` et adapter le nom dans ce lien exemple.

`![Résultat du laboratoire](images/verification.png)`
