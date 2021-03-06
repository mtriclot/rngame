
#==#==#==#==#

# Fonction click.rythm : recupere la duree des click pour un input choisi

# Return : un data frame :
# - down.time: le moment ou le l'action a commencer
# - duration: la duree de l'action
# - MouseClick: le type d'action

#==#==#==#==#

click.rythm <- function(click, data) {
  clickUp <- paste(click, " up", sep = "")
  clickDown <- paste(click, " down", sep = "")
  clickList <- subset (data,
                       M.EVENEMENT == clickDown |M.EVENEMENT == clickUp)
  
  l <- nrow(clickList)
  
  down.time = numeric(l)
  duration = numeric(l)
  k <- 1
  if (l>0){
    for (i in 1:nrow(clickList)) {
      
      #si on trouve l'evenement down on sauvegarde sont temps si il y as 2 down de suite on garde le nouveau
      if (clickList$M.EVENEMENT[i] == clickDown) {
        down.time[k] <- clickList$M.TEMPS[i]
      }
      else {
        if (down.time[k] == 0){
          #si il n'y as pas de down avant le up on set les variable a NA
          duration[k] <- NA
          down.time[k] <- NA
        }else{
          duration[k] <- clickList$M.TEMPS[i] - down.time[k]
        }
        
        k <- k + 1
      }
    }
  }
  ifelse (length(down.time),
          f <- factor(click),
          f <- factor())
  
  results <- data.table(down.time, duration, f)
  names(results) <- c("down.time", "duration", "MouseClick")
  return(results[down.time != 0, ])
  
}
