# Image Classification with Keras and CNNs
### SOMRC Machine Learning Hackathon | July 31, 2018

> * [Installing Keras for RStudio using Anaconda](#installing-keras-for-rstudio-using-anaconda)
> * [Sources](#sources)
----
## Installing Keras for RStudio using Anaconda

\*If you don't have Anaconda already, download Anaconda [here](https://www.anaconda.com/download) and install on your computer.

**1. Create a new environment in Anaconda with Python 3.**

Within the Environments tab, click the "Create" button. Python will be selected by default; also select R before proceeding.

**2. Install the following packages and their dependencies in your new environment:**

* keras
* tensorflow
* matplotlib

**3. Install and launch RStudio from Anaconda.**

This is located under the Home tab of Anaconda.

**4. In RStudio, install keras, jpeg, and png.**

jpeg and png are packages for handling JPG and PNG files. These aren't necessary to use keras, but will be used to examples to test the fidelity of our model with new images.

`> install.packages(c("keras", "jpeg", "png"))`

----
## Downloading the Dataset

**1. Download the dataset from Box: [https://virginia.box.com/v/somrc-hackathon-2018-07-31](https://virginia.box.com/v/somrc-hackathon-2018-07-31)**

**2. Unpack the tarball using the command line.**

`> tar -xzf the-simpsons-characters-dataset.tgz`

----
## Sources

1. Keras: [https://keras.io/](https://keras.io/)
2. Original Dataset: [https://www.kaggle.com/alexattia/the-simpsons-characters-dataset](https://www.kaggle.com/alexattia/the-simpsons-characters-dataset)
3. Inspiration: [https://medium.com/@seixaslipe/building-a-simpsons-classifier-with-deep-learning-in-keras-36a47fe17f79](https://medium.com/@seixaslipe/building-a-simpsons-classifier-with-deep-learning-in-keras-36a47fe17f79)
4. Coding with Keras in R vs Python: [https://www.r-bloggers.com/r-vs-python-image-classification-with-keras/](https://www.r-bloggers.com/r-vs-python-image-classification-with-keras/)
