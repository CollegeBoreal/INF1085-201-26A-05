# 300151496


<image src=images/11.jpeg width=50% height=50%> </image>


<image src=images/15.jpeg width=50% height=50%> </image>
<image src=images/12.jpeg width=50% height=50%> </image>
<image src=images/13.jpeg width=50% height=50%> </image>
<image src=images/14.jpeg width=50% height=50%> </image>
<image src=images/16.jpeg width=50% height=50%> </image>


DOCUMENTATION TECHNIQUE : INTERVENTION SUR SERVEUR

Objectif : Démarrage minimal (POST) et accès aux configurations système (BIOS/Setup).

1. Matériel & Configuration Minimale

Châssis : Serveur HP ProLiant (Série ProLiant DL380).

Processeur (CPU) : 1 seul processeur installé (Socket CPU 1). Le second socket CPU 2 est laissé vide.

Mémoire (RAM) : Configuration minimale (barrette(s) installée(s) uniquement sur les slots attribués au CPU 1).

Alimentation : Bloc d'alimentation branché sur le châssis (PS1).

Affichage & Périphériques : Écran connecté via le port VGA intégré au serveur ; clavier branché en USB.

2. Étapes de la Procédure

Dépouillement des composants (Minimal Boot) : Retrait des composants non essentiels (deuxième CPU, cartes d'extension risers/PCIe, disques supplémentaires) pour isoler le système et valider les composants de base.

Raccordement : Connexion du câble d'alimentation, du câble VGA vers le moniteur et du clavier.

Mise sous tension & POST : Démarrage du serveur et initialisation du test POST (Power-On Self-Test).

Accès au Setup (BIOS) : Pression de la touche F9 au moment de l'invite de commande de démarrage (System Utilities / ROM-Based Setup Utility - RBSU).

3. Résultats Obtenus

Succès de l'affichage vidéo via la sortie VGA.

Validation du bon fonctionnement de la carte mère, de l'alimentation PS1, du processeur CPU 1 et des barrettes de RAM principales.

Accès réussi au menu BIOS/System Utilities via la touche F9.
