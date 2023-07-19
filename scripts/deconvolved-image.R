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

# Lire l'image
im <- 255* load.image("./images/lena.jpg") %>% grayscale()

# Obtention des dimensions de l'image
im_dim <- dim(im)

# Création du noyau gaussien
gauss_kernel <- EBImage::makeBrush(size = im_dim[1], shape = "Gaussian", sigma = 3)
gauss_kernel <- gauss_kernel[1:im_dim[1], 1:im_dim[1]]

# Prendre la FFT de l'image
freq <- fft(im)
freq <- freq[,,1,1]

# Prendre la FFT du noyau gaussien (en le décalant d'abord)
freq_kernel <- fft(ifftshift2D(gauss_kernel))

# Convolution dans le domaine fréquentiel (produit terme à terme)
convolved <- freq*freq_kernel

# IFFT pour obtenir l'image floue
im_blur <- Re(fft(convolved, inverse = TRUE))

# Normaliser l'image floue
im_blur <- 255 * im_blur / max(im_blur)

# Filtre inverse (en évitant la division par zéro)
epsilon <- 10^-6
freq_kernel <- 1 / (epsilon + freq_kernel)

# Prendre la FFT de l'image bruitée
freq <- fft(im_blur)

# Convolution avec le filtre inverse
convolved <- freq*freq_kernel

# IFFT pour obtenir l'image restaurée
im_restored <- Re(fft(convolved, inverse = TRUE))

# Normaliser l'image restaurée
im_restored <- 255 * im_restored / max(im_restored)

#diff
img_diff <- im_restored - im[,,1,1]

# Afficher les images
par(mfrow=c(2,2))
plot(im, main='Original image')
plot(as.cimg(im_blur), main='Blurred image')
plot(as.cimg(im_restored), main='Restored image with inverse filter')
plot(as.cimg(img_diff), main='Diff restored & original image')
