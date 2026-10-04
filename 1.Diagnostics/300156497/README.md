# 300156497
# Configuration du serveur HP ProLiant DL360 G6
![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/1.diagnostic/300156497/images/c2cb620f-8b42-43cd-a64a-4bd295b81138.jpeg?raw=true) Cette image montre le capot d'un serveur HP ProLiant DL360 G6 retiré, avec ses schémas techniques imprimés bien visibles. En bas, on distingue l'arrière du serveur avec son câble d'alimentation sur le bloc PS2 et son câble vidéo VGA bleu connectés

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/1.diagnostic/300156497/images/0a5d22d4-ba33-49df-8a22-de06ffa339c3.jpeg?raw=true) Cette photo montre l'intérieur du serveur HP DL360 G6 avec un gros plan sur les barrettes de mémoire RAM installées dans leurs slots. En arrière-plan, on aperçoit les deux imposants dissipateurs thermiques en aluminium qui recouvrent les emplacements processeurs

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/1.diagnostic/300156497/images/9427c2f4-776e-48d6-b46f-130f0e189fd2.jpeg?raw=true) Cette image affiche le processus de démarrage (POST) du serveur avec le chargement de la carte réseau Broadcom et du contrôleur d'aménagement distant iLO 2. Elle montre aussi une alerte de la carte HP Smart Array P410i indiquant un changement de position des disques et recommandant une mise à jour de leur firmware

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/1.diagnostic/300156497/images/e7eac604-9f9c-4b52-a965-2d4592187f6c.jpeg?raw=true) Cette image montre l'utilitaire de configuration du BIOS HP (ROM-Based Setup Utility v3.00). On y voit les options du système à gauche et les informations du serveur à droite, confirmant un DL360 G6 avec 8192 MB de RAM et un seul processeur Intel à 2.40GHz installé

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/1.diagnostic/300156497/images/e141e997-d84b-4698-9439-b49b95fa9cbd.jpeg?raw=true) Cette image montre l'écran du menu de création d'un volume RAID dans l'utilitaire Option ROM Configuration for Arrays. Trois disques durs SAS de 146,8 Go sont sélectionnés à gauche pour configurer un tableau en RAID 5 à droite

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/1.diagnostic/300156497/images/8dfcbe95-c2dd-422e-95bd-dd4cd1700de8.jpeg?raw=true) Avertissement rouge du Smart Array signalant un déplacement de disques invalide au POST. Toute modification risque d'effacer la configuration et les données des volumes existants

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/1.diagnostic/300156497/images/4306a99c-76ac-4aeb-b926-6f0bfb003784.jpeg?raw=true) L'enregistrement est effectué avec succès et le nouveau volume logique RAID 5 de 273,4 Go est désormais opérationnel sur le contrôleur Smart Array. Le serveur est à présent prêt pour l'installation d'un système d'exploitation
