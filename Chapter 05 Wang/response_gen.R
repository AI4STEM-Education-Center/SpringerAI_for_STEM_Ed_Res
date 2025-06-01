#' response_gen function
#' @description This function allows you to generate response matrix based on the DINA model.
#' @param N the examinee sample size.
#' @param slip slipping parameters for all answered items.
#' @param guess slipping parameters for all answered items.
#' @param eta a value of 1 if examinee i possesses all the skills required for item j, otherwise 0.
#' @details for one person, resp are vectors; for more than one person, resp is a matrix.
#' @export response_gen


response_gen <- function(N,slip,guess,eta){
  n.items <- length(slip)
  n.subjects <- N
  p <- P_DINA(N,slip,guess,eta)
  if (n.subjects==1){
    resp <- numeric(n.items)
    for (j in 1:n.items) {
      if (p[j] > runif(1)){
        resp[j] <- 1
      } else {
        resp[j] <- 0
      }
    }
  }else{
    resp <- matrix(NA,nrow = n.subjects, ncol = n.items)
    for (i in 1:n.subjects) {
      for (j in 1:n.items) {
        if (p[i,j] > runif(1)){
          resp[i,j] <- 1
        } else {
          resp[i,j] <- 0
        }
      }
    }
  }
  return(resp)
}
