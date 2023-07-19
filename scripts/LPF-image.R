# Chargement des bibliothèques
library(imager)
library(EBImage)

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

# Transformée de Fourier 2D de l'image
freq <- fft(im)

gauss_kernel <- EBImage::makeBrush(size = im_dim[1], shape = "Gaussian", 
                                   sigma = 4)
gauss_kernel <- gauss_kernel[1:im_dim[1], 1:im_dim[1]]

# FFT du noyau Gaussien et décalage FFT
freq_kernel <- fft(ifftshift2D(gauss_kernel))

# Extraire la première tranche 2D de freq
freq_2d <- freq[,,1,1]

# Convolution par multiplication dans le domaine fréquentiel
convolved <- freq_2d * freq_kernel

# Transformation inverse pour obtenir l'image floutée
im1 <- Re(fft(convolved, inverse = TRUE))


# Affichage des images
par(mfrow=c(1,2)) # Création d'un layout pour les figures
plot(im, axes=FALSE, main="Original Image")
plot(as.cimg(im1), axes=FALSE, main="Blurred Image with LPF")

# Affichage de la magnitude du spectre
plot(as.cimg(log10(0.1 + fftshift2D(abs(convolved)))), main = "Output Image Spectrum", 
     axes = FALSE)
