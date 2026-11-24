# Stockage de la VM

Lyes Medjahed · 300153676 · Groupe 2

## Questions de réflexion

1. Un HDD utilise des plateaux mécaniques. Un SSD SATA utilise de la mémoire flash avec l’interface SATA. Un SSD NVMe utilise le protocole NVMe sur PCIe.
2. Une partition délimite une zone du disque pour un usage précis.
3. Le système de fichiers organise les fichiers et les répertoires sur un volume.
4. En LVM, un PV est un volume physique, un VG un groupe de volumes et un LV un volume logique créé dans ce groupe.
5. LVM-Thin alloue les blocs au fur et à mesure des écritures. Il faut surveiller l’espace libre du pool.
6. `pvesm status` affiche les stockages configurés et leur occupation.
7. La faible latence du NVMe réduit le temps d’attente quand plusieurs VM accèdent au disque.

## Vérification du déplacement

Sur le serveur du groupe, identifier sa VM dans `qm list`, puis relever son disque dans `qm config <VMID>` avant et après le déplacement. Le disque actif doit être rattaché à `nvme-storage`. Comparer les listes de volumes de la VM sur `nvme-storage` et `local-lvm` pour vérifier si un ancien volume occupe encore de la place. Les mesures avant et après restent à relever.
