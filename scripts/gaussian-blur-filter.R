# Installation des packages nécessaires
# install.packages(c("imager", "pracma", "ggplot2"))

# Chargement des bibliothèques
library(imager)
library(pracma)
library(ggplot2)

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


# Lecture et conversion en niveaux de gris de l'image
im <- load.image("./images/lena.jpg") %>% grayscale()

# Obtention des dimensions de l'image
im_dim <- dim(im)

gauss_kernel <- EBImage::makeBrush(size = im_dim[1], shape = "Gaussian", sigma = 5)
gauss_kernel <- gauss_kernel[1:im_dim[1], 1:im_dim[1]]

# FFT de l'image et du noyau
freq <- fft(im)

# FFT du noyau Gaussien et décalage FFT
freq_kernel <- fft(ifftshift2D(gauss_kernel))

# Extraire la première tranche 2D de freq
freq_2d <- freq[,,1,1]

# Convolution par multiplication dans le domaine fréquentiel
convolved <- freq_2d * freq_kernel

# Retour à l'espace image
# Applique la Transformée de Fourier Inverse
im1 <- Re(fft(convolved, inverse = TRUE))

# Affichage des images et des spectres
par(mfrow = c(2,3), mar = c(1,1,3,1))
plot(im, main = "Original Image")
plot(as.cimg(gauss_kernel), main = "Gaussian Kernel")
plot(as.cimg(im1), main = "Output Image")
plot(as.cimg(log10(0.1 + fftshift2D(abs(freq)))), main = "Original Image Spectrum", 
     axes = FALSE)
plot(as.cimg(log10(0.1 + fftshift2D(abs(freq_kernel)))), main = "Gaussian Kernel Spectrum", 
     axes = FALSE)
plot(as.cimg(log10(0.1 + fftshift2D(abs(convolved)))), main = "Output Image Spectrum", 
     axes = FALSE)