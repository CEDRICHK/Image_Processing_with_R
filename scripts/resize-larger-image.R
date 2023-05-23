library(EBImage)

# Ouvrir l'image
im <- readImage("./images/clock.jpg")

# Afficher la largeur et la hauteur de l'image
width <- dim(im)[2]
height <- dim(im)[1]
print(width)
print(height)

# Afficher l'image
plot(im)

# Redimensionner l'image
im_large <- resize(im, width * 5, height * 5, filter = "bilinear")
