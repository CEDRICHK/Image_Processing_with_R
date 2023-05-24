library(EBImage)

# Charger l'image
im <- readImage("./images/parrot.png")

# Afficher l'image avec l'ellipse
display(im, method = "raster")

# Ecrire un texte
text(x = 10, y = 5, label = "Parrots", adj = c(0,1), col = "orange", cex = 2)
