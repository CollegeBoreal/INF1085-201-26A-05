# 📊 Projet – Serveur de monitoring Linux avec Grafana et Prometheus

**Nom :** Ouassim Ahmed Benamira  
**Matricule :** 300150564  
**Cours :** INF1085 – Administration Linux  

---

## 🎯 Présentation du projet

L'objectif de ce projet est de mettre en place un **serveur de monitoring Linux** permettant de surveiller l'état et les performances d'un serveur.

La solution utilisera trois outils principaux :

- **Node Exporter** pour récupérer les informations du système Linux ;
- **Prometheus** pour collecter et conserver les métriques ;
- **Grafana** pour afficher les métriques dans des tableaux de bord.

Cette solution permettra de surveiller facilement le serveur depuis une interface Web.

---

## 🧰 Technologies utilisées

| Technologie | Rôle |
|---|---|
| **Ubuntu Server** | Système d'exploitation du serveur |
| **Node Exporter** | Récupération des métriques Linux |
| **Prometheus** | Collecte et stockage des métriques |
| **Grafana** | Création des tableaux de bord |
| **SSH** | Administration du serveur à distance |
| **Navigateur Web** | Consultation de Grafana et Prometheus |

---

## 🏗️ Architecture prévue

```text
┌──────────────────────────┐
│      Serveur Linux       │
│                          │
│      Node Exporter       │
│   CPU / RAM / Disque     │
│       Réseau / Uptime    │
└────────────┬─────────────┘
             │
             │ Métriques
             ▼
┌──────────────────────────┐
│        Prometheus        │
│                          │
│  Collecte et conserve    │
│      les métriques       │
└────────────┬─────────────┘
             │
             │ Source de données
             ▼
┌──────────────────────────┐
│          Grafana         │
│                          │
│   Graphiques et tableaux │
│         de bord          │
└────────────┬─────────────┘
             │
             ▼
      🌐 Navigateur Web
```

---

## 📈 Informations surveillées

Le serveur de monitoring permettra notamment de surveiller :

- 🖥️ l'utilisation du processeur **CPU** ;
- 🧠 l'utilisation de la mémoire **RAM** ;
- 💾 l'utilisation de l'espace disque ;
- 🌐 l'activité du réseau ;
- ⚙️ la charge du système ;
- ⏱️ le temps de fonctionnement du serveur (**uptime**) ;
- 📊 l'évolution des performances dans le temps.

---

## 🔄 Fonctionnement

### 1. Node Exporter

**Node Exporter** sera installé sur le serveur Linux.

Son rôle sera de récupérer différentes informations sur le système comme :

```text
CPU
RAM
Disque
Réseau
Uptime
Charge système
```

---

### 2. Prometheus

**Prometheus** récupérera régulièrement les métriques fournies par Node Exporter.

Il permettra de :

- collecter les données ;
- conserver les métriques ;
- effectuer des requêtes ;
- fournir les données à Grafana.

---

### 3. Grafana

**Grafana** sera utilisé comme interface graphique.

Il permettra de transformer les métriques de Prometheus en :

- graphiques ;
- statistiques ;
- indicateurs ;
- tableaux de bord.

Les informations pourront être consultées depuis un navigateur Web.

---

## 🌐 Services prévus

Les principaux services du projet seront :

| Service | Port par défaut | Fonction |
|---|---:|---|
| SSH | `22` | Administration à distance |
| Node Exporter | `9100` | Exposition des métriques Linux |
| Prometheus | `9090` | Collecte et consultation des métriques |
| Grafana | `3000` | Interface Web de monitoring |

---

## 🧪 Tests prévus

Une fois l'installation terminée, plusieurs tests seront réalisés.

### Vérification des services

Je vérifierai que les différents services sont actifs et fonctionnent correctement.

### Vérification de Prometheus

Prometheus devra reconnaître le serveur surveillé et recevoir les métriques de Node Exporter.

### Vérification de Grafana

Prometheus sera ajouté comme source de données dans Grafana.

Un tableau de bord permettra ensuite de visualiser les métriques du serveur.

### Test de charge

Un test pourra également être réalisé pour augmenter temporairement l'utilisation du CPU ou de la mémoire.

L'objectif sera d'observer le changement directement dans les graphiques Grafana.

---

## 🔐 Sécurité

Une attention particulière sera portée à la sécurité du serveur.

Les éléments suivants seront vérifiés :

- accès au serveur avec SSH ;
- utilisation d'un compte administrateur approprié ;
- vérification des ports utilisés ;
- configuration du pare-feu si nécessaire ;
- accès contrôlé à l'interface Grafana ;
- vérification de l'état des services.

---

## 🎯 Résultat attendu

À la fin du projet, le serveur devra être capable de :

- ✅ récupérer automatiquement les métriques Linux ;
- ✅ surveiller le CPU ;
- ✅ surveiller la mémoire RAM ;
- ✅ surveiller l'espace disque ;
- ✅ surveiller l'activité réseau ;
- ✅ surveiller l'uptime du serveur ;
- ✅ collecter les données avec Prometheus ;
- ✅ utiliser Prometheus comme source de données Grafana ;
- ✅ afficher les informations dans un dashboard Grafana ;
- ✅ consulter le monitoring depuis un navigateur Web ;
- ✅ observer les performances du serveur en temps réel.

---

## 📸 Documentation

Toutes les étapes importantes du projet seront documentées dans ce README.

Les captures d'écran seront placées dans :

```text
6.Projects/300150564/images/
```

Elles permettront de montrer :

- l'installation des services ;
- leur configuration ;
- leur état ;
- Prometheus ;
- Node Exporter ;
- Grafana ;
- les tableaux de bord ;
- les tests réalisés ;
- le résultat final.

---

## 📁 Structure du projet

```text
6.Projects/
└── 300150564/
    ├── README.md
    └── images/
        └── .gitkeep
```

---

## 🚧 État du projet

🟡 **Projet en préparation**

La structure du projet et l'architecture de la solution ont été définies.

Les étapes d'installation, de configuration, de vérification et les captures d'écran seront ajoutées progressivement pendant la réalisation du projet.

---

## 🏁 Conclusion prévue

Ce projet permettra de mettre en pratique plusieurs notions importantes du cours **INF1085 – Administration Linux**, notamment l'administration d'un serveur Linux, les services, le réseau, la sécurité et la surveillance des ressources système.

L'objectif final est d'obtenir une solution de monitoring fonctionnelle permettant de visualiser simplement l'état et les performances d'un serveur Linux avec **Prometheus et Grafana**.