pad.stick.analyse <- function(stickData){
  ## STICK
  # distintguer Stick gauche (Axe Y, Axe X) / Stick (Rotation Y, Rotation X)
  # sous linux :
  
  isLR <- grepl ("r", stickData$P.TOUCHE, ignore.case=TRUE)
  stickG <- stickData[!isLR,]
  stickD <- stickData[isLR,]
  
  stickG <- stick.clean(stickG)
  
  stickD <- stick.clean(stickD)
  
  mvG <- stick.mouvement.vect(stickG)
  mvD <- stick.mouvement.vect(stickD)
  
  return(list(stickG,stickD,mvG,mvD))
}
