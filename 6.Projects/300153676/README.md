# Page Web du laboratoire Linux

Lyes Medjahed · 300153676 · Groupe 2

Ce projet publie une page Web qui identifie la VM Ubuntu du laboratoire. Le fichier [index.html](index.html) contient la page.

## Essai sur la VM

Dans le répertoire contenant `index.html`, lancer `python3 -m http.server 8080 --bind 0.0.0.0`. Depuis un poste du réseau du labo, ouvrir `http://10.7.237.162:8080/`. La page doit afficher le titre du cours et l’identifiant étudiant. Arrêter le serveur avec Ctrl+C après la démonstration. Le déploiement sur la VM reste à vérifier.
