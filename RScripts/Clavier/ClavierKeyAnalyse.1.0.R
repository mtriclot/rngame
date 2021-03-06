
#==#==#==#==#

# Fonction Clavier.key.analyse : analyse les donn�es des touches clavier

# Return : une list avec :
# - resultats :les resultat obtenus des diff�rents calcul sous la forme d'un data frame
# - keyboardRythm :un data frame du meme format que ceux renvoyes par key.rythm
# - touchesFreq :un tableau des touche frequente trier avec le nombre d'appuis de chaque touche

#==#==#==#==#

clavier.key.analyse <- function(data) {
  
  #r�cup�ration des Rythmes
  keyboardRythm <- lapply(levels(data$K.TOUCHE), key.rythm, data = data)
  keyboardRythm <- do.call("rbind", keyboardRythm)
  
  keyboardRythm <- keyboardRythm[!is.na(keyboardRythm$down.time),]
  
  keyDown<-subset(data,K.EVENEMENT == "Key Down")
  
  # Nombre appuis
  K.NbAppuis <- nrow(keyDown)
  
  tpEntreAppuis <- keyDown$K.TEMPS[-1] - keyDown$K.TEMPS[-K.NbAppuis]
  
  # Touches frequentes
  VALFREQ <- 0.01
  tableTouches <- sort(table(keyDown$K.TOUCHE), decreasing = TRUE)
  touchesFreq <- subset (tableTouches,
                         tableTouches > K.NbAppuis * VALFREQ)
  
  # On ne conserve que la touche la plus frequente
  mostFreq <- subset (keyboardRythm,
                      keyboardRythm$touche == names (touchesFreq[1]))
  
  # Duree secondes, duree minutes activite clavier
  K.DuS <- max (data$K.TEMPS) - min (data$K.TEMPS)
  K.DuM <- K.DuS / 60
  
  # Nombre d'appuis par seconde
  K.NbAppuisS <- K.NbAppuis / K.DuS
  
  # Nombre de touches utilisees
  K.NbTouches <- length(levels(data$K.TOUCHE))
  K.NbTouchesFreq <- length (touchesFreq)
  
  # Temps entre appuis et ecart-type
  K.TpMoyEntreAppuis <- mean (tpEntreAppuis)
  K.TpSDEntreAppuis <- sd (tpEntreAppuis)
  
  # Duree des appuis
  K.TpMoyAppui <- mean (keyboardRythm$duration, na.rm = TRUE)
  K.TpSDAppui <- sd (keyboardRythm$duration, na.rm = TRUE)
  
  # Temps d'activite reel du clavier et % d'activite du clavier
  K.TpsAppui <-  sum(keyboardRythm$duration, na.rm = TRUE) 
  K.PropAct <- K.TpsAppui / K.DuS 
  
  #Donn�e sur la touche la plus fr�qente
  K.ToucheFreq <- mostFreq$touche[1]
  K.PropFreq <- (nrow (mostFreq) / K.NbAppuis) * 100
  K.TpMoyAppuiFreq <- mean (mostFreq$duration, na.rm = TRUE) 
  K.TpSDAppuiFreq <- sd (mostFreq$duration, na.rm = TRUE) 
  
  #K.NbAppuis # Nombre total d'appuis
  #K.DuM # Duree en minute de l'activite clavier
  #K.NbAppuisS # Appuis par seconde
  #K.NbTouches # Nombre de touches utilisees
  #K.NbTouchesFreq # Nombre de touches frequemment utilisees (enlever inf. a valfreq 1%)
  #K.TpMoyEntreAppuis # Temps moyen entre appuis
  #K.TpSDEntreAppuis # Ecart-type
  #K.TpMoyAppui # Duree moyenne d'un appui
  #K.TpSDAppui # Ecart-type duree d'un appui
  #K.TpsAppui # Temps reel d'activite du clavier
  #K.PropAct # pourcentage de temps d'activite du clavier sur la session
  #K.TpMoyAppuiFreq # Duree moyenne d'un appui sur touche la plus frequente
  #K.TpSDAppuiFreq # Ecart-type duree d'un appui sur touche la plus frequente
  
  resultats <- data.table(
    K.DuM,
    K.NbTouches,
    K.NbTouchesFreq,
    K.NbAppuis,
    K.NbAppuisS,
    K.TpMoyEntreAppuis,
    K.TpSDEntreAppuis,
    K.TpMoyAppui,
    K.TpSDAppui,
    K.TpsAppui,
    K.PropAct,
    K.ToucheFreq,
    K.PropFreq,
    K.TpMoyAppuiFreq,
    K.TpSDAppuiFreq
  )
  
  return (list(resultats, keyboardRythm, touchesFreq))
}