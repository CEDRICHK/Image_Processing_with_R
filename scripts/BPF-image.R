# Chargement du package
library(imager)

# Ouverture de l'image
im <- load.image("./images/tigers.jpeg")

# Application du flou gaussien avec deux valeurs de sigma différentes
im_blurred1 <- isoblur(im, sigma = 1)
im_blurred2 <- isoblur(im, sigma = 2)

# Création du filtre passe-bande en soustrayant les deux images flouées
DoG_filter <- im_blurred2 - im_blurred1

# Affichage du filtre
plot(DoG_filter)
