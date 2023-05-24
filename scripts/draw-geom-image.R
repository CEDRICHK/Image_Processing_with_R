library(EBImage)

# Charger l'image
im <- readImage("./images/parrot.png")

# Créer un masque pour l'ellipse
im_circle <- drawCircle(im, x = 125, y = 125, 
                        r = 75, col = "white", fill = TRUE)

# Afficher l'image avec l'ellipse
display(im_circle)