
#==#==#==#==#

# Fonction graphiques.stack : cr�e un graphique d'empilement via geom_area position = stack

# Return : le plot cr�er via ggplot

#==#==#==#==#

graphiques.stack<-function(data,aes.x,aes.fill,binwidth,title,subtitle,fill.brewer,save.file,xlab,ylab,save=TRUE,width = 15,height = 7){
  
  attach(data)
  
  plot <- ggplot(data = data, aes(aes.x, fill = aes.fill)) +
    geom_area (stat="bin", binwidth = binwidth, position = "stack", linetype = 1, size = 0.8, colour ="black") +
    xlab (xlab) +
    ylab (ylab) +
    ggtitle (label = title,subtitle = subtitle) +
    scale_fill_brewer(fill.brewer, palette="Set1")+
    theme_classic()
  
  if (save){
    ggsave(filename = save.file , width = width, height = height)
  }
  
  detach(data) 
  return(plot)
  
}