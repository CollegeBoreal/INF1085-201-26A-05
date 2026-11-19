# Projet Linux — Serveur DNS avec Pi-hole

## 1. Présentation du projet

Dans le cadre de mon cours Linux, j'ai choisi de réaliser un projet de serveur DNS utilisant **Pi-hole**.

Pi-hole est un logiciel gratuit et open source permettant de filtrer les requêtes DNS afin de bloquer les publicités et certains domaines indésirables sur un réseau.

## 2. Objectifs du projet

Les objectifs de ce projet sont :

- Installer et configurer Pi-hole sur un serveur Linux.
- Comprendre le fonctionnement du protocole DNS.
- Mettre en place un système de filtrage des domaines.
- Accéder à une interface Web pour administrer le serveur.
- Tester le blocage des domaines depuis un ordinateur client.

## 3. Technologies utilisées

- **Linux (Ubuntu Server ou Debian)** : système d'exploitation du serveur.
- **Pi-hole** : logiciel de filtrage DNS.
- **DNS** : protocole permettant de traduire les noms de domaine en adresses IP.
- **Navigateur Web** : accès à l'interface d'administration.
- **Machine virtuelle** : environnement de test, si nécessaire.

## 4. Étapes de réalisation

### Étape 1 : Préparation du serveur

Installer Linux sur une machine virtuelle et configurer le réseau.

### Étape 2 : Installation de Pi-hole

Installer Pi-hole en suivant la documentation officielle.

### Étape 3 : Configuration DNS

Configurer Pi-hole et définir les paramètres nécessaires au filtrage DNS.

### Étape 4 : Interface d'administration

Accéder au tableau de bord de Pi-hole pour observer les statistiques et les requêtes DNS.

### Étape 5 : Tests

Configurer un ordinateur client pour utiliser Pi-hole comme serveur DNS.

Tester la résolution DNS et le blocage de domaines figurant dans les listes de filtrage.

## 5. Démonstration prévue

Lors de ma présentation, je vais :

1. Présenter le serveur Linux.
2. Expliquer le fonctionnement de Pi-hole.
3. Montrer l'interface Web.
4. Effectuer une requête DNS de test.
5. Montrer les statistiques et les domaines bloqués.

## 6. Résultats attendus

À la fin du projet, je souhaite obtenir un serveur DNS fonctionnel capable de filtrer certains domaines indésirables et d'afficher les statistiques des requêtes DNS.

## 7. Conclusion

Ce projet me permettra de développer mes compétences en administration Linux, en configuration réseau et en gestion de services.

Il représente également une application pratique de la sécurité et de la gestion d'un réseau informatique.

## 8. Référence

Documentation officielle : https://docs.pi-hole.net/
