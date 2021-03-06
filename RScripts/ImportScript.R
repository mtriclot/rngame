
import.script<-function(){
  
  test<-F
  
  if(exists("Loaded",environment())){
    if (!Loaded){
      test <- TRUE
    }
  } else{
    test<-TRUE
  }
  
  if(test){
    
    sources <- list.files (path = "./RScripts", pattern = ".R",recursive = TRUE,full.names = T)
    blacklist <- c("./RScripts/RythmaFUNZIP5.4.R","./RScripts/ACP.Rythmanalyse.PAD.R","./RScripts/ACP.Rythmanalyse.R","./RScripts/ImportScript.R",
                   list.files (path = "./RScripts/", pattern = "WIP",recursive = TRUE,full.names = T))
    
    for(blackfile in blacklist){
      sources<-sources[sources != blackfile]
    }

    lapply(sources,source)
  }
  
  Loaded<<-T
}
