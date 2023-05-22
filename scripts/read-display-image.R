if(!"magick" %in% installed.packages())
  install.packages("magick")
library(magick)

image <- image_read("./images/parrot.png")
width <- image_info(image)$width
height <- image_info(image)$height
mode <- image_info(image)$colorspace
format <- image_info(image)$format
im_class <- class(image)

cat(width, height, mode, format, im_class, "\n")
image
