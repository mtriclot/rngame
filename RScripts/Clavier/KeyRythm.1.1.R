
#==#==#==#==#

# Fonction click.rythm : recupere la duree des click pour un input choisi

# Return : un data frame :
# - down.time: le moment ou le l'action a commencer
# - duration: la duree de l'action
# - touche: la touche lier aux donn�e

#==#==#==#==#

key.rythm <- function(key, data) {
  ## Un data frame vide pour recevoir les resultats
  
  data <- subset(data,K.TOUCHE == key)
  l <- nrow(data)
  
  down.time <- numeric(l)
  duration <- numeric(l)
  k <- 1
  
  if (l>0){
    ## On est oblige de passer par une boucle pour parser ligne par ligne
    for (i in 1:l) {
      
      # si l'on rencontre un down, le stocker
      # (ainsi, si l'on rencontre deux down de suite, sans up entre les deux,
      # le premier sera effaee et seul le second comptera)
      if (data$K.EVENEMENT[i] == "Key Down") {
        down.time[k] <- data$K.TEMPS[i]
        
      }  else {
        
        # verifier si l'on a bien eu un down precedemment
        if (down.time[k]==0) {
          duration[k] <- NA
          down.time[k] <- NA
        } else{
          # Calculer la duree entre down et up
          duration[k] <- data$K.TEMPS[i] - down.time[k]
        }
        
        k<-k+1
        
      }
      
    }
    
  }
  ifelse (length(down.time),
          f <- factor(key),
          f <- factor())
  
  results <- data.table(down.time, duration, f)
  
  names (results) <- c ("down.time", "duration", "touche")
  
  return(results[down.time != 0,])
}