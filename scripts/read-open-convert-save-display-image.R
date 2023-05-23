library(magick)

# Charger l'image originale
image <- image_read("./images/parrot.png")

# Convertir en niveaux de gris
image_g <- image_convert(image, colorspace = "gray")

# Enregistrer l'image convertie en niveaux de gris
image_write(image_g, path = "./images/parrot_gray.png")

# Ouvrir l'image convertie en niveaux de gris
image_opened <- image_read("./images/parrot_gray.png")
image_opened