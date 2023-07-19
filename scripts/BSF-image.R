# Chargement du package
library(imager)

# Fonction fftshift
fftshift <- function(x) {
  shift <- length(x) %/% 2
  return(c(tail(x, -shift), head(x, shift)))
}

# Fonction fftshift pour 2D
fftshift2D <- function(x) {
  apply(x, 1, fftshift) %>% apply(1, fftshift)
}

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

# Ouverture de l'image
im <- load.image("./images/parrot_gray.png")

# FFT de l'image
F1 <- fft(im)

# FFTSHIFT sur la freq
F2 <- fftshift2D(F1)

# Générer du bruit de bande
rows <- dim(im)[1]
cols <- dim(im)[2]
noise <- matrix(0, nrow = rows, ncol = cols)
for (n in 1:rows) {
  noise[n,] <- 0.5 * cos(0.1*pi*n)
}

# Ajouter le bruit à l'image
im_noisy <- im[,,1,1] + noise

# FFT de l'image bruitée
F3 <- fft(im_noisy)

# FFTSHIFT sur la freq
F4 <- fftshift2D(F3)

# Éliminer certaines fréquences du spectre de Fourier
F4[1:220, 170:176] <- F4[230:ncol(F4), 170:176] <- 0

# Transformée de Fourier inverse pour revenir à l'espace image
im_filtered <- Re(fft(ifftshift2D(F4), inverse = TRUE))


par(mfrow = c(2,2), mar = c(1,1,3,1))
plot(im, main = "Original Image")
plot(as.cimg(log10(0.1 + (abs(F2)))), main = "Original Image Spectrum", 
     axes = FALSE)
plot(as.cimg(im_noisy), main = "Image after adding Sinusoidal Noise")
plot(as.cimg(log10(0.1 + (abs(F4)))), main = "Noisy Image Spectrum", 
     axes = FALSE)
# Afficher l'image filtrée
plot(as.cimg(im_filtered))
