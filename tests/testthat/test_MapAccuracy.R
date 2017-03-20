library(MapAccuracy)
library(testthat)

confusion_matrix <- matrix(c(97, 0, 3, 3, 279, 18, 2, 1, 97), ncol = 3, byrow = TRUE)
class_areas <- c(22353, 1122543, 610228)
classnames <-  c("deforestation", "forest", "no forest")
colnames(confusion_matrix) <- rownames(confusion_matrix) <- classnames
names(class_areas) <- classnames
ma <- new(Class = "MapAccuracy", confusion_matrix = confusion_matrix, class_areas = class_areas)
acc <- compute(ma)

# test shape of the returned list
expect_equal(length(acc), 2)
expect_equal(length(acc$confint95), 2)
expect_equal(length(acc$accuracy), 3)

# test resulting values
expect_equal(as.vector(acc$confint95$superior), c(66615.21, 1085371.36, 697216.04), tolerance = 0.1)
expect_equal(as.vector(acc$confint95$inferior), c(23609.59, 1014763.18, 622672.62), tolerance = 0.01)
expect_equal(as.vector(acc$accuracy$overall), 0.9444168, tolerance = 0.0000001)
expect_equal(as.vector(acc$accuracy$user), c(0.97, 0.93, 0.97), tolerance = 0.01)
expect_equal(as.vector(acc$accuracy$producer), c(0.4806308, 0.9941887, 0.8969259), tolerance = 0.0000001)
