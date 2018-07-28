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

**3. Install and launch RStudio.**

This is located under the Home tab of Anaconda.

**4. In RStudio, install keras, jpeg, and png.**

jpeg and png are packages for handling JPG and PNG files. These aren't necessary to use keras, but will be used to examples to test the fidelity of our model with new images.

`> install.packages(c("keras", "jpeg", "png"))`
----
## Sources
