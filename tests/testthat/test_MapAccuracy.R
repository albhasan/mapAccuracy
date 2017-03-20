# example

classnames <-  c("forest", "grass", "urban")
confusion_matrix <- matrix(c(97, 0, 3, 3, 279, 18, 2, 1, 97), ncol = 3, byrow = TRUE)
class_areas <- c(22353, 1122543, 610228)

colnames(confusion_matrix) <- rownames(confusion_matrix) <- classnames
names(class_areas) <- classnames

ma <- new(Class = "MapAccuracy", confusion_matrix = confusion_matrix, class_areas = class_areas)
acc <- compute(ma)

