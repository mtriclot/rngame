## Rythmanalyse fonction v.5.4

# Debug
# options(warn=2) # warning as error
# debut <-0
# fin <- "max"
# nomfichier <- "2020.02.27.H.L.SMB.zip"
# setwd("~/Documents/Projets R/RnGameDataExploitation-modularite")
# graph <- TRUE
 
Rythmanalyse <- function (nomfichier, debut = 0, fin = "max", graph = TRUE,data.dir="Data"){ # type : "2014.02.16.MT.Doom.s1.zip"
  
  source("RScripts/ImportScript.R")
  
  import.script()
  
  # on importe les donnees et dezippe les fichiers
  
  setwd(data.dir)
  # inserer un if en fonction de la date pour les anciens xlsx
  # reformater les donnees dans le ImportZip (ex : mouse left  down -> mouse 1 down, etc)
  
  titre <- substr (nomfichier,15,nchar(nomfichier)-4)
  date <- substr (nomfichier,1,10)
  usr <- substr (nomfichier,12,13)
  infobaz <- paste (date,".",usr,".",titre,".(",debut,"-",fin,")",sep ="")
  
  if (as.Date(date, "%Y.%m.%d") <= as.Date("2016.03.22", "%Y.%m.%d")) {
    ImportOldXlsx (nomfichier)
  } else {
    ImportZip (nomfichier, debut, fin)
  }
  
  Rez <- cbind (nomfichier,date,usr,titre) ## Attention a tout sortir au meme format pour traitement en masse
  
  #on cree un dossier par utilisateur/jeux
  setwd("../")
  if (!dir.exists(paste("Resultats/", infobaz, sep = ""))) {
    dir.create(paste("Resultats/", infobaz, sep = ""), recursive = T)
  }
  setwd(paste("Resultats/", infobaz, sep = ""))
  
  # Traitement pour Clavier ET Souris
  if (exists("d.M", environment()) &
      exists ("d.K", environment()) & graph) {
    graph.claviersouris (d.K, d.M, infobaz)
  }
  
  # Traitement pour Clavier seul  
  if (exists("d.K", environment())) {
    
    Rez <- cbind (Rez,clavier.main(d.K,infobaz,graph))
    rm (d.K,envir = .GlobalEnv)
  
  } else {
    resultats <- data.frame(K.DuM=NA,K.NbTouches=NA,K.NbTouchesFreq=NA,
                            K.NbAppuis=NA,K.NbAppuisS=NA,
                            K.TpMoyEntreAppuis=NA,K.TpSDEntreAppuis=NA,
                            K.TpMoyAppui=NA,K.TpSDAppui=NA,
                            K.TpsAppui=NA,K.PropAct=NA,
                            K.ToucheFreq=NA,K.PropFreq=NA,
                            K.TpMoyAppuiFreq=NA,K.TpSDAppuiFreq=NA)
    Rez <- cbind (Rez,resultats)
  }
  
  # Traitement pour Souris seule  
  if (exists("d.M", environment())) {
    Rez <- cbind (Rez,souris.main(d.M,infobaz,graph))
    
    rm (d.M, envir = .GlobalEnv)
  }  else {
    
    resultats <- data.frame(M.DuM=NA,M.NbClics=NA,M.NbCliclsS=NA,
                            M.TpsClickR=NA,M.TpsClickL=NA,
                            M.TpsClickM=NA,M.TpsTotClick=NA,
                            M.MoyTpsClickR=NA,M.SDTpsClickR=NA,
                            M.MoyTpsClickL=NA,M.SDTpsClickL=NA,
                            M.MoyTpsClickM=NA,M.SDTpsClickM=NA,
                            M.LR=NA, M.Scroll=NA,
                            M.TpMoyEntreAppuis=NA,M.TpSDEntreAppuis=NA,
                            M.Vit=NA,M.VitTrueXY=NA)
    Rez <- cbind (Rez,resultats)
    
  }
  
  
  # Traitement pour Pad  
  if (exists("d.P", environment())) {
    Rez <- cbind (Rez,pad.main(d.P,infobaz,graph))
    
    # les plots se font dans la fonction
    rm (d.P, envir = .GlobalEnv)
  } else {
    resultats <- data.frame(
      P.DuM = NA,
      
      P.DurActivite = NA,
      P.PopActivite = NA,
      P.DurApMoy = NA,
      P.DurApSD = NA,
      P.DurApTot = NA,
      P.TpEntreApMoy = NA,
      P.TprEntreApSD = NA,
      
      P.NbBouton = NA,
      P.NbAppuis = NA,
      P.NbAppuisS = NA,
      P.NbBoutonFreq = NA,
      
      P.BoutFreq = NA,
      P.PropFreq = NA,
      P.durApFreqMoy = NA,
      P.durApFreqSD = NA,
      P.TpEntreAppuisFreqMoy = NA,
      P.TpEntreAppuisFreqSD = NA,
      
      P.VitPresGachetteMoy = NA,
      P.VitPresGachetteSD = NA,
      P.VitRelachGachetteMoy = NA,
      P.VitRelachGachetteSD = NA,
      
      P.PropLR = NA,
      P.VitJoyStickL = NA,
      P.VitJoyStickR = NA,
      P.VitJoyStickMoy = NA
    )
    Rez <- cbind (Rez,resultats)
  }
  write.csv(Rez, file = paste(infobaz,".ok.csv", sep=""))
  setwd("../../")
  return (Rez)
}
