library(EBImage)

# Charger l'image
lena <- readImage("./images/lena.jpg")

# Obtenir les dimensions de l'image
num_channels <- dim(lena)[3]
num_rows <- dim(lena)[1]
num_cols <- dim(lena)[2]

# Obtenir la valeur du pixel à la position (0, 40)
pixel_value <- as.vector(lena[40, 1, ])
print(pixel_value)

# Créer les grilles X et Y
X <- matrix(1:num_cols, nrow = num_rows, ncol = num_cols, byrow = TRUE)
Y <- matrix(1:num_rows, nrow = num_rows, ncol = num_cols, byrow = FALSE)

# Calculer le masque
mask <- ((X - num_cols / 2) ^ 2 + (Y - num_rows / 2) ^ 2) > (num_rows * num_cols) / 4

#Appliquer le masque sur l'image
lena[mask] <- 0

# Afficher l'image modifiée
display(lena)
