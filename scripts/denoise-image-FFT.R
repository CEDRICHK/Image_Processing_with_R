library(imager)
library(magrittr)

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

# Charger les packages nécessaires
library(imager)
library(pracma)

# Charger l'image
im <- load.image("./images/moonlanding.png")

# Convertir l'image en échelle de gris et la normaliser à des valeurs entre 0 et 1
im <- im / max(im)

# Afficher l'image originale
plot(im, main = "Original Image")

# Calculer la transformée de Fourier rapide (FFT) de l'image
im_fft <- fft(im)

# Fonction pour tracer le spectre de la FFT
plot_spectrum <- function(im_fft) {
  image(log(abs(fftshift2D(im_fft))), main = "Spectrum with Fourier transform", 
        axes = FALSE, col = grey.colors(256))
}

# Tracer le spectre de la FFT
plot_spectrum(im_fft)

# Définir la fraction des coefficients à conserver
keep_fraction <- 0.1

# Copier le spectre original et tronquer les coefficients
im_fft2 <- im_fft

# Obtenir le nombre de lignes et de colonnes de l'array
rows <- dim(im_fft2)[1]
cols <- dim(im_fft2)[2]

# Mettre toutes les lignes à zéro avec des indices entre r*keep_fraction et r*(1-keep_fraction)
im_fft2[round(rows*keep_fraction):round(rows*(1-keep_fraction)), ] <- 0

# De même avec les colonnes
im_fft2[, round(cols*keep_fraction):round(cols*(1-keep_fraction))] <- 0

# Tracer le spectre filtré
image(log(abs(fftshift2D(im_fft2))), main = "Filtered Spectrum", 
      axes = FALSE, col = grey.colors(256))

# Reconstruire l'image débruitée à partir du spectre filtré, conserver seulement la partie réelle pour l'affichage
im_new <- Re(fft(im_fft2, inverse = TRUE))

plot(as.cimg(im_new), main = "Reconstructed image")
