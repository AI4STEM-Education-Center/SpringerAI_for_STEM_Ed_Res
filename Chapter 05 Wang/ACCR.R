#' ACCR function
#' @description The attribute correct classification rate measured the individual attribute recovery.
#' @param alpha_true The true attribute pattern of the examinee.
#' @param alpha_estimated The estimated attribute pattern of the examinee.
#' @details K is the number of attributes.
#' @export ACCR

ACCR <- function(alpha_true, alpha_estimated){
  N <- nrow(alpha_true)
  K <- ncol(alpha_true)
  ACCR_value <- numeric(K)
  for (k in 1:K) {
    correct_predictions <- sum(alpha_true[, k] == alpha_estimated[, k])
    ACCR_value[k] <- correct_predictions / N
  }
  return(ACCR_value)
}
