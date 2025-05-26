#' LCprob function
#' @description This function allows you to calculate the latent class probability.
#' @param unused_items the unused items from the whole itembank including item_id, slip, guess, 4 attributes, content area.
#' @param K the number of attributes.
#' @details success probabilities for each category for all latent classes.
#' @export LCprob

LCprob <- function(K,unused_items){
  vec <- c(0,1)
  alpha_all <- permutations(n=2,r=K,v=vec,repeats.allowed=T)
  Lclass <- apply(alpha_all, MARGIN = 1, FUN = function(x){paste(x, collapse = "")})
  LCprob <- matrix(NA, nrow = dim(unused_items)[1],ncol = length(Lclass))
  colnames(LCprob) <- Lclass
  for (qq in 1:dim(unused_items)[1]){
    for(aa in 1:nrow(alpha_all)){
      eta_3 <- ETA(1, alpha_all[aa,], unused_items[qq, c(4, 5, 6, 7), drop = FALSE])
      LCprob[qq,aa] <- P_DINA(1, unused_items[qq, 2], unused_items[qq, 3], eta_3)
    }
  }
  return(LCprob)
}
