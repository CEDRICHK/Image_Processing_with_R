library(EBImage)

# Read the images
im1 <- readImage("./images/parrot.png")
im2 <- readImage("./images/hill.png")

# Convert images to the same color mode
width <- dim(im1)[1]
height <- dim(im1)[2]
im_rgba <- Image(dim = c(width, height, 4))
im_rgba[, , 1:3] <- im1 # Copier les canaux R, G et B de l'image d'origine
im_rgba[, , 4] <- 255 # Définir le canal alpha à 255 (opacité maximale)
colorMode(im_rgba) <- 2

im2 <- resize(im2, width, height) # Resize to the same dimensions

# Set the alpha channel for blending
alpha <- 0.5

# Blend the images
im <- im_rgba * (1 - alpha) + im2 * alpha

# Display the blended image
display(im)