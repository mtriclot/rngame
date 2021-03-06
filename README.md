# RNGames data exploitation

This repository contains data collected using RNGames during game session (rhythmanalysis) and R scripts to exploits them.
The software can be found [here](https://github.com/GamesRythmAnalysis/RNGames).
It comes from students MR projects (Methodologie Recherche) at UTBM.

There are three main components : 
- [RNGames](https://github.com/GamesRythmAnalysis/RNGames) (developped by students) as a simple keylogger for game sessions (currently Win and Linux)
- the collected data sets
- all the post-processing, done in R (scripts)

## Mode d'emploi
- Installer R (https://www.r-project.org/) et RStudio (https://www.rstudio.com/)
- Télécharger sous forme de zip ce dossier (bouton "clone or download") et le déziper sur votre ordinateur
- Placer vos fichiers de données à analyser dans le répertoire Data
- Charger Rythma.5.1.R (dans R Studio) [ou la dernière version disponible du script d'amorçage]
- Vérifier que le chemin vers Rythma.5.1.R (où est située la fonction principale) est le bon
- setwd("~/Documents/Projets R/Rythmanalyse"), à modifier selon l'emplacement de Rythma.5.1.R sur votre ordinateur
- Pour une analyse d'un seul fichier : Rythmanalyse ("2016.03.24.MT.Sylvio.s1.zip")
- Pour préciser des plages temporelles : Rythmanalyse ("2016.03.24.MT.Sylvio.s1.zip", debut = 5, fin =60)
- Pour un traitement de plusieurs fichiers en une seule fois, suivre la procédure au bas du script

## Contribuer :
- voir [Contributing.md](CONTRIBUTING.md)

## A faire :
- la [To-Do list](TODO.md)

## Les dernière nouveautés
- Le [changelog](CHANGELOG.md)
