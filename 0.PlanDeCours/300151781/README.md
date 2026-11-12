# 300151781

:octocat: [lounesallouti](https://github.com/lounesallouti) — INF1085 Administration Linux, Automne 2026

## :bookmark_tabs: Table des matières

- [:a: Objectif du laboratoire](#a-objectif-du-laboratoire)
- [:b: Matériel utilisé](#b-matériel-utilisé)
- [:ab: Qu'est-ce que le RAID ?](#ab-quest-ce-que-le-raid-)
- [:o2: Étapes de configuration](#o2-étapes-de-configuration)
- [:white_check_mark: Résultat](#white_check_mark-résultat)
- [:bulb: Ce que j'ai appris](#bulb-ce-que-jai-appris)

---

## :a: Objectif du laboratoire

Préparer un serveur physique **HP ProLiant** avant l'installation de Linux, en configurant
ses disques durs en **RAID** grâce au contrôleur matériel intégré.

## :b: Matériel utilisé

| Élément | Valeur |
|---|---|
| Serveur | HP ProLiant (serveur rack 1U) |
| Contrôleur RAID | HP Smart Array P410i, slot 0 |
| Type de stockage | Direct-Attached Storage (DAS) |
| Utilitaire | Option ROM Configuration for Arrays (ORCA) |
| Version de l'utilitaire | 8.30.02.00 |

## :ab: Qu'est-ce que le RAID ?

Le **RAID** (*Redundant Array of Independent Disks*) regroupe plusieurs disques physiques
pour former un seul disque logique. Selon le niveau choisi, on gagne en performance,
en sécurité des données, ou les deux.

| Niveau | Disques min. | Principe | Avantage | Inconvénient |
|---|---|---|---|---|
| RAID 0 | 2 | Répartition (*striping*) | Rapide | Aucune protection |
| RAID 1 | 2 | Miroir (*mirroring*) | Copie complète des données | 50 % de l'espace perdu |
| RAID 5 | 3 | Répartition + parité | Bon compromis vitesse / sécurité | Supporte la panne d'un seul disque |
| RAID 1+0 | 4 | Miroir + répartition | Rapide et sécuritaire | 50 % de l'espace perdu |

## :o2: Étapes de configuration

1. Brancher l'écran, le clavier et l'alimentation du serveur
2. Démarrer le serveur et attendre l'écran du contrôleur Smart Array
3. Appuyer sur `F8` pour entrer dans l'utilitaire **ORCA**
4. Choisir **Create Logical Drive**
5. Sélectionner les disques physiques disponibles
6. Choisir le niveau de RAID
7. Appuyer sur `Enter` puis `F8` pour sauvegarder la configuration

## :white_check_mark: Résultat

Le message **« Configuration saved »** confirme que le disque logique a bien été créé :

<image src=images/raid-configuration-saved.jpg width=50% height=50% > </image>

Le serveur est maintenant prêt pour l'installation du système d'exploitation Linux.

## :bulb: Ce que j'ai appris

- La différence entre un **disque physique** et un **disque logique**
- Le rôle d'un **contrôleur RAID matériel** dans un serveur
- Comment choisir un niveau de RAID selon les besoins (performance ou sécurité)
- Qu'on configure le stockage **avant** d'installer le système d'exploitation
