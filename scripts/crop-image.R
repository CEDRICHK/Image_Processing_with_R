library(EBImage)

# Ouvrir l'image
im <- readImage("./images/parrot.png")

# Définir les coordonnées du rectangle de recadrage
x1 <- 175
y1 <- 75
x2 <- 320
y2 <- 200

# Recadrer l'image
im_cropped <- im[x1:x2, y1:y2, , drop=FALSE]

# Afficher l'image recadrée
plot(im_cropped)
