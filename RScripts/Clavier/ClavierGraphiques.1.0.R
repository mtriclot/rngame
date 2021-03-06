
#==#==#==#==#

# Fonction clavier.graphiques : Cr�er les diff�rent graphiques en sortie des analyses de clavier

# Return : rien

#==#==#==#==#

clavier.graphiques <- function (data,
                                keyResult,
                                keyboardRythm,
                                touchesFreq,
                                infobaz)
{
  graphiques.density(
    keyboardRythm,
    down.time,
    "red",
    "Frequence des appuis clavier",
    infobaz,
    paste (infobaz, ".K10", ".png", sep = ""),
    "Temps (s)",
    "Appuis"
  )
  
  # Decomposition densite par touches (sur touches freq.)
  # Pas plus de 9 touches freq. pour plage couleur
  if (keyResult$K.NbTouchesFreq > 1) {
    ifelse (
      keyResult$K.NbTouchesFreq < 10,
      nomTouchesFreq <-
        rownames (touchesFreq)[1:keyResult$K.NbTouchesFreq],
      nomTouchesFreq <- rownames (touchesFreq)[1:9]
    )
    
    timingappui2 <-
      subset(keyboardRythm, touche %in% nomTouchesFreq)
    
    # choisir des seuils de densite pour le binwidth de geom_area
    # le choix de K.DuM a l'air d'un bon compromis
    
    graphiques.stack(
      timingappui2,
      down.time,
      touche,
      keyResult$K.DuM * 3,
      "Frequence des appuis clavier (touches frequentes) | binwidth variable",
      infobaz,
      "Touche",
      paste (infobaz, ".TCHVAR", ".png", sep = ""),
      "Temps (s)",
      "Appuis"
    )
    
    # Visualisations : densite relative des appuis (touches les plus frequentes) sur la duree de la session
    vizTouches <- as.data.frame(touchesFreq)
    names(vizTouches) <- c ("touche", "freq")
    vizTouches <- subset(vizTouches, touche %in% nomTouchesFreq)
    
    graphiques.treemap(
      na.omit(vizTouches),
      freq,
      touche,
      touche,
      "Frequence des appuis clavier (touches frequentes)",
      infobaz,
      paste (infobaz, ".TCHFREQ", ".png", sep = "")
    )
    
    durtouches <- keyboardRythm %>%
      group_by(touche) %>%
      summarise(dureemoy = mean(duration)) %>%
      filter (touche %in% nomTouchesFreq)
    
    graphiques.treemap(
      na.omit(durtouches),
      dureemoy,
      touche,
      touche,
      "Duree moyenne d'appui sur les touches les plus frequentes",
      infobaz,
      paste (infobaz, ".TCHDUR", ".png", sep = "")
    )
    
    totaldur <- keyboardRythm %>%
      group_by(touche) %>%
      summarise(dureemoy = sum(duration)) %>%
      filter (touche %in% nomTouchesFreq)
    
    graphiques.treemap(
      na.omit(totaldur),
      dureemoy,
      touche,
      touche,
      "Duree totale d'appui sur les touches les plus frequentes",
      infobaz,
      paste (infobaz, ".TCHDURTOT", ".png", sep = "")
    )
    
  }
}