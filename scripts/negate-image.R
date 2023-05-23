library(EBImage)

# Ouvrir l'image
im <- readImage("./images/parrot.png")

# Inverser les valeurs des pixels
im_t <- max(im) - im

# Afficher l'image inversée
display(im_t)