pad.dpad.analyse <- function(dpadData){
  
  # on tronque le data frame jusqu'a ce que le dernier element soit un 0: un Up
  while(dpadData$P.VALEUR[nrow(dpadData)] != 0){
    dpadData <-dpadData[-nrow(dpadData),]
  }
  
  dpadAxis <- data.table(bouton=factor("Up"),event=factor("Down"),time=dpadData$P.TEMPS)
  
  # on recode les appuis up et down
  dpadAxis$event <- as.character(dpadAxis$event)
  dpadAxis$event[dpadData$P.VALEUR == 0] = "Up"
  dpadAxis$event <- as.factor(dpadAxis$event)
  
  # on supprime tout les down consecutif on ne garde que le premier down
  # les down consecutif sont dut a un changement de direction sur le dpad sans relachement intermediare
  

  # which est bien plus rapide que grep et instancier isDown rend le tout encore plus rapide
  isDown<-dpadAxis$event == "Down"
  posDown <-which(isDown)
  dupDown <- which(isDown[posDown+1])
  # sans le +1 on garde que le dernier down
  dupDown <- posDown[dupDown] + 1
  
  if (length(dupDown) != 0){
    # on empute les deux data frame de leur down duplique 
    # car on se sert du second plus loin il est important qu'ils aient la meme longeur
    dpadData <- dpadData[-dupDown,]
    dpadAxis <- dpadAxis[-dupDown,]
  }
  

  
  # on teste si les donnees sont traitable par l'algo actuelle si non
  # on leve une erreur, on sauvegarde des donn?es pour pouvoir regarder ?a directement et on export ce qui pourrais ?tre utile
  if(length(dpadAxis$event[dpadAxis$event == "Up"]) !=length(dpadAxis$event[dpadAxis$event == "Down"])){
    dpadData <<- dpadData
    dpadAxis <<- dpadAxis
    write.csv2(cbind(dpadAxis,dpadData),"damagedDpadData.csv")
    stop("Donn?e du Dpad trop endomager pour le retraitement actuelle, ?criture de donn?e de debug. \nVeuillez transmettre l'enregistrement contenant les ab?ration en cr?ant une issue ici : \nhttps://github.com/GamesRythmAnalysis/RnGameDataExploitation/issues")
  }
  
  # on recode les valeur pris par le dpad comme des boutton diff?rent: 1 = Left, 0.875 left-down,0.75 = down etc... 
  dpadAxis$bouton <- as.character(dpadAxis$bouton)
  
  value <- seq(1,0.125,by=-0.125)
  mouvement <- c("Left","Left-Down","Down","Right","Right-Up","Up","Up-Left")  
  
  # on decode les differente actions comme on as une alternance parfaite de up et de down cette methode marche
  for (i in 1:8){
    pos <- which(dpadData$P.VALEUR==value[i])
    dpadAxis$bouton[pos] <- mouvement[i]
    dpadAxis$bouton[pos+1] <- mouvement[i]
  }
  
  dpadAxis$bouton <- as.factor(dpadAxis$bouton)
  
  down.time <- dpadAxis$time[dpadAxis$event == "Down"]
  bouton <- dpadAxis$bouton[dpadAxis$event == "Down"]
  durApp <- filter (group_by(dpadAxis, bouton), event == "Up")$time - filter (group_by(dpadAxis, bouton), event == "Down")$time
  
  return( data.table(bouton,down.time,durApp))
  
}
