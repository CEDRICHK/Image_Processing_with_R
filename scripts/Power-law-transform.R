library(imager)
library(ggplot2)
library(reshape2)

plot_hist <- function(r, g, b, title='') {
  df <- data.frame(
    r = as.vector(r),
    g = as.vector(g),
    b = as.vector(b)
  )
  df <- melt(df)
  ggplot(df, aes(x = value, fill = variable)) +
    geom_histogram(position = 'identity', alpha = 0.5, bins = 256) +
    theme_minimal() +
    scale_x_continuous(limits = c(0,256)) + 
    labs(x = 'Pixel Value', y = 'Frequency', title = title, fill = 'Channel') +
    scale_fill_manual(values = c("red", "green", "blue"))
}


im <- load.image("./images/earthfromsky.jpg")
ch <- imsplit(im, "c")

r <- ch$`c = 1`*255
g <- ch$`c = 2`*255
b <- ch$`c = 3`*255

plot(im, main = "Original Image (input)")
plot_hist(r, g, b, title = "Histogram for RGB channels (input)")

gamma <- 5
im1 <- im^gamma

ch <- imsplit(im1, "c")

r <- ch$`c = 1`*255
g <- ch$`c = 2`*255
b <- ch$`c = 3`*255

plot(im1, main = "Original Image (output)")
plot_hist(r, g, b, title = "Histogram for RGB channels (output)")