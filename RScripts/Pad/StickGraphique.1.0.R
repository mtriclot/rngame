stick.graphique <- function(stickData,title,save.file){
  normaliser <- function (XY) { # fonction pour eliminer deadzone du stick
    if (length(XY) == 0 ){
      return(XY)
    }else {
      return((XY-min(XY))/diff(range(XY)))
    }
  }
  
  ifelse (nrow(stickData)>10000,
          d2sampl <- stickData[sample(nrow(stickData), (nrow(stickData)/10)), ],
          d2sampl<-stickData)
  
  d2sampl[is.na(d2sampl)] <- 0
  d2sampl[d2sampl$X>0,]$X <- normaliser (d2sampl[d2sampl$X>0,]$X)
  d2sampl[d2sampl$X<0,]$X <- - normaliser(abs(d2sampl[d2sampl$X<0,]$X))
  d2sampl[d2sampl$Y>0,]$Y <- normaliser (d2sampl[d2sampl$Y>0,]$Y)
  d2sampl[d2sampl$Y<0,]$Y <- - normaliser (abs(d2sampl[d2sampl$Y<0,]$Y))
  
  quantX<-quantile(d2sampl$X)
  quantY<-quantile(d2sampl$Y)
  
  if (quantX[4]-quantX[2]!=0 & quantY[4]-quantY[2]!=0){
    return(graphiques.heatmap(d2sampl,-X,-Y,title,save.file))
  } else {
    return(NULL)
  }
  
}
