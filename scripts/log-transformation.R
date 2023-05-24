library(EBImage)

# Ouvrir l'image
im <- readImage("./images/parrot.png")

# Convertir en niveaux de gris
im_g <- channel(im, "gray")

# Appliquer la transformation logarithmique
im_log <- log(1+im_g)

grob_im <- rasterGrob(im_g, interpolate = FALSE)
grob_im_log <- rasterGrob(im_log, interpolate = FALSE)

# Afficher l'image transformée
grid.arrange(grob_im, grob_im_log, ncol = 2)
