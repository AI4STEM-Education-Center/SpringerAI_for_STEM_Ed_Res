#' PCCR function
#' @description The pattern correct classification rate measured the entire attribute profile recovery.
#' @param alpha_true The true attribute pattern of the examinee.
#' @param alpha_estimated The estimated attribute pattern of the examinee.
#' @details I is the indicator function.
#' @export PCCR

PCCR <- function(alpha_true, alpha_estimated){
  N <- dim(alpha_true)[1]
  I <- apply(alpha_true == alpha_estimated, 1, all)
  I <- as.integer(I)
  PCCR_value <- sum(I) / N
  return(PCCR_value)
}
