# Diagnostic matériel d’un serveur HP ProLiant

**Anis Benabbas · 300150477 · Groupe 1**  
INF1085 — Administration Linux · Collège Boréal

Pour diagnostiquer un serveur qui ne démarre pas, ce compte rendu présente trois vérifications : identifier les composants installés, lire les résultats du démarrage, puis vérifier le stockage dans l’utilitaire RAID. Les photos de laboratoire du groupe 1 illustrent plusieurs essais. Les valeurs indiquées ci-dessous se rapportent à l’écran de chaque essai.

## 1. Repérer les composants

| Châssis ouvert | Installation de la mémoire | Identification d’un disque |
| --- | --- | --- |
| ![Vue de la carte système et des emplacements mémoire](images/11.jpeg) | ![Installation de la RAM](images/02-ram-installation.png) | ![Étiquette du disque SAS](images/IMG_2706.jpg) |
| Les rangées de connecteurs DIMM sont visibles sur la carte système. | Les barrettes occupent les emplacements mémoire associés au processeur. | L’étiquette indique un disque SAS de 146 Go. Cette valeur concerne un seul disque physique. |

## 2. Vérifier le démarrage et la détection des processeurs

Le POST est le test effectué par le serveur à la mise sous tension. L’affichage du POST donne un premier point de contrôle. On peut ensuite comparer la mémoire et les processeurs détectés aux composants installés.

| Contrôle | Photo du laboratoire | Observation |
| --- | --- | --- |
| Affichage au démarrage | ![Serveur ouvert et écran HP ProLiant au démarrage](images/15.jpeg) | L’écran relié au serveur affiche la séquence de démarrage HP ProLiant. |
| Essai avec un processeur | ![POST avec un processeur et 16 Go de RAM](images/IMG_2717.jpg) | Le premier essai affiche un Intel Xeon E5540 et 16 Go de mémoire. |
| Vérification dans le BIOS | ![État des sockets dans le BIOS RBSU](images/04-bios-rbsu.png) | Le BIOS indique « Proc 2 Not Installed ». Cette indication décrit la détection du second processeur lors de cet essai. |
| Essai avec deux processeurs | ![Détection des deux processeurs au démarrage](images/IMG_2720.jpg) | Lors d’un autre essai, le démarrage affiche deux processeurs et 16 384 Mo de mémoire configurée. |

Le résultat du BIOS doit être interprété avec la configuration de l’essai. Si le second emplacement est vide, « Not Installed » est attendu. Si un processeur y est installé, ce même message signale un écart à examiner.

## 3. Contrôler le volume RAID 5

### Sélection des disques

Le contrôleur Smart Array présente trois disques SAS de 146,8 Go. Le choix du RAID 5 permet de regrouper ces disques en un volume logique. Une partie de la capacité sert à la parité.

<img src="images/07-raid-config.png" alt="Sélection des disques physiques et du niveau RAID 5" width="520">

*Sélection des disques dans l’utilitaire du contrôleur.*

### Message de diagnostic

Lors d’un essai, le contrôleur a signalé un déplacement de disque (« invalid drive movement »). Le message avertit qu’une modification de la configuration peut faire perdre l’accès aux données de l’ancien volume. Le premier contrôle consiste à vérifier la position des disques dans les baies.

<img src="images/08-raid-error.png" alt="Avertissement du contrôleur après un déplacement de disque" width="520">

*Avertissement affiché par le contrôleur RAID.*

### Vérification du résultat

<img src="images/IMG_2726.jpg" alt="Volume logique RAID 5, capacité de 273,4 Go et état OK" width="520">

*Le contrôleur affiche « Logical Drive #1 », RAID 5, environ 273,4 Go et l’état « OK ».*

Cet écran confirme que le contrôleur reconnaît le volume logique. La vérification du système de fichiers relève d’une étape distincte dans le système d’exploitation.
