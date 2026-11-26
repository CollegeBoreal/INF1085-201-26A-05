# Laboratoire 3 - Machines virtuelles

## Informations

- Matricule : 300151449
- Etudiant : Abderrahim
- Cours : INF1085

## Configuration Proxmox

| Parametre | Valeur |
|---|---|
| Serveur | server197 |
| IP Proxmox | 10.7.236.197 |
| VM ID | 103 |
| Nom | Abderrahim-Ubuntu |
| Systeme | Ubuntu Server 24.04.5 LTS |
| RAM | 4 Go |
| CPU | 2 coeurs |
| Disque | 20 Go |
| Bridge | vmbr0 |

## Configuration reseau

| Parametre | Valeur |
|---|---|
| Interface | ens18 |
| Adresse IP | 10.7.236.167/23 |
| Passerelle | 10.7.237.1 |
| DNS | 8.8.8.8 |
| DHCP | Desactive |

## Configuration SSH

- Service OpenSSH actif.
- Port 22 accessible.
- Utilisateur : ubuntu
- Cle publique RSA presente.
- Identifiant : b300098957@ramena
- Permissions .ssh : 700
- Permissions authorized_keys : 600

## Connexion SSH

```bash
ssh ubuntu@10.7.236.167
```

## Resultats des tests

| Test | Resultat |
|---|---|
| Installation Ubuntu | Reussie |
| Configuration IP statique | Reussie |
| SSH local | Reussi |
| Ping depuis Windows | 0 % de perte |
| Test du port 22 | True |
| SSH depuis Windows | Reussi |
| Acces du professeur | A confirmer |
| Internet et DNS | A confirmer |

## Conclusion

La machine virtuelle Ubuntu est operationnelle.
La connexion SSH depuis Windows a ete testee avec succes.
La validation par le professeur reste a confirmer.
