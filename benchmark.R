#=# Fichier pour les benchmaks : test de rapidit� des calculs

## Setup des script

rm(list=ls()) # on vide la memoire de RStudio
setwd("~/Documents/Projets R/RnGameDataExploitation-modularite") #choix du dossier ou se trouve le script Rythma

# Installation (si besoin) et chargement des packages requis
packages <- c("ggplot2", "gridExtra","RColorBrewer","treemapify","dplyr","microbenchmark","data.table")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

# chargement auto de tout les packages (evite q'un package manque a l'appel)
for(package in packages){
  library(package,character.only = T,warn.conflicts = F)
} 

source("RScripts/RythmaFUNZIP5.4.R") #charge la fonction d'analyse

## Setup du benchmark

# Dossier ou sont les donn�es pour le benchmark
BENCHDIR <- "Benchmark"
benchFiles <- list.files(path = BENCHDIR,pattern = ".zip")
l <- length(benchFiles)

# chargement d'une sauvegarde si elle existe sinon cr�ation d'un substitu
if (file.exists("benchmark.csv")){
  
  benchSave <- read.csv2("benchmark.csv",as.is = F)[,-1]
  print("Les test suivant ont �t� import�, vous pouvez les override en re cr�ant un test avec le m�me nom")
  print(levels(benchSave$Name))
} else{
  
  benchSave <- data.frame("Name"=factor(),"File"=factor(),"min"=numeric(),"mean"=numeric(),"max"=numeric(),"sd"=numeric(),"incertitude"=numeric())
}

# Choix du nom du test
testName <- readline( prompt = "nom du test :")

# Benchmark
# duree typique en 5 et 10 min 
bench <- NULL
for (i in 1:l){
  bench <- rbind(bench,microbenchmark(Rythmanalyse(benchFiles[i],graph = FALSE,data.dir=BENCHDIR)))
  levels(bench$expr)[i]<-benchFiles[i]
}

# agr�gation des donn�es pour une forme plus facilement sauvegardable
benchData <- data.frame("Name"=factor(testName),"File"=factor(benchFiles),"min"=numeric(l),"mean"=numeric(l),"max"=numeric(l),"sd"=numeric(l),"incertitude"=numeric(l))


#unit� du temps dans le csv : ms
for (i in 1:l){
  sub <- subset(bench,expr == levels(bench$expr)[i])
  sub$time <- sub$time / 1000000
  benchData$min[i] <- min(sub$time)
  benchData$mean[i] <- mean(sub$time)
  benchData$max[i] <- max(sub$time)
  benchData$sd[i] <- sd(sub$time)
  benchData$incertitude[i] <- benchData$sd[i]/sqrt(length(sub$time -1)) * 1.66
}

# on suprime l'ancien test portant le m�me nom s'il existe apr�s que tout ce soit bien passer puis on �crit
benchSave <- benchSave[benchSave$Name != testName,]
benchSave <- rbind(benchSave,benchData)

write.csv2(benchSave,"benchmark.csv")
