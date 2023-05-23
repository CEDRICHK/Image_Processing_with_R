library(EBImage)

# Ouvrir l'image
im <- readImage("./images/victoria_memorial.png")

# Afficher la largeur et la hauteur de l'image
width <- dim(im)[2]
height <- dim(im)[1]
print(width)
print(height)

# Afficher l'image
display(im)

# Redimensionner l'image
im_small <- resize(im, width / 5, height / 5)
