Ouassim Ahmed Benamira
Matricule : 300150564 Programme : TSIQ - Techniques des systèmes informatiques

Lab — Démontage et remontage d'un serveur
Matériel identifié
3 disques durs SAS (146 Go)
2 blocs d'alimentation
2 RAM 16 Go + 8 RAM 4 Go
2 CPU Intel 2.53 GHz
Étape 1 — Retrait des blocs d'alimentation

![Étape 1](./images/IMG_2702.jpg width="400") Retrait des 2 blocs d'alimentation HP.

![Étape 1b](./images/IMG_2705.jpg) Retrait des 3 disques durs SAS hot-swap.

![Étape 1c](./images/IMG_2706.jpg) Étiquette d'un disque : SAS 15K, 146 Go.

Étape 2 — Retrait des barrettes RAM

![Étape 2](./images/IMG_2707.jpg) Barrettes RAM PC3-8500R : 1x16 Go + 4x4 Go visibles.

Étape 3 — Retrait du CPU

![Étape 3](./images/IMG_2711.jpg) Retrait d'un CPU Intel Xeon 2.53 GHz.

Étape 4 — Module de mémoire cache

![Étape 4](./images/IMG_2714.jpg) Module cache du contrôleur RAID (HP 4K1145).

Étape 5 — 1er démarrage : 1 RAM 16 Go + 1 CPU

![Étape 5](./images/IMG_2717.jpg) BIOS : 16 GB Installed, 1 Processor detected (Xeon E5540 @ 2.53GHz).

![Étape 5b](./images/IMG_2718.jpg) Écran de boot, appui sur F9.

![Étape 5c](./images/IMG_2719.jpg) ROM-Based Setup Utility : HP ProLiant DL360 G6, Proc 2 Not Installed.

Étape 6 — 2ème démarrage : 1 RAM 16 Go + 2 CPU

![Étape 6](./images/IMG_2720.jpg) 16384MB Memory Configured, Proc 1 et Proc 2 détectés.

Étape 7 — Formatage des disques (HP Array Configuration Utility)

![Étape 7](./images/IMG_2722.jpg) Menu principal : Create/View/Delete Logical Drive.

![Étape 7b](./images/IMG_2723.jpg) Suppression de l'ancien Logical Drive (RAID 5, 273.4 GB).

![Étape 7c](./images/IMG_2724.jpg) Sélection des 3 disques + RAID 5.

![Étape 7c2](./images/IMG_2725.jpg) Résumé config, F8 pour sauvegarder.

![Étape 7d](./images/IMG_2726.jpg) Logical Drive #1, RAID 5, 273.4 GB, Status OK.

Étape 8 — Installation de tous les composants

![Étape 8](./images/IMG_2727.jpg) BIOS Memory Diagnostic : 61440MB Available (toutes les RAM).

![Étape 8b](./images/IMG_2728.jpg) Config finale : 60 Go RAM, 2 CPU détectés.
