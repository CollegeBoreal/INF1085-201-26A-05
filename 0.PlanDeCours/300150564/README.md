Ouassim Ahmed Benamira
Matricule : 300150564 Programme : TSIQ - Techniques des systèmes informatiques

Lab — Démontage et remontage d'un serveur
Matériel identifié
3 disques durs SAS (146 Go)
2 blocs d'alimentation
2 RAM 16 Go + 8 RAM 4 Go
2 CPU Intel 2.53 GHz
Étape 1 — Retrait des blocs d'alimentation

![Étape 1](./images/IMG_2702.jpg) Retrait des 2 blocs d'alimentation HP.

![Étape 1b](./photos/IMG_2705.HEIC) Retrait des 3 disques durs SAS hot-swap.

![Étape 1c](./photos/IMG_2706.HEIC) Étiquette d'un disque : SAS 15K, 146 Go.

Étape 2 — Retrait des barrettes RAM

![Étape 2](./photos/IMG_2707.HEIC) Barrettes RAM PC3-8500R : 1x16 Go + 4x4 Go visibles.

Étape 3 — Retrait du CPU

![Étape 3](./photos/IMG_2711.HEIC) Retrait d'un CPU Intel Xeon 2.53 GHz.

Étape 4 — Module de mémoire cache

![Étape 4](./photos/IMG_2714.HEIC) Module cache du contrôleur RAID (HP 4K1145).

Étape 5 — 1er démarrage : 1 RAM 16 Go + 1 CPU

![Étape 5](./photos/IMG_2717.HEIC) BIOS : 16 GB Installed, 1 Processor detected (Xeon E5540 @ 2.53GHz).

![Étape 5b](./photos/IMG_2718.HEIC) Écran de boot, appui sur F9.

![Étape 5c](./photos/IMG_2719.HEIC) ROM-Based Setup Utility : HP ProLiant DL360 G6, Proc 2 Not Installed.

Étape 6 — 2ème démarrage : 1 RAM 16 Go + 2 CPU

![Étape 6](./photos/IMG_2720.HEIC) 16384MB Memory Configured, Proc 1 et Proc 2 détectés.

Étape 7 — Formatage des disques (HP Array Configuration Utility)

![Étape 7](./photos/IMG_2722.HEIC) Menu principal : Create/View/Delete Logical Drive.

![Étape 7b](./photos/IMG_2723.HEIC) Suppression de l'ancien Logical Drive (RAID 5, 273.4 GB).

![Étape 7c](./photos/IMG_2724.HEIC) Sélection des 3 disques + RAID 5.

![Étape 7c2](./photos/IMG_2725.HEIC) Résumé config, F8 pour sauvegarder.

![Étape 7d](./photos/IMG_2726.HEIC) Logical Drive #1, RAID 5, 273.4 GB, Status OK.

Étape 8 — Installation de tous les composants

![Étape 8](./photos/IMG_2727.HEIC) BIOS Memory Diagnostic : 61440MB Available (toutes les RAM).

![Étape 8b](./photos/IMG_2728.HEIC) Config finale : 60 Go RAM, 2 CPU détectés.
