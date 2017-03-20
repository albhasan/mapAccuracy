#' The MAPACCURACY class
#'
#' Use this class for computing the accuracy of a classification using reference map
#'
#'
#'@section Slots :
#' \describe{
#' \item{\code{confusion_matrix}:}{Object of class \code{"matrix"}. A confusion matrix where the rows contain the results of the classification and the columns the reference data.}
#' \item{\code{class_areas}:}{Object of class \code{"vector"}, representing the area of each class in the reference map.}
#' }
#'
#' @note No notes
#' @name MapAccuracy
#' @aliases MapAccuracy-class
#' @exportClass MapAccuracy
#' @author Alber Sanchez
#' @import methods
#' @import roxygen2
#' @import testthat
setClass (
  Class = "MapAccuracy",
  representation = representation(
    confusion_matrix = "matrix",
    class_areas = "vector"
  ),
  validity = function(object){
    if(!is.matrix(object@confusion_matrix)){
      stop ("[MapAccuracy: validation] Invalid matrix.")
    }else if(!is.numeric(object@confusion_matrix)){
      stop ("[MapAccuracy: validation] Invalid matrix. The matrix is not numeric")
    }else if(nrow(object@confusion_matrix) != ncol(object@confusion_matrix)){
      stop ("[MapAccuracy: validation] Invalid matrix. The matrix is not a square.")
    }else{}
    #
    if(!is.vector(object@class_areas)){
      stop ("[MapAccuracy: validation] Invalid vector.")
    }else if(!is.numeric(object@class_areas)){
      stop ("[MapAccuracy: validation] Invalid vector. The vector is not numeric")
    }else{}
    #
    if(length(object@class_areas) != nrow(object@confusion_matrix)){
      stop ("[MapAccuracy: validation] The matrix and vector sizes do not match.")
    }else{}
    return(TRUE)
  }
)



#*******************************************************
# CONSTRUCTORS
#*******************************************************
setMethod (
  f="initialize",
  signature="MapAccuracy",
  definition=function(.Object, confusion_matrix, class_areas){
    if(!missing(confusion_matrix) & !missing(class_areas)){
      .Object@confusion_matrix <- confusion_matrix
      .Object@class_areas <- class_areas
      validObject(.Object)

    }else{
      .Object@confusion_matrix <- matrix(NA, nrow = 0, ncol = 0)
      .Object@confusion_matrix <- vector("numeric", length = 0)
    }
    return(.Object)
  }
)
#CONSTRUCTOR (USER FRIENDLY)
#' Creates a MapAccuracy object
#'
#' @param confusion_matrix A confusion matrix where the rows contain the results of the classification and the columns the reference data.
#' @param class_areas The area of each class in the reference map.
#' @rdname MapAccuracy
#' @docType methods
#' @export
mapAccuracy <- function(confusion_matrix, class_areas){
  new(Class = "MapAccuracy", confusion_matrix = confusion_matrix, class_areas = class_areas)
}



#*******************************************************
# MUTATORS
#*******************************************************

#' Returns the object's confusion matrix
#'
#' @param object A MapAccuracy object
#' @docType methods
#' @aliases getConfusionMatrix-generic
#' @export
setGeneric("getConfusionMatrix",function(object){standardGeneric ("getConfusionMatrix")})

#' @rdname getConfusionMatrix
setMethod("getConfusionMatrix","MapAccuracy",
          function(object){
            return(object@confusion_matrix)
          }
)

#' Sets the object's confusion matrix
#'
#' @param object A MapAccuracy object
#' @param confusion_matrix A confusion matrix
#' @docType methods
#' @export
setGeneric("setConfusionMatrix",function(object, confusion_matrix){standardGeneric ("setConfusionMatrix")})

#' @rdname  setConfusionMatrix
setMethod("setConfusionMatrix","MapAccuracy",
          function(object, confusion_matrix){
            object@confusion_matrix <- confusion_matrix
            # TODO: re-compute!
          }
)

#' Returns the object's class areas
#'
#' @param object A MapAccuracy object
#' @docType methods
#' @aliases getClassAreas-generic
#' @export
setGeneric("getClassAreas",function(object){standardGeneric ("getClassAreas")})

#' @rdname getClassAreas
setMethod("getClassAreas","MapAccuracy",
          function(object){
            return(object@class_areas)
          }
)

#' Sets the object's class areas
#'
#' @param object A MapAccuracy object
#' @param class_areas The area of each class in the map
#' @docType methods
#' @export
setGeneric("setClassAreas",function(object, class_areas){standardGeneric ("setClassAreas")})

#' @rdname  setClassAreas
setMethod("setClassAreas","MapAccuracy",
          function(object, class_areas){
            object@class_areas <- class_areas
            # TODO: re-compute!
          }
)


#*******************************************************
# GENERIC METHODS
#*******************************************************



#*******************************************************
# METHODS
#*******************************************************

#' Compute the map accuracy
#'
#' @param object A MapAccuracy object
#' @docType methods
#' @export
setGeneric("compute",function(object){standardGeneric("compute")})

#' @rdname  compute
setMethod("compute","MapAccuracy",
          function(object){
            .assesaccuracy(object@confusion_matrix, object@class_areas)
          }
)
