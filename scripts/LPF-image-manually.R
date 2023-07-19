library(imager)
library(signal)

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

# Fonction fftshift
fftshift <- function(x) {
  shift <- length(x) %/% 2
  return(c(tail(x, -shift), head(x, shift)))
}

# Fonction fftshift pour 2D
fftshift2D <- function(x) {
  apply(x, 1, fftshift) %>% apply(1, fftshift)
}

# Charger l'image et la convertir en niveaux de gris
im <- load.image("./images/rhino.jpg") %>% grayscale()

# FFT de l'image
freq <- fft(im)

# Dimensions de l'image
w <- dim(freq)[1]
h <- dim(freq)[2]

# Calcul des dimensions de la moitié de la FFT
half_w <- w %/% 2
half_h <- h %/% 2

# Copie de la FFT
freq1 <- freq

# Shift de la FFT
freq_shifted <- fftshift2D(freq1)

# Créer une copie de freq_shifted pour le filtrage passe-bas
freq_shifted_low <- freq_shifted

# Blocage des hautes fréquences
freq_shifted_low[(half_w - 10):(half_w + 11), (half_h - 10):(half_h + 11)] <- 0

# Suppression des hautes fréquences pour obtenir le filtre passe-bas
freq_shifted <- freq_shifted - freq_shifted_low

# Inverse FFT
im1 <- Re(fft(ifftshift2D(freq_shifted), inverse=TRUE))

# Affichage de l'image filtrée
plot(as.cimg(im1))

# Spectre de l'image
plot(as.cimg(log10(0.1 +(abs(freq_shifted)))), main = "Output Image Spectrum", 
     axes = FALSE)
