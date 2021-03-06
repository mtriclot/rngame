
#==#==#==#==#

# Fonction souris.graphiques : Cr�er les diff�rent 

# Return : rien

#==#==#==#==#

souris.graphiques <- function (clickData,
                               scrollData,
                               moveData,
                               duree,
                               infobaz,
                               recentrer) {
  graphiques.density(
    clickData,
    down.time,
    "blue",
    "Frequence des appuis souris",
    infobaz,
    paste (infobaz, ".M10", ".png", sep = ""),
    "Temps (s)",
    "Appuis"
  )
  
  # Compression en un seul format de donee pour le graphique
  clickScrollData <-
    data.frame(
      down.time = scrollData$M.TEMPS,
      duration = numeric(length(scrollData$M.TEMPS)),
      MouseClick = scrollData$M.EVENEMENT
    )
  clickScrollData <- rbind(clickData, clickScrollData)
  
  graphiques.stack(
    clickScrollData,
    down.time,
    MouseClick,
    duree * 3,
    "Frequence des click | binwidth variable",
    infobaz,
    "MouseClick",
    paste (infobaz, ".MF", ".png", sep = ""),
    "Temps (s)",
    "Appuis"
  )
  
  
  if (recentrer) {
    dataSample <-
      moveData[sample(nrow(moveData), (nrow(moveData) / 10)), ]
    
    graphiques.heatmap(
      dataSample,-M.XPOS,-M.YPOS,
      paste(infobaz, "\n", "Mouvement Souris"),
      paste (infobaz, ".M.map", ".png", sep = "")
    )
  }
}
