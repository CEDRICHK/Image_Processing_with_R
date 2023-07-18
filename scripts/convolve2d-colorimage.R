library(EBImage)

# Chargement de l'image en couleur
im <- readImage('./images/tajmahal.jpg')

# Conversion de l'image en niveaux de gris
im_gray <- channel(im, "gray")

# Affichage de la valeur maximale des pixels et des dimensions de l'image en niveaux de gris
print(max(im_gray))
print(dim(im_gray))

# Définition des noyaux de flou et de détection de contours
blur_box_kernel <- matrix(c(-2, -1, 0, -1, 1, 1, 0, 1, 2), nrow = 3, 
                          ncol = 3, byrow = TRUE)
edge_schar_kernel <- matrix(c(-3-3i, 0-10i, 3-3i, -10+0i, 0+0i, 10+0i, -3+3i, 
                                0+10i, 3+3i), nrow = 3, 
                              ncol = 3, byrow = TRUE)

# Application du flou et de la détection de contours sur chaque canal de couleur
im_blurred <- im
for (i in 1:dim(im)[3]) {
  im_blurred[, , i] <- filter2(im[, , i], blur_box_kernel)
}
im_edges <- im
for (i in 1:dim(im)[3]) {
  im_edges[, , i] <- filter2(im[, , i], edge_laplace_kernel)
}

# Affichage des images
par(mfrow = c(1, 3), mar = rep(0, 4))
plot(as.raster(im), main = "Original Image")
plot(as.raster(im_blurred), main = "Emboss kernel")
plot(as.raster(im_edges), main = "Schar Edge Detection")
