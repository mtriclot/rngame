
#==#==#==#==#

# Fonction souris.decentrage : annule le rencentrage des mouvement de la souris par les jeux

# Return : les nouvelles donnee de mouvement de souris avec les mouvements deplies

#==#==#==#==#

souris.decentrage <- function (donneeSouris, infobaz) {
  # On slectionne les valeurs medianne
  xCenter <- median (donneeSouris$M.XPOS)
  yCenter <- median (donneeSouris$M.YPOS)
  
  # On suprime tout ce qui as ete capture hors du jeu avec un seuil arbitraire de 85%
  # qui marche assez bien pour les petite session et devrais aussi bien marcher sur les plus longues
  seuils <- seq(10, 50, by = 10)
  i <- 1
  dataSubset <- subset (
    donneeSouris,
    donneeSouris$M.XPOS < xCenter + seuils[i] &
      donneeSouris$M.XPOS > xCenter - seuils[i]
    &
      donneeSouris$M.YPOS < yCenter + seuils[i] &
      donneeSouris$M.YPOS > yCenter - seuils[i])
  
  while (i < length(seuils) &
         length(dataSubset$M.XPOS) / length(donneeSouris$M.XPOS) < 0.85) {
    
    dataSubset <- subset (
      donneeSouris,
      donneeSouris$M.XPOS < xCenter + seuils[i] &
        donneeSouris$M.XPOS > xCenter - seuils[i]
      &
        donneeSouris$M.YPOS < yCenter + seuils[i] &
        donneeSouris$M.YPOS > yCenter - seuils[i])
    
    i <- i + 1
  }
  
  # On replace tout sur un point zero ...
  # Qui n'est malheureusement jamais le vrai centre
  # Du fait de la derive de la distribution
  dataSubset$M.XPOS <- dataSubset$M.XPOS - xCenter
  dataSubset$M.YPOS <- dataSubset$M.YPOS - yCenter
  
  #on regarde les moment ou le joueur a mis plus de 10 ms a faire un mouvement qui a �t� capt� par le key logger
  #suprenament la medianne du temps mis est au allentour de 2ms donc en coupent a 10ms on coupe plutot bien les mouvements
  
  l <- length(dataSubset$M.TEMPS)
  mvTime <- numeric(l)
  mvTime[-1] <- dataSubset$M.TEMPS[2:l] - dataSubset$M.TEMPS[1:(l-1)]
  mvTime[1] <- 0
  moveEnd <- mvTime > 0.01
  
  Rxpos <- numeric(l + 1)
  Rypos <- numeric(l + 1)
  
  #on recalcule les vecteur en prenant en compte les fin de mouvement des joueurs
  for (i in 1:l) {
    
    if (moveEnd[i]) {
      Rxpos[i + 1] <- dataSubset$M.XPOS[i]
      Rypos[i + 1] <- dataSubset$M.YPOS[i]
    } else{
      
      Rxpos[i + 1] <- Rxpos[i] + dataSubset$M.XPOS[i]
      Rypos[i + 1] <- Rypos[i] + dataSubset$M.YPOS[i]
    }
  }
  
  #on retire de la liste le premier element qui vaut 0
  dataSubset$M.XPOS <- Rxpos[-1]
  dataSubset$M.YPOS <- Rypos[-1]
  
  resultats <-
    data.table(dataSubset$M.XPOS,
               dataSubset$M.YPOS,
               dataSubset$M.TEMPS,
               moveEnd)
  
  names(resultats) <- c("M.XPOS", "M.YPOS", "M.TEMPS", "MoveEnd")
  
  return(resultats)
  
}
