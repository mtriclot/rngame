
#==#==#==#==#

# Fonction souris.move.analyse : analyse les donnees des mouvement de la souris

# Return : un vecteur avec :
# - resultat: les resultat obtenus des différents calcul sous la forme d'un data frame
# - moveData: les donnees de mouvement retraiter s'il y as eux rencentrage brut sinon

#==#==#==#==#

souris.move.analyse <- function(data) {
  # On determine s'il y a recentrage
  cond1 <- fivenum(data$M.XPOS)[4] - fivenum(data$M.XPOS)[2]
  cond2 <- fivenum(data$M.YPOS)[4] - fivenum(data$M.YPOS)[2]
  
  ifelse (cond1 > 20 & cond2 > 20,
          M.VitTrueXY <- TRUE,
          M.VitTrueXY <- FALSE)
  
  if (M.VitTrueXY) {
    difX <- (data$M.XPOS[2:length(data$M.XPOS)] -
               data$M.XPOS[1:length(data$M.XPOS) - 1])
    difY <- (data$M.YPOS[2:length(data$M.YPOS)] -
               data$M.YPOS[1:length(data$M.YPOS) - 1])
    M.Vit <-
      sum (sqrt (difX ^ 2 + difY ^ 2)) / (max (d.M$M.TEMPS) - min(d.M$M.TEMPS))
    
    moveData <- data.table(data$M.XPOS, data$M.YPOS, data$M.TEMPS)
    names(moveData) <- c("M.XPOS", "M.YPOS", "M.TEMPS")
    
  } else {
    #moveData <- souris.decentrage(data)
    #moveEnd <- moveData$MoveEnd
    #moveData <- moveData[,-4]
    # 
    # distance = numeric(length(moveData$M.XPOS))
    # 
    # #on calcule les distance pour la vitesse donc on ignore les movement de recentrage
    # for (i in 1:(length(moveData$M.XPOS) - 2)) {
    #   if (moveEnd[i + 1]) {
    #     distance[i] <- 0
    #   } else{
    #     distance[i] <-
    #       sqrt((moveData$M.XPOS[i + 1] - moveData$M.XPOS[i]) ^ 2 +
    #              (moveData$M.YPOS[i + 1] - moveData$M.YPOS[i]) ^ 2
    #       )
    #   }
    # }
    # 
    # M.Vit <- sum (distance) / (max (d.M$M.TEMPS) - min(d.M$M.TEMPS))
    M.Vit<-NA
    moveData <- NA
  }
  
  #M.Vit # Moyenne des vitesses instantanes
  #M.VitTrueXY #si la vitesse est calculer a partir des vraies coordonnees ou apres une modification
  
  resultats <- data.table(M.Vit, M.VitTrueXY)
  
  return (list(resultats, moveData))
}