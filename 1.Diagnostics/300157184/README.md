# 🧪 LABORATOIRE : DIAGNOSTIC ET ANALYSE D’UN SERVEUR HP PROLIANT DL360 G6 
                                        
1. Identification du ComposantDénomination commerciale : NVIDIA RTX A2000 Laptop GPU
   
2. Facteur de forme : Module MXM 3.1 Type B (Mobile PCI Express Module)
   
3.  Architecture : NVIDIA AmpereCatégorie : Unité de traitement graphique (GPU) professionnelle pour stations de travail mobiles et systèmes embarqués
  
4. Référence constructeur (Dell DP/N) : 0JDC1F
   
5. Référence NVIDIA (Board ID) : 900-53093-0201-000 / Model P6172a

    
Interface du BIOS (RBSU) du serveur HP ProLiant DL360 G6 affichant un processeur Intel (2.40 GHz), 8 Go de RAM installés et le menu de configuration système.
   
![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/9ac4d7d36c969e34252e986bb29e9c8a60c9fe9e/1.Diagnostics/300157184/images/WhatsApp%20Image%202026-09-18%20at%2011.08.00.jpeg) 

cet image presente l'interieur d'un serveur HP Proliant DL360 G6. On peut obserser la carte mere, les emplacements de memoire RAM, les dissipateurs thermiques et les ventilateurs. Ces compsants permetent au serveur de traiter les information, de stocker temporairement les donnees et de maintenir une temperature de 
fonctionnement adequate



### Suppression d'une configuration RAID (HP Smart Array P410i)

![image alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/aa77a0e15966e647c4df4e9e887a4df25c3317c5/1.Diagnostics/300157184/images/WhatsApp%20Image%202026-10-22%20at%2013.39.52%20(2)_edited.jpg)

* **Contrôleur :** HP Smart Array P410i (Slot 0)[cite: 4]
* **Action :** Confirmation de la suppression du volume logique (#1)[cite: 4]
* **Configuration :** RAID 5 d'une capacité de 273,4 Go composé de 3 disques physiques[cite: 4]
* **Avertissement :** Perte totale et définitive des données présentes sur la grappe lors de la validation (`F3`)[cite: 4]


### Menu principal du contrôleur RAID (HP Option ROM Configuration for Arrays)

![images alt ](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/8c01d19890b19bb063087523bdb7f8fd770f042e/1.Diagnostics/300157184/images/WhatsApp%20Image%202026-10-22%20at%2013.39.52%20(1).jpeg)

* **Contrôleur :** HP Smart Array P410i (version 8.30.02.00 / Slot 0)[cite: 5]
* **Interface :** Menu principal de configuration de l'utilitaire d'extension ROM (ORCA)[cite: 5]
* **Options disponibles :**
  * **Create Logical Drive :** Créer un nouveau volume/lecteur logique (Option actuellement sélectionnée)[cite: 5]
  * **View Logical Drive :** Afficher les volumes logiques existants et leur statut[cite: 5]
  * **Delete Logical Drive :** Supprimer un volume logique existant[cite: 5]
  * **Manage License Keys :** Gérer les clés de licence du contrôleur[cite: 5]

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/9de6fd289bf03c71f874af744f3a9ff75e98596d/1.Diagnostics/300157184/images/WhatsApp%20Image%202026-09-18%20at%2011.12.58.jpeg)
Cette image présente une carte graphique NVIDIA RTX A2000 Laptop GPU au format MXM (Mobile PCI Express Module). Cette carte graphique est conçue pour les ordinateurs portables professionnels et permet de traiter les tâches graphiques, la modélisation 3D et les applications nécessitant des performances graphiques élevées. Son format MXM permet son intégration dans des systèmes compatibles.

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/78761795238e078bb7ca47bf23b9b8acc92913c1/1.Diagnostics/300157184/images/WhatsApp%20Image%202026-09-18%20at%2011.08.01%20(1).jpeg)


![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/fe05635d737ebc8c6c9153bb7faa57a1f7f65b09/1.Diagnostics/300157184/images/WhatsApp%20Image%202026-09-18%20at%2011.08.02.jpeg)

1. Le câble d'alimentation (à connecteur noir C13)Emplacement : Branchement sur le premier bloc d'alimentation de 460W du serveur à droite, et au dos de l'écran Dell à gauche.   Rôle : Fournir l'énergie électrique du réseau secteur (230V / 110V) à chacun des appareils pour les sous-mettre sous tension.
   
2. Le câble vidéo VGA (à connecteur bleu avec vis)Emplacement : Branché sur le port vidéo VGA du serveur (à gauche du bloc d'alimentation) et sur l'entrée VGA bleue au dos de l'écran.   Rôle : Transmettre le signal vidéo analogique du serveur vers l'écran pour afficher l'interface graphique, le BIOS/POST ou le terminal de commande


