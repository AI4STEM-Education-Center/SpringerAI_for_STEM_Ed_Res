#' JSDest function
#' @description This function allows you to calculate the Jensen-Shannon Divergence Index.
#' @param unused_items the unused items from the whole itembank including item_id, slip, guess, 4 attributes, content area.
#' @param K the number of attributes.
#' @details prior is the uniform distribution.
#' @export JSDest

JSDest <- function(K,unused_items){
  LC_prob <- LCprob(K,unused_items)
  vec <- c(0,1)
  alpha_all <- permutations(n=2,r=K,v=vec,repeats.allowed=T)
  prior <- rep(1 / nrow(alpha_all), nrow(alpha_all))
  H <- function(v){
    v <- v[v > 0]
    return(sum(-v * log2(v)))
  }
  JSD_est <- c(0)
  w <- prior
  for (jjj in 1:nrow(LC_prob)) {
    p <-  rbind(LC_prob[jjj, ], 1 - LC_prob[jjj, ])
    w <- matrix(data = w, ncol = 1)
    JSD_est[jjj] <- H(p %*% w) - apply(p, 2, H) %*% w
  }
  return(JSD_est)
}
