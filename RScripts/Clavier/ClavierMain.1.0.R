clavier.main <- function (data,infobaz,graph) { #possibilite de repasser valfreq pour touches freq. en argument
  
  keyResult <- clavier.key.analyse(data)
  
  if (graph == TRUE) {
    clavier.graphiques(data,keyResult[[1]],keyResult[[2]],keyResult[[3]],infobaz)
  }
  
  return(keyResult[[1]])
  
}