#' PWKLest function
#' @description This function allows you to calculate the Posterior-weighted Kullback-Leibler Information.
#' @param unused_items the unused items from the whole itembank including item_id, slip, guess, 4 attributes, content area.
#' @param K the number of attributes.
#' @param KS_estimation the current KS estimation results.
#' @details prior is the uniform distribution.
#' @export PWKLest

PWKLest <- function(K,unused_items,KS_estimate){
  LC_prob <- LCprob(K,unused_items)
  vec <- c(0,1)
  alpha_all <- permutations(n=2,r=K,v=vec,repeats.allowed=T)
  point.est <- paste(KS_estimate, collapse = "") # the current estimated latent class
  prior <- rep(1 / nrow(alpha_all), nrow(alpha_all))
  PWKL_est <- c(0)
  for (jjj in 1:nrow(LC_prob)) {
    res <- sum(log(LC_prob[jjj, point.est]/LC_prob[jjj, ])*LC_prob[jjj, point.est]*prior)
    PWKL_est[jjj] <- res + sum(log((1-LC_prob[jjj, point.est])/(1-LC_prob[jjj, ]))*(1-LC_prob[jjj, point.est])*prior)
  }
  return(PWKL_est)
}
