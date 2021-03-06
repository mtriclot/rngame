
#==#==#==#==#

# Fonction graphiques.stack : cr�e un graphique de type heatmap via geom_density2d pouvant incorporer les points aux position des valeurs

# Return : le plot cr�er via ggplot

#==#==#==#==#

graphiques.heatmap<- function(data,aes.x,aes.y,title,save.file,xlab=deparse(substitute(aes.x)),ylab=deparse(substitute(aes.y)),save=TRUE,width = 150,height = 125){
  
  attach(data)
  
  plot <- ggplot (mapping = aes (x=aes.x, y=aes.y)) +
    stat_density2d(aes(alpha = ..level.., fill=..level..), bins = 15, geom = "polygon")+
    xlab(xlab)+
    ylab(ylab)+
    scale_alpha_continuous(guide = FALSE)+
    scale_fill_gradient(low = "green", high = "red") +
    geom_density2d (colour="black", bins = 15, alpha = 0.25) + 
    ggtitle(title)
  
  
  if (save){
    ggsave (file = save.file,width = width, height = height, units = "mm")
  }
  
  detach(data)
  return(plot)
}