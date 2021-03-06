# ACP/ACM données rythmanalyse

rm (list=ls())
setwd("~/Documents/Projets R/Rythmanalyse/Data/Résultats et Analyses")

# Importer les données à partir du bon fichier !
d <- read.csv("rythmanalyseZIPOldFormat.csv")
nrow (d)
# On élimine les données foireuses
d <- subset (d, d$K.NbAppuis > 2 & d$K.DuM > 5  & d$M.DuM > 5 & d$M.NbClics > 2)
nrow (d)

## Subgenres /à condition d'avoir intégré les genres à la main dans le .csv
# d <- subset (d, d$Genre == "Fps")

## Sélection des variables que l'on veut tester
attach (d)
dcomp <- data.frame (titre, K.NbTouchesFreq, 
                    K.NbAppuisS, K.TpMoyEntreAppuis, 
                    K.TpMoyAppui, K.TpSDAppui,
                    M.NbCliclsS,M.TpMoyEntreAppuis)
detach (d)

# On regroupe par titre (moyennes)
dcomp <- aggregate(dcomp[,2:ncol(dcomp)], by=list(d$titre), FUN=mean)
rownames (dcomp) <- dcomp$Group.1

# on sauvegarde éventuellement dans un .csv
# write.csv2 (dcomp, file = "rythma.ALL.aggreg.csv")
# si besoin nettoyer les données (valeurs aberrantes)
# boxplot (dcomp[,2:ncol(dcomp)])
# ou ajout des genres

# Si on a sauvegardé et nettoyé les données, on reprend ici à partir du fichier sauvegardé
# dcomp <- read.csv2 ("rythma.ALL.aggreg.csv")
# rownames (dcomp) <- dcomp$Group.1

## ACP : analyse en composantes principales

## ACP avec FactoMineR
# tuto : http://factominer.free.fr/classical-methods/analyse-en-composantes-principales.html

# Penser à installer (une fois) le package !
# install.packages("FactoMineR")
# charger le package
library(FactoMineR)

# choisir les bonnes colonnes
# ici dcomp[,2:ncol(dcomp)] = de la 2e col, à la dernière
# si les valeurs sont écrasées et illisibles les unes sur les autres
# il suffit d'augmenter la résolution quand on exporte comme image
res.pca <- PCA(dcomp[,2:ncol(dcomp)], scale.unit=TRUE, ncp=6, graph=T)

# Ne pas hésiter à se débarasser des valeurs extremes faussantes
# dcomp <- subset(dcomp, rownames(dcomp) != "Samorost3")
# dcomp <- subset(dcomp, rownames(dcomp) != "EuroTruck")
# dcomp <- subset(dcomp, rownames(dcomp) != "Shardlight")

# si on veut intégrer les genres, avec une couleur
# il faut les avoir placé sur la première colonne : quali.sup =1
# ici analyse sur les variables en colonne 2 à 9
res.pca <- PCA(dcomp[,2:9], scale.unit=TRUE, ncp=5, graph=T, quali.sup =1)
plot.PCA(res.pca, axes=c(1, 2), choix="ind", habillage=1, cex = 3)


# Autre méthode pour ACP
## tuto : http://bioinfo-fr.net/lanalyse-en-composantes-principales-avec-r
## ne fonctionne pas toujours bien : échelles trop différentes entre variables quanti ? 
## alors que FactorMineR permet auto-scale
## fonctionne sur sous-genres uniformes (ex. fps)
## bien sélectionner les var. (sortir TpMoyEntreAppuis ?)
## puisqu'on ne retient que les deux premières composantes principales qui explique le max de variabilité
## on peut choisir de travailler uniquement clavier par ex.
pca <- prcomp(dcomp[,c(2:ncol(dcomp))])
pca$rotation # donne la composition des PC "principal components" PC1 & PC2
pca$sdev # donne fraction d'info. contenue dans chaque composante
100*pca$sdev^2 / sum (pca$sdev^2) # % de la variance pour chaque PC
sum(100*(pca$sdev^2)[1:2]/sum(pca$sdev^2)) # variance totale de PC1+PC2
plot (pca)
plot(pca$x[,1:2], col = dcomp[,1])
plot(pca$x[,1:2], pch ="")
text(pca$x[,1:2], labels = dcomp[,1])
biplot(pca)


## ACM avec FactoMiner
library(FactoMineR)
# Passer du quanti au quali


## Regroupement des Clusters sous-forme d'arbres
## Toujours avec FactoMineR
## Suppose de passer en var. quali
res.mca <- MCA(dcomp, ncp=10, quanti.sup = c(2:8), graph=FALSE)
## On clique sur l'arbre pour engendrer la carte auto des clusters
## Plus vers la droite, plus c'est détaillé
res.hcpc <- HCPC(res.mca)
