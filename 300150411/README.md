# 300150411
# Création d’une VM Ubuntu sur Proxmox
1. Connexion
Je me connecte à Proxmox :
ssh root@10.7.237.200
# 2. Vérification
Je vérifie les VM et les ISO disponibles :
qm list
ls -lh /var/lib/vz/template/iso
# 3. Téléchargement Ubuntu
Je télécharge l’ISO Ubuntu Server :
wget https://releases.ubuntu.com/24.04/ubuntu-24.04.5-live-server-amd64.iso
# 4. Création de la VM
Je crée la VM avec 4 Go de RAM, 1 CPU et 20 Go de disque.
# 5. ISO et démarrage
J’ajoute l’ISO Ubuntu, puis je démarre la VM :
qm start 101
# 6. Vérification
Je vérifie que la VM fonctionne :
qm status 101

Conclusion : La VM Ubuntu Server est créée et fonctionne correctement sur Proxmox.


