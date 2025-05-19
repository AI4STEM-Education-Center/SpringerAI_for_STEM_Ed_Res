#' P_DINA function
#' @description This function allows you to calculate the probability of the correct answer on item j for examinee i.
#' @param N the examinee sample size.
#' @param slip slipping parameters for all answered items.
#' @param guess slipping parameters for all answered items.
#' @param eta a value of 1 if examinee i possesses all the skills required for item j, otherwise 0.
#' @details for one person, eta & p are vectors; for more than one person, eta & p are matrices.
#' @export P_DINA

P_DINA <- function(N,slip,guess,eta){
  J <- length(slip)
  if (N==1){
    p <- numeric(J)
    for (j in 1:J){
      p[j] <- ((1 - slip[j])^eta[j])*(guess[j]^(1-eta[j]))
    }
  }else{
    p <- matrix(NA, N, J)
    for (i in 1:N){
      for (j in 1:J){
        p[i,j] <- ((1 - slip[j])^eta[i,j])*(guess[j]^(1-eta[i,j]))
      }
    }
  }
  return(p)
}
