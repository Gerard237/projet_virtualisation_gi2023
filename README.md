# projet_virtualisation_gi2023
## Group F 
### Membre du Group: 
##### -FONE KANKEU PATRICK LEONEL
##### -KANA NGUEDIA FRANKLIN
##### -FOM SIMO GERARD MICHEL
##### -WAMBA DONEL
##### -NDJANA NGONO HONORINE INES


## Il est indispensable de lire et respecter toutes les étapes ci-après pour pouvoir executer le projet

On suppose que vous disposez de l'hyperviseur xen installé sur votre machine et que vous pouvez aisément créer des machines virtuelles dessus

### ETAPE 1
vous devez éditer le fichier vm_parameter.txt, à la racine du projet. 
  - A la première ligne, entrez le nom de domaine d'une de vos vm, qui sera le domU pour le projet ex: myvm
  -A la deuxième ligne, entrez le chemin du fichier de configuration de votre vm ex: /etc/xen/myvm.cfg
  -A la troisième ligne, on entre le nom du fichier compressé contenant les sources de notre application. Ce fichier compressé doit être à la racine du projet comme tous les autres script. Pour l'instant l'application par défaut est postgresql. 

### ETAPE 2
Assurez vous que votre vm sois en réseau avec le dom0.
Pour celà vous devez exécutez le script network.sh au niveau du dom0 et le script network_.sh au niveau du domU.
Notez que les modifications apportées par ces scripts sont effacés au redémarrage, ce qui nous oblige à les executer à chaque fois que le dom0 et le domU redémarre. Pour éviter celà, il faudrait définir ces scripts comme des services qui s'executerons automatiquement au démarrage du dom0 et du domU.

### ETAPE 3
Créer un utilisateur guest et l'ajouter au groupe sudoers. Pour celà, suivre les étapes ci-après :
 -adduser guest
 -groups guest
 -usermod -aG sudo guest
 -visudo
 
 une fois celà fais, il faut établi une liaison ssh entre le dom0 et le domU. ( Le dom0 doit pouvoir se connecter au domI via ssh). Le serveur open ssh est par défaut disponible sur le dom U, de même que le client ssh sur le dom0.
Tout ce qu'il y'a à faire c'est d'éditer le fichier de configuration ssh_d.conf et de decommenter les lignes relative au password et à l'authentification vis une clé publique puis de les mettre à "yes"


permitpaeswordAuthentification yes 
permitPublicKeyAuthentification yes 

Puis redémarrer le service ssh:
sudo systemctl restart ssh

Au niveau du dom générez une paire clé publique/ clé privée grâce à la commande :  ssh-keygen -t

Puis copier la clé publique au niveau du serveur open ssh sur le domU grâce à la commande : ssh-copy-id guest@192.168.1.102.

### N.B 
192.168.1.102 est l'adresse IP du domU dans le réseau avec le dom0. Il est défini dans le script network _.sh.

### ETAPE 4
une fois tout cela fait, , éteindre le domU et lancer le script deploy.sh au niveau du doma0.


