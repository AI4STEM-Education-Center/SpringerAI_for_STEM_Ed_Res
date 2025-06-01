#' EAP_estimation function
#' @description This function allows you to get the Expectation A Posterior Estimation.
#' @param itembank the itembank including item_id, slip, guess, 4 attributes, content area.
#' @param response the responses of one examinee.
#' @param K the number of attributes.
#' @details prior is the uniform distribution.
#' @export EAP_estimation

EAP_estimation <- function(itembank,response,K){
  J <- nrow(itembank)
  vec <- c(0,1)
  alpha_all <- permutations(n=2,r=K,v=vec,repeats.allowed=T)
  like <- numeric(nrow(alpha_all))
  for (w in 1:nrow(alpha_all)){
    alpha.trial <- alpha_all[w,]
    eta0 <- ETA(1,alpha.trial,itembank[, c(4,5,6,7), drop = FALSE])
    p0 <- numeric(J)
    for (m in 1:J) {
      p0[m] <- ((1 - itembank[m,2])^eta0[m])*(itembank[m,3]^(1-eta0[m]))
    }
    like[w] <- Xi_likelihood(1,J,p0,response)
  }
  prior <- rep(1 / nrow(alpha_all), nrow(alpha_all))
  post <- (prior*like)/sum(prior*like)
  EAP <- numeric(K)
  KS_EAP <- numeric(K)
  for (kk in 1:K) {
    alpha_k_values <- alpha_all[, kk]
    EAP[kk] <- sum(alpha_k_values * post)
    if(EAP[kk] > 0.5){
      KS_EAP[kk] = 1
    } else {
      KS_EAP[kk] = 0
    }
  }
  return(KS_EAP)
}
