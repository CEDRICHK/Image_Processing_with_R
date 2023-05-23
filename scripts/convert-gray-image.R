library(EBImage)

# Ouvrir l'image
im <- readImage("./images/parrot.png")

# Convertir en niveaux de gris
im_g <- channel(im, "gray")

# Afficher l'image en niveaux de gris
display(im_g)
