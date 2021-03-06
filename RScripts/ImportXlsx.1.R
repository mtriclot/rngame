## Import Nouveau Format Fichier .xlxs

# setwd("~/Documents/Projets R/RnGameDataExploitation-developpement/Data")


ImportOldXlsx <- function (nomfichier) {  # ou nomfichier est du type "2014.02.16.MT.Doom.s1"
  #Creer les noms de fichiers
  unzip (nomfichier)
  tmp <- substr (nomfichier, 1, nchar (nomfichier)-4)
  
  fichiersouris <- paste (tmp,".M",".csv",sep="")
  fichierclavier <- paste (tmp,".K",".csv",sep="")
  fichierpad <- paste (tmp,".P",".csv",sep="")
  
  # probleme certains fichiers dans les .zip ont un " " avant le nom ...
  tmp <- paste ("",tmp)
  fichiersouris2 <- paste (tmp,".M",".csv",sep="")
  fichierclavier2 <- paste (tmp,".K",".csv",sep="")
  fichierpad2 <- paste (tmp,".P",".csv",sep="")
  
  #Recuperer les donnees (faire un check d'existence ? pour ne pas engendrer d'erreurs)
  # Export en variable globale <<-
  testf <- file.access(c(fichiersouris,fichiersouris2,
                         fichierclavier,fichierclavier2,
                         fichierpad,fichierpad2))
  
  if (testf[1] == 0) {
    d.M <<- read.csv(fichiersouris, dec=".")
    names (d.M) <<- c("M.EVENEMENT", "M.XPOS", "M.YPOS", "M.VITESSE", "M.ANGLE", "M.TEMPS")
    d.M$M.EVENEMENT <<- as.character (d.M$M.EVENEMENT)
    d.M$M.EVENEMENT[d.M$M.EVENEMENT == "mouse left down"] <<- "mouse 1 down"
    d.M$M.EVENEMENT[d.M$M.EVENEMENT == "mouse right down"] <<- "mouse 2 down"
    dummydata <- d.M
    dummydata <- cbind (index = 1:nrow(dummydata), dummydata)
    index1 <- filter (dummydata, M.EVENEMENT == "mouse 1 down")$index
    index2 <- filter (dummydata, M.EVENEMENT == "mouse 2 down")$index
    if (length (index1) > 0) {
      mouseup1 <- data.frame(index = index1+0.1, M.EVENEMENT = "mouse 1 up",
                             M.XPOS = NA, M.YPOS = NA, M.VITESSE = NA, M.ANGLE = NA, M.TEMPS = NA)  
      dummydata <- rbind (dummydata,mouseup1)
    }
    if (length (index2) > 0) {
      mouseup2 <- data.frame(index = index2+0.1, M.EVENEMENT = "mouse 2 up",
                             M.XPOS = NA, M.YPOS = NA, M.VITESSE = NA, M.ANGLE = NA, M.TEMPS = NA)
      dummydata <- rbind (dummydata,mouseup2)
    }
    dummydata <- arrange (dummydata, index)
    dummydata <- dummydata [,-1]
    d.M <<- dummydata
    if (length(d.M$M.EVENEMENT) < 5) {
      rm (d.M,envir = .GlobalEnv)
    }
  }
  
  if (testf[2] == 0) {
    d.M <<- read.csv(fichiersouris2, dec=".")
    names (d.M) <<- c("M.EVENEMENT", "M.XPOS", "M.YPOS", "M.VITESSE", "M.ANGLE", "M.TEMPS")
    d.M$M.EVENEMENT <<- as.character (d.M$M.EVENEMENT)
    d.M$M.EVENEMENT[d.M$M.EVENEMENT == "mouse left down"] <<- "mouse 1 down"
    d.M$M.EVENEMENT[d.M$M.EVENEMENT == "mouse right down"] <<- "mouse 2 down"
    dummydata <- d.M
    dummydata <- cbind (index = 1:nrow(dummydata), dummydata)
    index1 <- filter (dummydata, M.EVENEMENT == "mouse 1 down")$index
    index2 <- filter (dummydata, M.EVENEMENT == "mouse 2 down")$index
    if (length (index1) > 0) {
      mouseup1 <- data.frame(index = index1+0.1, M.EVENEMENT = "mouse 1 up",
                             M.XPOS = NA, M.YPOS = NA, M.VITESSE = NA, M.ANGLE = NA, M.TEMPS = NA)  
      dummydata <- rbind (dummydata,mouseup1)
    }
    if (length (index2) > 0) {
      mouseup2 <- data.frame(index = index2+0.1, M.EVENEMENT = "mouse 2 up",
                             M.XPOS = NA, M.YPOS = NA, M.VITESSE = NA, M.ANGLE = NA, M.TEMPS = NA)
      dummydata <- rbind (dummydata,mouseup2)
    }
    dummydata <- arrange (dummydata, index)
    dummydata <- dummydata [,-1]
    d.M <<- dummydata
    if (length(d.M$M.EVENEMENT) < 5) {
      rm (d.M,envir = .GlobalEnv)
    }
  }
  
  if (testf[3] == 0) {d.K <<- read.csv(fichierclavier, dec=".")
                      names (d.K) <<- c("K.EVENEMENT","K.TOUCHE","K.TEMPS")
                      d.K$K.EVENEMENT <<- as.character (d.K$K.EVENEMENT)
                      d.K$K.EVENEMENT[d.K$K.EVENEMENT == "key down"] <<- "Key Down"
                      if (length(d.K$K.EVENEMENT) < 5) {
                        rm (d.K,envir = .GlobalEnv)
                      } 
  }
  if (testf[4] == 0) {d.K <<- read.csv(fichierclavier2, dec=".")
  names (d.K) <<- c("K.EVENEMENT","K.TOUCHE","K.TEMPS")
  d.K$K.EVENEMENT <<- as.character (d.K$K.EVENEMENT)
  d.K$K.EVENEMENT[d.K$K.EVENEMENT == "key down"] <<- "Key Down"
  if (length(d.K$K.EVENEMENT) < 5) {
    rm (d.K,envir = .GlobalEnv)
  } 
  }
  if (testf[5] == 0) {d.P <<- read.csv(fichierpad, dec=".")
                      names (d.P) <<- c("P.TEMPS","P.STICK.G.HORIZ","P.STICK.G.VERTI","P.GACHETTES","P.STICK.D.VERTI","P.STICK.D.HORIZ",
                                        "P.A","P.B","P.X","P.Y","P.LB","P.RB","P.SELECT","P.START","P.CLICSTICKG","P.CLICSTICKD",
                                        "P.DPAD")
                      if (mean(d.P$P.TEMPS) == 0) {
                        rm (d.P,envir = .GlobalEnv)
                      }
  }
  if (testf[6] == 0) {d.P <<- read.csv(fichierpad2, dec=".")
  names (d.P) <<- c("P.TEMPS","P.STICK.G.HORIZ","P.STICK.G.VERTI","P.GACHETTES","P.STICK.D.VERTI","P.STICK.D.HORIZ",
                    "P.A","P.B","P.X","P.Y","P.LB","P.RB","P.SELECT","P.START","P.CLICSTICKG","P.CLICSTICKD",
                    "P.DPAD")
  if (mean(d.P$P.TEMPS) == 0) {
    rm (d.P,envir = .GlobalEnv)
  }
  }
  
}