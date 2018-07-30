# Initial setup ----------------------------------------------------------

# Load the Keras library
library(keras)

# For reproducibility, we are setting a seed
use_session_with_seed(42)

# Get start time for calculating elapsed time
start_time <- Sys.time()

# Create a list of the labels for our images
# (directory names in our dataset folder)
simpsons_list <- c('bart_simpson', 'homer_simpson', 'ned_flanders')
# Create variable for number of output classes
output_n     <- length(simpsons_list)

# Set size you want to resize images to (in pixels)
img_width   <- 64
img_height  <- 64
target_size <- c(img_width, img_height)

# Specify number of color channels (3 for RGB)
channels <- 3

# Set paths to training and validation datasets
path          <- '~/SOMRC/workshops/the-simpsons-characters-dataset'
train_image_files_path <- file.path(path, 'simpsons_dataset')
valid_image_files_path <- file.path(path, 'kaggle_simpson_testset')

# Generate batches of data --------------------------------------------------

# Rescale image pixel values from 0-255 to 0-1.
# The image_data_generator command is used for data augmentation
# and normalization
train_data_gen <- image_data_generator(rescale = 1/255)
valid_data_gen <- image_data_generator(rescale = 1/255)

# Generate batches of data from images in directory
# Apply resizing and scaling, and shuffle images
train_image_array_gen <- 
  flow_images_from_directory(train_image_files_path,
                             train_data_gen,
                             target_size = target_size,
                             class_mode = 'categorical',
                             classes = simpsons_list,
                             seed = 42)

valid_image_array_gen <-
  flow_images_from_directory(valid_image_files_path,
                             valid_data_gen,
                             target_size = target_size,
                             class_mode = 'categorical',
                             classes = simpsons_list,
                             seed = 42)

# Set model parameters ------------------------------------------------

# Retrieve number of samples in training and validation datasets
train_samples <- train_image_array_gen$n
valid_samples <- valid_image_array_gen$n

# Set minibatch size (number of images included in one training iteration)
batch_size <- 32

# Set number of epochs (number of times the model is exposed to every image of the training set)
epochs <- 5

# Set up the model ----------------------------------------------------

# Instantiate the model
model <- keras_model_sequential()

# Add layers to your model
model %>%
  layer_conv_2d(filters = 32, kernel_size = c(5,5), padding = 'same', input_shape = c(img_width, img_height, channels)) %>%
  layer_activation('relu') %>%
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  
  layer_conv_2d(filters = 64, kernel_size = c(3,3), padding = 'same') %>%
  layer_activation('relu') %>%
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  
  layer_conv_2d(filters = 128, kernel_size = c(3,3), padding = 'same') %>%
  layer_activation('relu') %>%
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  
  layer_flatten() %>%
  layer_dense(128) %>%
  layer_activation('relu') %>%
  layer_dropout(0.5) %>%
  layer_dense(64) %>%
  layer_activation('relu') %>%
  layer_dropout(0.5) %>%
  layer_dense(output_n) %>%
  layer_activation('softmax')

# Configure the model (choosing optimizer, loss function, what output metric you want)
model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = 'adam',
  metrics = 'accuracy')

# Start training your model! ------------------------------------------------------------------------------
model_hist <- model %>% fit_generator(
  train_image_array_gen,
  steps_per_epoch = as.integer(train_samples/batch_size),
  epochs = epochs,
  validation_data = valid_image_array_gen,
  validation_steps = as.integer(valid_samples/batch_size),
  verbose = 2,
  callbacks = list(
    callback_model_checkpoint(file.path(path,'simpsons_checkpoints.h5'), save_best_only = TRUE),
    callback_tensorboard(log_dir = file.path(path, 'logs'))
  )
)

# Get metrics for model performance -----------------------------------------------------------------------
df_out <- model_hist$metrics %>%
  {data.frame(acc = .$acc[epochs], val_acc = .$val_acc[epochs], elapsed_time = as.integer(Sys.time())- as.integer(start_time))}