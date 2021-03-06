## ACP.Rythmanalyse
## Corpus Nice

rm (list=ls())
setwd("~/Documents/Projets R/Rythmanalyse/Zone Travail/Analyse")

# Installation (si besoin) et chargement des packages requis
packages <- c("FactoMineR")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
library(FactoMineR)

# Charger les données
d <- read.csv("rythmanalyse.csv")

# On sélectionne ce qu'on veut traiter
# On ne garde que enregistrements où durée pad > 10 min, appuis > 10
d.P <- subset (d, d$P.DuM > 10 & d$P.NbAppuis > 10) 
# On enlève les colonnes inutiles
d.P <- d.P [,c (2:5, 27:44)]
# On choisit les colonnes (par leur nom) que l'on va conserver dans l'analyse
# Ne retenir que des variables continues
names (d.P) # pour afficher le nom des variables
attach (d.P)
dcomp <- data.frame (titre, 
                     P.NbTouchesFreq,
                     P.NbAppuisS,
                     P.TpMoyEntreAppuis,
                     P.TpMoyAppui,
                     P.TpMoyEntreAppuisFreq,
                     P.TpMoyAppuiFreq,
                     P.Vit,
                     P.VitG,
                     P.VitD)
detach (d.P)
# On fait les moyennes pour chaque titre
dcomp <- aggregate(dcomp[,2:ncol(dcomp)], by=list(dcomp$titre), FUN=mean)
rownames (dcomp) <- dcomp$Group.1

# On sort le graphique
# Avec les flèches sous Plots dans la fenêtre de droite, on peut 
# passer du résultat de l'ACP à l'analyse des axes
# pour enregistrer le graph, utiliser export
res.pca <- PCA(dcomp[,2:ncol(dcomp)], scale.unit=TRUE, ncp=6, graph=T)

# On fabrique un graphique avec les deux côte à côte
# pour enregistrer le graph, utiliser export
opar <- par(no.readonly=TRUE)
par (fig = c (0,0.5,0,1), mar = c(4,2.5,3.5,1))
graph.var (res.pca, xlim = NULL, ylim = NULL)
par (fig = c (0.5,1,0,1), mar = c(4,4,3.5,1),
     new = TRUE)
plot.PCA(res.pca, axes=c(1, 2), choix="ind", cex = 0.75, label = c("ind"),
         invisible = "quali", 
         title = paste ("PAD","\n","n:",nrow(dcomp)),
         select = "dist 35",
         col.quali  = rainbow (9))
par (opar)
