#' Xi_likelihood function
#' @description This function allows you to calculate the conditional joint maximum likelihood estimation.
#' @param N the examinee sample size.
#' @param J the number of items.
#' @param p the probability of the correct answer on item j for examinee i.
#' @param X the responses of one examinee or examinees.
#' @details for one person, p & X are vectors; for more than one person, p & X are matrices.
#' @export Xi_likelihood

Xi_likelihood <- function(N,J,p,X){
  if (N==1){
    l <- numeric(J)
    for (j in 1:J){
      l[j] <- (p[j]^X[j]) * ((1 - p[j])^(1 - X[j]))
    }
    like <- prod(l)
  }else{
    like <- numeric(N)
    l <- matrix(NA, N, J)
    for (i in 1:N){
      for (j in 1:J){
        l[i,j] <- (p[i,j]^X[i,j])*((1-p[i,j])^(1-X[i,j]))
      }
      like[i] <- prod(l[i,])
    }
  }
  return(like)
}
