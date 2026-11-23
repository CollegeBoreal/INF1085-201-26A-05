# 🖥️ Participation 1 – Diagnostics

## Informations de l'étudiant

- **Nom :** MOHTARAM EL ALAOUI
- **Prénom :** Abderrahim
- **Matricule :** 300151449
- **Programme :** TSIQ – Techniques des systèmes informatiques
- **Cours :** INF1085 – Administration Linux
- **Établissement :** Collège Boréal

---

## 🎯 Objectif du laboratoire

Ce laboratoire porte sur le démontage, l'identification des composants et le remontage d'un serveur **HP ProLiant DL360 G6**.

Les principaux objectifs sont :

- Identifier les composants matériels du serveur.
- Comprendre les étapes du démontage et du remontage.
- Vérifier la détection des processeurs et de la mémoire dans le BIOS.
- Comprendre la configuration des disques avec le contrôleur RAID.
- Étudier les méthodes de diagnostic d'un serveur.

## 🔍 Matériel présenté

Le matériel documenté comprend :

- 3 disques durs SAS de 146 Go.
- 2 blocs d'alimentation HP.
- 2 barrettes RAM de 16 Go.
- 8 barrettes RAM de 4 Go.
- 2 processeurs Intel Xeon à 2,53 GHz.
- Un contrôleur RAID avec module de mémoire cache.

---

# 🔧 Partie 1 – Démontage du serveur

## Étape 1 – Retrait des blocs d'alimentation

Les deux blocs d'alimentation sont retirés pour accéder aux composants du serveur. Avant toute intervention, le serveur doit être arrêté et débranché.

![Retrait des blocs d'alimentation](images/IMG_2702.jpg)

## Étape 2 – Retrait des disques durs

Le serveur possède trois disques SAS installés dans les baies à l'avant.

![Retrait des disques](images/IMG_2705.jpg)

### Identification d'un disque SAS

Le disque présenté possède une capacité de 146 Go et une vitesse de rotation de 15 000 tr/min.

![Disque SAS](images/IMG_2706.jpg)

## Étape 3 – Retrait de la mémoire RAM

Les barrettes de mémoire sont retirées pour identifier leur type et leur capacité.

![Barrettes de mémoire RAM](images/IMG_2707.jpg)

## Étape 4 – Retrait du processeur

Après le retrait du système de refroidissement, le processeur peut être retiré de son socket avec précaution.

![Processeur Intel Xeon](images/IMG_2711.jpg)

## Étape 5 – Identification de la mémoire cache RAID

Le contrôleur RAID possède un module de mémoire cache utilisé pour les opérations de stockage.

![Mémoire cache RAID](images/IMG_2714.jpg)

---

# 🧪 Partie 2 – Tests des composants

## Étape 6 – Premier démarrage avec un processeur

La configuration minimale présentée utilise :

- 1 processeur Intel Xeon E5540 à 2,53 GHz.
- 1 barrette de RAM de 16 Go.

L'écran de démarrage montre la détection du processeur et de la mémoire.

![Premier démarrage](images/IMG_2717.jpg)

### Accès au BIOS

La touche **F9** permet d'accéder à l'utilitaire de configuration du serveur.

![Accès au BIOS](images/IMG_2718.jpg)

### Vérification des processeurs

Le BIOS indique que le deuxième processeur n'est pas installé dans cette configuration.

![Vérification du processeur](images/IMG_2719.jpg)

## Étape 7 – Démarrage avec deux processeurs

La deuxième configuration présentée comprend :

- 2 processeurs Intel Xeon.
- 16 Go de RAM.

L'écran de démarrage indique une mémoire configurée de 16 384 Mo.

![Démarrage avec deux processeurs](images/IMG_2720.jpg)

---

# 💾 Partie 3 – Configuration RAID

## Étape 8 – Accès à HP Array Configuration Utility

L'utilitaire HP Array Configuration Utility permet de gérer les disques physiques et les volumes logiques du serveur.

![HP Array Configuration Utility](images/IMG_2722.jpg)

## Étape 9 – Ancien volume RAID

L'ancienne configuration présentée est un volume RAID 5 d'environ 273,4 Go.

![Ancienne configuration RAID](images/IMG_2723.jpg)

## Étape 10 – Sélection des disques

Les trois disques SAS sont sélectionnés pour la configuration d'un volume logique en RAID 5.

Le RAID 5 répartit les données et les informations de parité sur plusieurs disques.

![Sélection RAID 5](images/IMG_2724.jpg)

## Étape 11 – Sauvegarde de la configuration

La configuration sélectionnée est vérifiée avant son enregistrement.

La touche **F8** permet de sauvegarder la configuration dans l'utilitaire présenté.

![Sauvegarde RAID](images/IMG_2725.jpg)

## Étape 12 – Vérification du volume logique

Le contrôleur affiche la configuration suivante :

| Élément | Résultat affiché |
|---|---|
| Volume | Logical Drive #1 |
| Niveau RAID | RAID 5 |
| Capacité | 273,4 Go |
| État | OK |

![Vérification du volume RAID](images/IMG_2726.jpg)

---

# 🛠️ Partie 4 – Remontage du serveur

## Étape 13 – Installation des barrettes RAM

Après les tests, les barrettes de mémoire sont réinstallées.

L'écran de diagnostic présente une mémoire disponible d'environ 60 Go.

![Vérification de la mémoire](images/IMG_2727.jpg)

## Étape 14 – Vérification de la configuration finale

La configuration finale documentée comprend :

- 2 processeurs Intel Xeon.
- Environ 60 Go de mémoire disponible.
- 3 disques SAS configurés en RAID 5.
- 2 blocs d'alimentation HP.

![Configuration finale du serveur](images/IMG_2728.jpg)

---

# 📊 Résultat du laboratoire documenté

| Composant | Configuration présentée