bouton.graphique <- function(infobaz,
                             nbTouchesFreq,
                             duree,
                             boutonResult)
{
  graphiques.density(
    boutonResult,
    down.time,
    "black",
    paste (infobaz, "\n", "Densite des appuis pad"),
    "",
    paste (infobaz, ".P10", ".png", sep = ""),
    "Temps (s)",
    "Appuis"
  )
  
  # Decomposition densite par touches (sur touches freq.)
  # Pas plus de 9 touches freq. pour plage couleur
  touchesFreq <-
    sort (table (boutonResult$bouton), decreasing = TRUE)
  ifelse (
    nbTouchesFreq < 10,
    nomTouchesFreq <- rownames (touchesFreq)[1:nbTouchesFreq],
    nomTouchesFreq <- rownames (touchesFreq)[1:9]
  )
  timingappui2 <- subset(boutonResult, bouton %in% nomTouchesFreq)
  
  graphiques.stack(
    timingappui2,
    down.time,
    bouton,
    duree * 3,
    "Frequence des appuis pad (touches frequentes) | binwidth variable",
    infobaz,
    "Touche",
    paste (infobaz, ".TCHVAR", ".png", sep = ""),
    "Temps (s)",
    "Appuis"
  )
  
  
  vizTouches <- as.data.frame(touchesFreq)
  names(vizTouches) <- c ("bouton", "freq")
  vizTouches <- subset(vizTouches, bouton %in% nomTouchesFreq)
  
  graphiques.treemap(
    na.omit(vizTouches),
    freq,
    bouton,
    bouton,
    "Frequence des appuis pad (touches frequentes)",
    infobaz,
    paste (infobaz, ".PADTCHFREQ", ".png", sep = "")
  )
  
  durtouches <- boutonResult %>%
    group_by(bouton) %>%
    summarise(dureemoy = mean(durApp)) %>%
    filter (bouton %in% nomTouchesFreq)
  
  graphiques.treemap(
    na.omit(durtouches),
    dureemoy,
    bouton,
    bouton,
    "Duree moyenne des appuis pad (touches frequentes)",
    infobaz,
    paste (infobaz, ".PADTCHDUR", ".png", sep = "")
  )
  
  totaldur <- boutonResult %>%
    group_by(bouton) %>%
    summarise(dureemoy = sum(durApp)) %>%
    filter (bouton %in% nomTouchesFreq)
  
  graphiques.treemap(
    na.omit(totaldur),
    dureemoy,
    bouton,
    bouton,
    "Duree totale des appuis pad (touches frequentes)",
    infobaz,
    paste (infobaz, ".PADTCHDURTOT", ".png", sep = "")
  )
  
}