################################################################################
# Webinar: Good practices :
# Accuracy assesment and area estimation
# https://youtu.be/xAes7ddZ7CQ
#-------------------------------------------------------------------------------
# Related papers
# Good practices for estimating area and assessing accuracy of land change
# DOI 10.1016/j.rse.2014.02.015
# Making better use of accuracy data in land change studies: Estimating accuracy
# and area and quantifying uncertainty using stratified estimation
# DOI 10.1016/j.rse.2012.10.031
#-------------------------------------------------------------------------------
# NOTES:
# This computations don't work for clustered sampling. The equations are different
################################################################################



#
#
# @param error_matrix A matrix given in sample counts. Columns represent the reference data and rows the results of the classification
# @param class_areas     A vector of the total area of each class on the map
# @return             ---
.assesaccuracy <- function(error_matrix, class_areas){
  W <- class_areas/sum(class_areas)
  W.mat <- matrix(rep(W, times = ncol(error_matrix)), ncol = ncol(error_matrix))
  n <- rowSums(error_matrix)
  n.mat <- matrix(rep(n, times = ncol(error_matrix)), ncol = ncol(error_matrix))
  p <- W * error_matrix / n.mat                                                 # estimated area proportions
  # rowSums(p) * sum(class_areas)                                                  # class areas according to the map, that is, the class_areas vector
  error_adjusted_area_estimate <- colSums(p) * sum(class_areas)                    # class areas according to the reference data
  Sphat_1 <- sapply(1:ncol(error_matrix), function(i){                          # S(phat_1) - The standard errorof the area estimative is given as a function area proportions and sample counts
    sqrt(sum(W^2 * error_matrix[, i]/n * (1 - error_matrix[, i]/n)/(n - 1)))
  })
  #
  SAhat <- sum(class_areas) * Sphat_1                                           # S(Ahat_1) - Standard error of the area estimate
  Ahat_sup <- error_adjusted_area_estimate + 2 * SAhat                          # Ahat_1 - 95% superior confidence interval
  Ahat_inf <- error_adjusted_area_estimate - 2 * SAhat                          # Ahat_1 - 95% inferior confidence interval
  Ohat <- sum(diag(p))                                                          # Ohat - Overall accuracy
  Uhat <- diag(p) / rowSums(p)                                                  # Uhat_i - User accuracy
  Phat <- diag(p) / colSums(p)                                                  # Phat_i - Producer accuracy
  #
  return(
    list(
      # errorArea = SAhat,
      confint95 = list(
        superior = Ahat_sup,
        inferior = Ahat_inf
      ),
      accuracy = list(
        overall = Ohat,
        user = Uhat,
        producer = Phat
      )
    )
  )
}





