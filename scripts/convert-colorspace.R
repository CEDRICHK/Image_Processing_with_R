library(magick)
library(gridExtra)

# Charger l'image
image <- image_read("./images/parrot.png")

# Convertir en espace colorimétrique HSV
image_hsv <- image_convert(image, colorspace = "hsv")

# Convertir en niveaux de gris
image_gray <- image_convert(image_hsv, colorspace = "gray")

# Extraire les canaux H, S et V
channel_h <- image_channel(image_hsv, "red")
channel_s <- image_channel(image_hsv, "green")
channel_v <- image_channel(image_hsv, "blue")

# Créer les objets rasterGrob pour les sous-graphiques
grob_h <- rasterGrob(channel_h, interpolate = FALSE)
grob_s <- rasterGrob(channel_s, interpolate = FALSE)
grob_v <- rasterGrob(channel_v, interpolate = FALSE)
grob_gray <- rasterGrob(image_gray, interpolate = FALSE)

# Afficher les sous-graphiques
# Créer les objets rasterGrob pour les sous-graphiques
grob_h <- rasterGrob(channel_h, interpolate = FALSE)
grob_s <- rasterGrob(channel_s, interpolate = FALSE)
grob_v <- rasterGrob(channel_v, interpolate = FALSE)
grob_gray <- rasterGrob(image_gray, interpolate = FALSE)

# Afficher les sous-graphiques ensemble
grid.arrange(grob_h, grob_s, grob_v, grob_gray, ncol = 2, nrow = 2)
