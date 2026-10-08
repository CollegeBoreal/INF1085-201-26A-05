# 300156497
# Création d’un utilisateur administrateur sur Proxmox


# 1. Créer l'utilisateur avec l'ID étudiant
pveum user add TON_ID@pve

# 2. Définir le mot de passe
pveum passwd TON_ID@pve

# 3. Donner les droits administrateur
pveum acl modify / -user TON_ID@pve -role Administrator

# 4. Vérifier l'utilisateur
pveum user list

# 5. Vérifier les permissions
pveum acl list

![images alt](https://github.com/CollegeBoreal/INF1085-201-26A-05/blob/main/4.Root/300156497/images/b00144f7-317d-4569-b700-e700033348c3.jpeg?raw=true)
