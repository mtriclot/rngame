stick.mouvement.vect <- function(stickData){
  difX <- stickData$X[2:length(stickData$X)] - stickData$X[1:length(stickData$X)-1]
  difY <- stickData$Y[2:length(stickData$Y)] - stickData$Y[1:length(stickData$Y)-1]
  return(sqrt (difX^2 +difY^2))
}
