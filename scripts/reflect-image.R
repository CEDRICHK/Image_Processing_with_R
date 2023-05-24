library(EBImage)

# Ouvrir l'image
im <- readImage("./images/parrot.png")

# Inverser horizontalement
im_flipped <- flop(im)

# Afficher l'image inversée
display(im_flipped)
