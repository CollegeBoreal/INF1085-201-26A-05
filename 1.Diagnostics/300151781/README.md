# 300151781

:octocat: [lounesallouti](https://github.com/lounesallouti) — INF1085 Administration Linux, Automne 2026

# :electric_plug: Diagnostics — Serveur HP ProLiant DL360 G6

## :bookmark_tabs: Table des matières

- [:a: Objectif du laboratoire](#a-objectif-du-laboratoire)
- [:b: Vue d'ensemble du serveur](#b-vue-densemble-du-serveur)
- [:one: Processeurs (CPU)](#one-processeurs-cpu)
- [:two: Mémoire vive (RAM)](#two-mémoire-vive-ram)
- [:three: Disques durs](#three-disques-durs)
- [:four: Démarrage (POST)](#four-démarrage-post)
- [:five: BIOS (RBSU)](#five-bios-rbsu)
- [:six: Configuration RAID des disques](#six-configuration-raid-des-disques)
- [:mag: Méthode de diagnostic](#mag-méthode-de-diagnostic)
- [:clipboard: Résumé de la configuration](#clipboard-résumé-de-la-configuration)
- [:bulb: Ce que j'ai appris](#bulb-ce-que-jai-appris)

---

## :a: Objectif du laboratoire

Ouvrir un serveur physique **HP ProLiant DL360 G6**, identifier et vérifier ses composants
(processeurs, mémoire, disques), vérifier le démarrage et le BIOS, puis configurer les disques
en **RAID** pour préparer l'installation de Linux.

## :b: Vue d'ensemble du serveur

Le DL360 G6 est un serveur rack **1U**. Une fois le capot retiré, on voit de l'avant vers l'arrière :

- la **baie de disques** (avant, sous la plaque métallique)
- la rangée de **ventilateurs** remplaçables à chaud (*Fan Removal / Fan Installation*)
- les **2 sockets processeur** avec leur dissipateur, entourés des **slots de mémoire** (blancs et noirs)
- les **cartes d'extension PCIe** (*riser*) et le contrôleur RAID
- les **2 blocs d'alimentation** redondants (PS 1 et PS 2, à l'arrière)

<image src=images/d1.jpg width=50% height=50% > </image>

## :one: Processeurs (CPU)

Le serveur possède **2 sockets LGA1366** (*Processor 1* et *Processor 2*). Les deux processeurs
installés sont des **Intel Xeon E5540 @ 2,53 GHz** (4 cœurs chacun, 8 Mo de cache L3).

Sur la photo, le dissipateur a été retiré : on voit les deux processeurs dans leur socket,
avec les restes de **pâte thermique** sur le dessus.

<image src=images/d2.jpg width=50% height=50% > </image>

Sans processeur, on voit les **broches du socket LGA1366**. Elles sont sur la carte mère
(et non sur le processeur) : une seule broche pliée peut empêcher le serveur de démarrer.

<image src=images/d3.jpg width=50% height=50% > </image>

Pour accéder aux processeurs, il faut d'abord soulever le **dissipateur thermique** avec ses poignées métalliques.

<image src=images/d4.jpg width=50% height=50% > </image>

> :warning: Il faut manipuler le processeur par les côtés, le poser bien à plat et ne jamais
> toucher les broches du socket.

## :two: Mémoire vive (RAM)

Le serveur utilise des barrettes **DDR3 ECC** (avec correction d'erreurs). Nous avons trié
plusieurs barrettes de différentes marques (HP, Crucial, Micron, Hynix) pour choisir celles
à installer.

<image src=images/d5.jpg width=50% height=50% > </image>

Règles d'installation :

- Les slots de chaque processeur sont à côté de son socket
- Si un seul processeur est installé, on utilise seulement les slots du **Processor 1**
- On commence par le **premier slot** de chaque canal (slots blancs)
- Le mode **Advanced ECC** du BIOS protège la mémoire contre les erreurs

## :three: Disques durs

Nous avons utilisé **3 disques SAS 2,5 pouces de 146 Go**, montés dans des tiroirs (*caddies*)
remplaçables à chaud (*hot-plug*). Les disques sont de marques HP et Dell.

<image src=images/d6.jpg width=50% height=50% > </image>

## :four: Démarrage (POST)

Au démarrage, le serveur fait son **POST** (*Power-On Self-Test*) : il vérifie les processeurs
et la mémoire avant de lancer le système. L'écran confirme que le matériel est bien détecté :

| Information affichée | Valeur |
|---|---|
| BIOS | ProLiant System BIOS P64 (03/01/2010) |
| Processeurs | 2 détectés, 8 cœurs au total, Hyperthreading activé |
| Proc 1 et Proc 2 | Intel Xeon E5540 @ 2,53 GHz |
| Vitesse QPI | 5,8 GT/s |
| Mémoire | 8 GB Installed |
| Protection mémoire | Advanced ECC Support |
| ROM | Redundant ROM Detected (ROM de secours valide) |

<image src=images/d7.jpg width=50% height=50% > </image>

## :five: BIOS (RBSU)

En appuyant sur `F9` pendant le POST, on entre dans le **RBSU** (*ROM-Based Setup Utility*),
le BIOS des serveurs HP. On y règle notamment l'ordre de démarrage (*Standard Boot Order*),
la date et l'heure, la gestion de l'alimentation et la sécurité.

La partie droite résume le système :

- **HP ProLiant DL360 G6**, BIOS P64 03/01/2010 (version de secours identique)
- **65536 MB Memory Configured** (64 Go)
- **Proc 1 et Proc 2** : Intel 2,53 GHz, 8 Mo de cache L3

<image src=images/d8.jpg width=50% height=50% > </image>

> :memo: L'écran POST indique 8 Go et le RBSU 64 Go : les deux photos viennent de démarrages
> différents, avec une quantité de mémoire installée différente.

## :six: Configuration RAID des disques

Les disques sont gérés par le contrôleur **HP Smart Array P410i**. La configuration se fait
avec l'utilitaire **Option ROM Configuration for Arrays (ORCA)**, version 8.30.02.00.

1. Démarrer le serveur et attendre l'écran du contrôleur Smart Array
2. Appuyer sur `F8` pour entrer dans **ORCA**
3. Choisir **Create Logical Drive**
4. Sélectionner les disques physiques
5. Choisir le niveau de RAID
6. Appuyer sur `Enter` puis `F8` pour sauvegarder

Le message **« Configuration saved »** confirme que le disque logique a été créé :

<image src=images/d9.jpg width=50% height=50% > </image>

| Niveau | Disques min. | Principe | Avantage |
|---|---|---|---|
| RAID 0 | 2 | Répartition (*striping*) | Rapide, mais aucune protection |
| RAID 1 | 2 | Miroir (*mirroring*) | Copie complète des données |
| RAID 5 | 3 | Répartition + parité | Supporte la panne d'un disque |

## :mag: Méthode de diagnostic

Si le serveur ne démarre pas, on élimine les causes une par une :

| Symptôme | Cause probable |
|---|---|
| Écran noir, ventilateurs à fond | Socket 2 ou CPU2 |
| Voyant rouge CPU | CPU2 défectueux |
| Bips mémoire | Barrette DIMM dans le mauvais emplacement |
| Démarre puis s'éteint | Alimentation ou court-circuit du socket |

Test rapide : retirer CPU2, le placer **seul dans le Socket 1** avec une seule barrette
dans le premier slot du CPU1, puis démarrer.

- Si le serveur fait son **POST** :arrow_right: CPU2 est bon, le problème vient du Socket 2
- Sinon :arrow_right: CPU2 est probablement défectueux

Dans notre cas, le POST affiche bien **2 processeurs détectés** : les deux sockets et les deux CPU fonctionnent.

## :clipboard: Résumé de la configuration

| Composant | Détail |
|---|---|
| Serveur | HP ProLiant DL360 G6 (1U) |
| BIOS | HP P64 (03/01/2010) |
| Processeurs | 2 × Intel Xeon E5540 @ 2,53 GHz, 8 cœurs au total, 8 Mo L3 |
| Mémoire | DDR3 ECC — 64 Go configurés (RBSU) |
| Disques | 3 × SAS 146 Go 2,5" hot-plug |
| Contrôleur RAID | HP Smart Array P410i, slot 0 |
| Alimentation | 2 blocs redondants (PS 1, PS 2) |

## :bulb: Ce que j'ai appris

- Identifier les composants internes d'un serveur rack
- Manipuler un processeur et un socket LGA1366 sans plier les broches
- Installer la mémoire dans le bon ordre selon le processeur
- Lire l'écran POST pour vérifier que le matériel est détecté
- Naviguer dans le BIOS (RBSU) d'un serveur HP
- Configurer un contrôleur RAID matériel avant d'installer le système d'exploitation
- Diagnostiquer un serveur qui ne démarre pas en éliminant les causes une à une
