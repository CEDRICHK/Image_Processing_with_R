library(EBImage)

# Ouvrir l'image
im <- readImage("./images/parrot.png")

# rotation de l'image
im_rotated <- rotate(im, angle = 30)

# Afficher l'image pivotée
display(im_rotated)
