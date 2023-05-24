library(EBImage)

# Ouvrir l'image
im <- readImage("./images/parrot.png")

# Convertir en niveaux de gris
im_g <- channel(im, "gray")

# Appliquer la transformation de puissance
im_law <- im_g ^ 0.6

grob_im <- rasterGrob(im_g, interpolate = FALSE)
grob_im_law <- rasterGrob(im_law, interpolate = FALSE)

# Afficher l'image transformée
grid.arrange(grob_im, grob_im_law, ncol = 2)
