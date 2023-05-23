library(EBImage)
library(gridExtra)

# Charger les images et les normaliser
im1 <- readImage("./images/messi.jpg") 
im2 <- readImage("./images/ronaldo.jpg")

# Créer la figure avec les sous-graphiques
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 5, width=unit(1, "inches"), 
                                           height=unit(1, "inches"))))

# Parcourir les valeurs alpha et afficher les images combinées
i <- 1
for (alpha in seq(0, 1, length.out = 20)) {
  vplayout <- viewport(layout.pos.row = ceiling(i / 5), layout.pos.col = (i - 1) %% 5 + 1)
  pushViewport(vplayout)
  
  # Combinaison des images avec le facteur alpha
  combined <- (1 - alpha) * im1 + alpha * im2
  
  # Afficher l'image combinée
  grid.raster(as.raster(combined))
  
  popViewport()
  i <- i + 1
}

# Ajuster les espacements entre les sous-graphiques
grid.arrange(nrow = 1, heights = unit(1, "npc") - unit(0.05, "inch"), 
             widths = unit(1, "npc") - unit(0.05, "inch"))