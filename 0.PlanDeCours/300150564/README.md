Ouassim Ahmed Benamira
Matricule : 300150564 Programme : TSIQ - Techniques des systèmes informatiques

Lab — Démontage et remontage d'un serveur
Matériel identifié
3 disques durs SAS (146 Go)
2 blocs d'alimentation
2 RAM 16 Go + 8 RAM 4 Go
2 CPU Intel 2.53 GHz
Étape 1 — Retrait des blocs d'alimentation

<img src="./images/IMG_2702.jpg" width="300"> Retrait des 2 blocs d'alimentation HP.

<img src="./images/IMG_2705.jpg" width="300"> Retrait des 3 disques durs SAS hot-swap.

<img src="./images/IMG_2706.jpg" width="300"> Étiquette d'un disque : SAS 15K, 146 Go.

Étape 2 — Retrait des barrettes RAM

<img src="./images/IMG_2707.jpg" width="300"> Barrettes RAM PC3-8500R : 1x16 Go + 4x4 Go visibles.

Étape 3 — Retrait du CPU

<img src="./images/IMG_2711.jpg" width="300"> Retrait d'un CPU Intel Xeon 2.53 GHz.

Étape 4 — Module de mémoire cache

<img src="./images/IMG_2714.jpg" width="300"> Module cache du contrôleur RAID (HP 4K1145).

Étape 5 — 1er démarrage : 1 RAM 16 Go + 1 CPU

<img src="./images/IMG_2717.jpg" width="300"> BIOS : 16 GB Installed, 1 Processor detected (Xeon E5540 @ 2.53GHz).

<img src="./images/IMG_2718.jpg" width="300"> Écran de boot, appui sur F9.

<img src="./images/IMG_2719.jpg" width="300"> ROM-Based Setup Utility : HP ProLiant DL360 G6, Proc 2 Not Installed.

Étape 6 — 2ème démarrage : 1 RAM 16 Go + 2 CPU

<img src="./images/IMG_2720.jpg" width="300"> 16384MB Memory Configured, Proc 1 et Proc 2 détectés.

Étape 7 — Formatage des disques (HP Array Configuration Utility)

<img src="./images/IMG_2722.jpg" width="300"> Menu principal : Create/View/Delete Logical Drive.

<img src="./images/IMG_2723.jpg" width="300"> Suppression de l'ancien Logical Drive (RAID 5, 273.4 GB).

<img src="./images/IMG_2724.jpg" width="300"> Sélection des 3 disques + RAID 5.

<img src="./images/IMG_2725.jpg" width="300"> Résumé config, F8 pour sauvegarder.

<img src="./images/IMG_2726.jpg" width="300"> Logical Drive #1, RAID 5, 273.4 GB, Status OK.

Étape 8 — Installation de tous les composants

<img src="./images/IMG_2727.jpg" width="300"> BIOS Memory Diagnostic : 61440MB Available (toutes les RAM).

<img src="./images/IMG_2728.jpg" width="300"> Config finale : 60 Go RAM, 2 CPU détectés.


