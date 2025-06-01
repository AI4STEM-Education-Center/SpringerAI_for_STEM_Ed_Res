#' ETA function
#' @description This function allows you to identify whether the i_th examinee possesses all the attributes of item j.
#' @param N the examinee sample size.
#' @param alpha attribute pattern for one examinee or patterns for more than one examinee.
#' @param Q the Q matrix for all answered items.
#' @return eta 1 indicates the required attributes are mastered, 0 otherwise.
#' @details for one person, alpha & eta are vectors; for more than one person, alpha & eta are matrices.
#' @export ETA

ETA <- function(N,alpha,Q){
  J <- nrow(Q)
  if (N == 1){
    eta <- numeric(J)
    for(j in 1:J){
      e <- 1
      K <- ncol(Q)
      for (k in 1:K){
        e <- e*(alpha[k]^Q[j,k])
      }
      eta[j] <- e
    }
  }else{
    eta <- matrix(NA, N, J)
    for (i in 1:N){
      for (j in 1:J){
        e <- 1
        K <- ncol(Q)
        for (k in 1:K){
          e <- e*(alpha[i,k]^Q[j,k])
        }
        eta[i,j] <- e
      }
    }
  }
  return(eta)
}
