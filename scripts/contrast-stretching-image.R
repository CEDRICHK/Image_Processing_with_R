library(imager)
library(ggplot2)

plot_hist <- function(r, g, b, title='') {
  df <- data.frame(
    r = as.vector(r)*255,
    g = as.vector(g)*255,
    b = as.vector(b)*255
  )
  df <- melt(df)
  ggplot(df, aes(x = value, fill = variable)) +
    geom_histogram(position = 'identity', alpha = 0.5, bins = 256) +
    theme_minimal() +
    scale_x_continuous(limits = c(0,256)) + 
    labs(x = 'Pixel Value', y = 'Frequency', title = title, fill = 'Channel') +
    scale_fill_manual(values = c("red", "green", "blue"))
}

plot_hist2 <- function(r, g, b, title='') {
  df <- data.frame(
    r = as.vector(r)*255,
    g = as.vector(g)*255,
    b = as.vector(b)*255
  )
  df <- melt(df)
  ggplot(df, aes(x = value, fill = variable)) +
    geom_histogram(position = 'identity', alpha = 0.5, bins = 256) +
    theme_minimal() +
    scale_x_continuous(limits = c(0,256)) +
    scale_y_log10() +
    labs(x = 'Pixel Value', y = 'Frequency', title = title, fill = 'Channel') +
    scale_fill_manual(values = c("red", "green", "blue"))
}

# Définir la fonction de contraste
contrast <- function(c) {
  c <- c * 255  # Convertir les valeurs de pixel de la plage [0,1] à la plage [0,255]
  c <- ifelse(c < 70, 0, ifelse(c > 150, 255, (255*c - 22950) / 48))
  c / 255  # Convertir les valeurs de pixel de retour à la plage [0,1]
}


# Charger l'image
im <- load.image("./images/cheetah.png")
ch <- imsplit(im, "c")

plot(im, main = "Original image")
plot_hist(ch$`c = 1`, ch$`c = 2`, ch$`c = 3`, title = "Histogram for RGB channels")

# Charger l'image
im1 <- load.image("./images/cheetah.png")

# Appliquer la fonction de contraste à chaque pixel
im1 <- im1 %>% as.vector() %>% sapply(contrast) %>% array(dim = dim(im1)) %>% as.cimg()
ch1 <- imsplit(im1, "c")
r <- ch1$`c = 1`
g <- ch1$`c = 2`
b <- ch1$`c = 3`
plot(im1, main = "Image - Enhanced contrast")
plot_hist2(r, g, b, title = "Histogram for RGB channels - Enhanced contrast")
