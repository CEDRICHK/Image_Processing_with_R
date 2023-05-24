library(EBImage)

# Ouvrir l'image
im <- readImage("./images/parrot.png")

# Création de la matrice 3x2
m = matrix(c(1, -.5, 128, 0, 1, 0), nrow=3, ncol=2)

# Application de la transformation affine 
im_affine <- affine(im, m)

# Afficher l'image inversée
display(im_affine)
