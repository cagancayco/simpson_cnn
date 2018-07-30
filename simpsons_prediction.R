# Load keras and image file libraries
library(keras)
library(jpeg)
library(png)

# Load your model (if not already in memory)
#model <- load_model_hdf5('/path/to/simpsons_checkpoints.h5')

# Load your desired test image
img <- readJPEG('/path/to/testimg.jpg') # may require readPNG() if your image is a png file instead

# Resize your image to the size we used for our model
img <- image_array_resize(img, 64, 64, data_format = 'channels_last')

# Resize image to be 4-D array, where first dimension is just 1.
# This is so it matches the dimensions that the model is expecting
img <- array(img, dim = c(1, 64, 64, 3))

# Predict which character class your image most closely matches
pred <- model$predict(img, batch_size = as.integer(1))