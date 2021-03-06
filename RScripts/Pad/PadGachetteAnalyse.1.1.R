pad.gachette.analyse <- function(gachData){

  gachResult <- data.frame(bouton = factor(),down.time=numeric() ,durApp=numeric(),vit.pression = numeric(), vit.relache = numeric())
  
  if (nrow (gachData) > 50) {
    
    # est vrai si les donn?e on ?t? prises sur windows
    win <- grepl ("Axe", gachData$P.TOUCHE) 
    
    if (win[1]) {
      # format de donnee sous win :
      # valeur comprise entre -1 et +1
      # valeur positve => gachette gauche
      # valeur negative => gachette droite
      # les donn?e de la gachette droite et gauche sont sym?trique en 0 : 0 => gachette au repos
      
      gachG <- subset (gachData, gachData$P.VALEUR > 0)  
      gachG <- gachG[,3:4]
      gachD <- subset (gachData, gachData$P.VALEUR < 0)
      gachD <- gachD[,3:4]
      
      # permet que les deux gachette ai la meme forme pour les analyse
      gachD$P.VALEUR <- abs(gachD$P.VALEUR)
    } else   {
      gachG <- subset (gachData, gachData$P.TOUCHE == "z")
      gachG <- gachG[,3:4]
      gachG$P.VALEUR <- (gachG$P.VALEUR+1)/2
      
      gachD <- subset (gachData, gachData$P.TOUCHE == "rz")
      gachD <- gachD[,3:4]
      gachD$P.VALEUR <- (gachD$P.VALEUR+1)/2
    }
    
    gachG$P.VALEUR <- (gachG$P.VALEUR%/%0.05)*0.05
    gachD$P.VALEUR <- (gachD$P.VALEUR%/%0.05)*0.05
    
    # On passe la fonction pour gachette gauche et droite 
    
    if (nrow(gachG) > 50){
      gauche <- gachette.pic.detect(gachG)
      gaucheResult <- cbind(bouton = factor("LT"),gachette.rythm(gauche))
      
      gachResult <- rbind(gachResult ,gaucheResult)
      
    }
    
    if (nrow(gachD) > 50){
      droite <- gachette.pic.detect(gachD)
      droiteResult <- cbind(bouton = factor("RT"),gachette.rythm(droite))
      
      gachResult <- rbind(gachResult , droiteResult)
      
    }  
  }
  
  return(gachResult[gachResult$vit.pression != 0 & gachResult$durAp != 0 ,])
}