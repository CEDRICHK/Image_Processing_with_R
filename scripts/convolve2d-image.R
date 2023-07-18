library(EBImage)

# Chargement de l'image en niveaux de gris
im <- readImage('./images/cameraman.jpg')

# Conversion de l'image en niveaux de gris
im_gray <- channel(im, "gray")

# Affichage de la valeur maximale des pixels et des dimensions de l'image
print(max(im_gray))
print(dim(im_gray))

# Définition des noyaux de flou et de détection de contours
blur_box_kernel <- matrix(1/9, nrow = 3, ncol = 3)
edge_laplace_kernel <- matrix(c(0, 1, 0, 1, -4, 1, 0, 1, 0), nrow = 3, ncol = 3, byrow = TRUE)

# Application du flou et de la détection de contours
im_blurred <- filter2(im_gray, blur_box_kernel)
im_edges <- filter2(im_gray, edge_laplace_kernel)

# Affichage des images
par(mfrow = c(1, 3), mar = rep(0, 4))
plot(as.raster(im_gray), main = "Original Image", col = gray.colors(256))
plot(as.raster(im_blurred), main = "Box Blur", col = gray.colors(256))
plot(as.raster(im_edges), main = "Laplace Edge Detection", col = gray.colors(256))

