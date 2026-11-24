# Diagnostic du HP ProLiant DL360 G6

Lyes Medjahed · 300153676 · Groupe 2

Le serveur du groupe porte l’étiquette S39. Le modèle étudié utilise deux processeurs Xeon E5540. Chaque processeur possède quatre cœurs physiques. Les disques SAS sont reliés au contrôleur RAID. En RAID 5, les données et la parité sont réparties entre les disques.

## Interprétation du démarrage

Le POST vérifie le matériel avant le chargement de Linux. Si un processeur manque, relever le message du BIOS et les voyants CPU et mémoire. Le test décrit dans le cours consiste à essayer CPU2 seul dans le socket 1 avec une barrette compatible. Un POST réussi oriente le diagnostic vers le second socket ou son circuit mémoire.

Les observations du BIOS et la configuration réelle des disques restent à relever au labo.
