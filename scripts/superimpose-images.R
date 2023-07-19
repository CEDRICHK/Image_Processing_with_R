library(EBImage)

# Read the images
im1 <- readImage("./images/parrot.png")
im2 <- readImage("./images/hill.png")

# Redimensionner l'image 2 pour avoir la même taille que l'image 1
width <- dim(im1)[1]
height <- dim(im1)[2]
im2 <- resize(im2, width, height)

# Convert images to the same color mode
im_rgb <- Image(dim = c(width, height, 3))
im_rgb[, , 1:3] <- im2[1:453,1:340,1:3] # Copier les canaux R, G et B de l'image d'origine
colorMode(im_rgb) <- 2

im_rgb2 <- Image(dim = c(width, height, 3))
im_rgb2[, , 1:3] <- im1[1:453,1:340,1:3] # Copier les canaux R, G et B de l'image d'origine
colorMode(im_rgb2) <- 2

# Multiplier les deux images
result <- im_rgb * im_rgb2

# Afficher le résultat
plot(result)