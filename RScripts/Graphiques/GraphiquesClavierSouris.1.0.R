# SORTIES GRAPHIQUES
# CLAVIER ET SOURIS

graph.claviersouris <- function (d.K,d.M,infobaz) {
  d.Kdown <- subset (d.K, K.EVENEMENT == "Key Down")
  d.Mc <- subset (d.M, M.EVENEMENT == "mouse 1 down" | M.EVENEMENT == "mouse 2 down")
  densK <- density (d.Kdown$K.TEMPS, bw = 10)
  densM <- density (d.Mc$M.TEMPS, bw = 10)
  yrange <- c (0,max (densM$y,densK$y))
  xrange <- c (min (d.Kdown$K.TEMPS,d.Mc$M.TEMPS),max (d.Kdown$K.TEMPS,d.Mc$M.TEMPS))
  
  #plotKM <- graphiques.density(d.Kdown,K.TEMPS,"red",
  #                   "Frequence des appuis clavier/souris",infobaz, "",
  #                   "Temps (s)","Appuis",save = FALSE)
    
  #plotKM <- plotKM + geom_density (data=d.Mc,aes(M.TEMPS), kernel = "gaussian", bw = 10,linetype = 2, size = 2, color = "blue")
  
  #ggsave(filename = paste (infobaz,".KM10",".png", sep =""), width = 15, height = 7)
  
  png (filename = paste (infobaz,".KM10",".png", sep =""), width = 1500, height = 700)
  plot(x=xrange, y= yrange,
       type="n",
       xlab="Temps (s)",
       ylab="Densité des appuis",
       main = paste (infobaz,"\n","Appuis clavier/souris (val. absolue, bw = 10)")
  )
  points (density(d.Kdown$K.TEMPS, bw=10), type ="l", lwd=3, col = "red")
  points (density(d.Mc$M.TEMPS, bw=10), type ="l", lwd=3, lty = 2, col = "blue")
  legend("topright", inset=.01, c("Clavier","Souris"),
         lwd=c(2,2), lty=c(1, 2), col=c("red", "blue"))
  dev.off()
}
  