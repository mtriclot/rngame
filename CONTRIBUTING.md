# Règle de contributions aux scripts de rythmanalyse

## Convention de progrmation :

- ### Convention pour nommer les varible, fonction et fichier :
  - indentation de deux espace (par défaut dans Rstudio)
  - saut de ligne avant un commentaire ou block de commentaire
  - saut de ligne avant un block de code (les block de code sont définit par {})
  - pas d'accent ou caractère spéciaux Rstudio aime pas soit ça finit illisible soit ça crée des bug
  - Concernant la typos des variables :
    - Les variable qui serons exporter comme resultat commence par: 
        - M. pour la souris
        - K. pour le clavier
        - P. pour le pad 
        - ...
    - Les variable exporté sont en [UpperCamelCase](https://fr.wikipedia.org/wiki/Camel_case) ex M.VitMoy
    - Les variable local sont en lowerCamelCase
    - Les constante sont en SCREAMING CASE
  - Les nom des fonction suive la convention R (tout en minuscule les mots séparés par des ".")
  - Les fichier on le même nom que la fonction (convertis en UpperCamelCase ?) suivis par leur version
  
- ### Convention pour écrire le code (faudrais trouver un meilleur titre)
  - Une fonction = un fichier (Oui c'est ennuyeux, mais ça réduit les problèmes de conflits de fichier)
  - Tout morceaux de code présent presque a l'identique plus de deux fois doit être expoté en une fonction
  
- ### Convention pour les branches :
  - La branche master ne contient que du code stable, robuste, valider.
  - La branche developpemnt contient la prochaine version du master avant validation
  - Chaque branche développe ça propre fonctionalité
  - Aucun fichier ne doit être modifier dans deux branches à la fois
  - Les branches doivent être nommé comme suit :
    - Le nom du ou des fichier/dossier édité séparer par des underscores
    - Suivit par -[fonctionalité ajouté ou edité]
  - Les changement de version des fichiers est effectuer dans la branche développent avant les tests de robustesse ex: passer de AnalyseClavier-1.4.R à AnalyClavier-1.5.R
  - Les branches de fonctionnaliter doivent prendre pour base la branche dévelopement
  - Les personnes travaillant sur une branche sont responsables de sa capacité à être fusionnée avec la branche développement sans impacté la capacité des autres branches à l'être
  - Avant de fusionné une branche de fonctionalité avec la branche dévelopement expliqué les changements dans [changelog.md](CHANGELOG.md) sans suprimer les anciens changelog
  
