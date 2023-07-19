# Installation des packages nécessaires
if (!require(imager)) install.packages('imager')

# Chargement des packages
library(imager)

# Fonction ifftshift
ifftshift <- function(x) {
  shift <- if (length(x) %% 2 == 0) {
    length(x) %/% 2
  } else {
    length(x) %/% 2 + 1
  }
  c(tail(x, -shift), head(x, shift))
}

# Fonction ifftshift pour 2D
ifftshift2D <- function(x) {
  apply(x, 1, ifftshift) %>% apply(1, ifftshift)
}

# Lecture de l'image et conversion en niveaux de gris
im <- load.image("./images/rhino.jpg") %>% grayscale()

# FFT de l'image
freq <- fft(im)

# Récupération des dimensions de la FFT
w <- dim(freq)[1]
h <- dim(freq)[2]

# Calcul des dimensions de la moitié de la FFT
half_w <- w %/% 2
half_h <- h %/% 2

# Copie de la FFT
freq1 <- freq

# Décalage de la FFT
freq2 <- fftshift2D(freq1)

# Affichage de la FFT décalée
plot(as.cimg(abs(log10(0.1 + freq2))))

# Application du filtre passe-haut
freq2[(half_w-10):(half_w+11), (half_h-10):(half_h+11)] <- 0

# Affichage de la FFT après le filtrage passe-haut
plot(as.cimg(abs(log10(0.1 + freq2))))

# Définition de la fonction clip
clip <- function(x, min, max) {
  x <- ifelse(x < min, min, x)
  x <- ifelse(x > max, max, x)
  return(x)
}

# Inverse FFT et clipping des valeurs de pixels
im1 <- clip(Re(fft(ifftshift2D(freq2), inverse = TRUE)), 0, 255)

# Calcul du signal-to-noise ratio (SNR)
snr <- mean(im1) / sd(im1)
print(snr)

# Affichage de l'image filtrée
plot(as.cimg(im1))
