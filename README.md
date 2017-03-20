# mapAccuracy: Assess the accuracy of remotely sensed maps.

This R package computes an assessment of the accuracy of remotely sensed change  maps using the area of each class in the map. The assesment is based on the good practices proposed by [Pontus Olofsson](http://www.bu.edu/earth/people/faculty/johan-pontus-olofsson/).

Related resources:
- [Video](https://youtu.be/xAes7ddZ7CQ): Assessing Accuracy and Estimating Area of Remotely Sensed Change Maps 
- [Paper](http://www.sciencedirect.com/science/article/pii/S0034425714000704): Good practices for estimating area and assessing accuracy of land change
- [Paper](http://www.sciencedirect.com/science/article/pii/S0034425712004191): Making better use of accuracy data in land change studies: Estimating accuracy and area and quantifying uncertainty using stratified estimation



## Prerequisites
- R
- The devtools package.
- An Internet conection.



## Installation

This package can be installed using devtools as follows:

```R
library(devtools)
install_github("albhasan/mapAccuracy")
```



## Use

The package take as inputs a confusion matrix resulting from a classification and the are of each class in a reference map.

```R
library(mapAccuracy)

# assume the following confusion matrix and are vector
classnames <-  c("deforested", "forested", "no forested")
confusion_matrix <- matrix(c(97, 0, 3, 3, 279, 18, 2, 1, 97), ncol = 3, byrow = TRUE)
class_areas <- c(22353, 1122543, 610228)

# Name the rows and columns accordingly
colnames(confusion_matrix) <- rownames(confusion_matrix) <- classnames
names(class_areas) <- classnames

# Compute the accuracy metrics and display the results
ma <- new(Class = "MapAccuracy", confusion_matrix = confusion_matrix, class_areas = class_areas)
acc <- compute(ma)
acc
```




