library(EBImage)

# Charger l'image
im <- readImage("./images/parrot.png")

# Ajouter du bruit aléatoire à une partie de l'image
l <- length(im)
n <- l / 10
pixels <- sample(l, n)
im_noisy <- im
im_noisy[pixels] <- runif(n, min = 0, max = 1)

# Afficher l'image bruitée
display(im_noisy)
