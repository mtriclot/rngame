
#==#==#==#==#

# Fonction souris.main : fonction principale appele les fonction d'analyse et de graphique

# Return : un data frame contenant la concatenation des resultats des differente fonctin d'analyse 

#==#==#==#==#

souris.main <- function(data, infobaz, graph) {
  # Analyse des Clicks
  clickResult <- souris.click.analyse(data)
  
  # Analyse du mouvement
  moveResult <- souris.move.analyse(data)
  
  # Creation des graphiques
  if (graph) {
    souris.graphiques(clickResult[[2]],
                      clickResult[[3]],
                      moveResult[[2]],
                      clickResult[[1]]$M.DuM,
                      infobaz,
                      moveResult[[1]]$M.VitTrueXY)
  }
  
  return (cbind(clickResult[[1]], moveResult[[1]]))
  
}