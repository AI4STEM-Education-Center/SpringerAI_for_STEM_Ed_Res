#----------- load useful packages ----------#
# Install devtools package (if not installed yet)
install.packages("devtools")
# Install remotes package (if not installed yet)
install.packages("remotes")
# Using devtools to install packages from github
devtools::install_github("Jeanwong1222/CcdcatR")

library(CcdcatR) # including useful functions
library(MASS) # For statistical functions
library(gtools) # For combination calculations

#==============================================================================
#==============================================================================
# Simulation parameters
sim_num <- 100 # replication times 
K <- 4  # Number of attributes
S <- 4 # Number of content areas
J <- 32 # Total number of items in each linear item pool
N <- 200 # Sample size for one test 
M <- c(16,24,32) # Fixed test length for CD-CAT 
lower <- 1 # lower bound for each content area
upper <- ceiling(M/S) # upper bound for each content area
min_attr <- ceiling(M/K) # the minimum number of items required that measures each attribute

#==============================================================================
#==============================================================================
# Step1: Item Bank Design and Calibration
itembank_CD_CAT <- matrix(NA, nrow = J*5, ncol = 8*sim_num)
itembank_linear <- matrix(NA, nrow = J*sim_num, ncol = 8*5)

# Create basic matrix units
Q_0 <- matrix(c(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1), nrow = 4, byrow = TRUE)
colnames(Q_0) <- c("vector", "relationship", "algebra", "visualization") 
Q_00 <- do.call(rbind,replicate(8, Q_0, simplify = FALSE))
# Content areas: 1 = kinematics; 2 = forces; 3 = energy; 4 = momentum
content_area <- rep(c(1:S), each = J/S)

set.seed(1972)
for (s in 1:sim_num){
  # Create 5 parallel small item bank for the linear test
  for (i in 1:5) {
    assign(paste0("itembank_", i),
           cbind(
             item_id = paste0(s,i, sprintf("%02d", 1:J)),  
             slipping = round(runif(J, .05, .25), 3),        
             guessing = round(runif(J, .05, .25), 3),        
             Q_00,         
             content_area = as.numeric(content_area)
           )
    )
  }
  # Create the comprehensive item bank and Q matrix for the CD-CAT
  itembank_com <- apply(rbind(itembank_1,itembank_2,itembank_3,itembank_4,itembank_5),2,as.numeric)
  itembank_CD_CAT[,c(((s*8)-7):(s*8))] <- itembank_com[sample(nrow(itembank_com)),] 
  itembank_linear[c(((J*s)-(J-1)):(J*s)),] = cbind(apply(itembank_1,2,as.numeric),
                                                   apply(itembank_2,2,as.numeric),
                                                   apply(itembank_3,2,as.numeric),
                                                   apply(itembank_4,2,as.numeric),
                                                   apply(itembank_5,2,as.numeric))
}


#==============================================================================
#==============================================================================
# Step 2: Examinee Generation
KS_0 <- matrix(NA, nrow = N, ncol = K*sim_num)

# Define the attribute patterns and their probabilities
patterns <- c("0000", "0001", "0010", "0100", "1000",  # low mastery
              "1100", "1010", "1001", "0110", "0101", "0011", # medium mastery
              "1110", "1101", "1011", "0111", "1111") # high mastery
probabilities <- c(.05,0.0625,0.0625,0.0625,0.0625,
                   .067,.067,.067,.067,.067,.067,
                   0.0625,0.0625,0.0625,0.0625,.05)  
probabilities <- probabilities / sum(probabilities) # Normalize the probabilities to sum to 1


set.seed(1222) # Set seed for reproducibility
for (s in 1:sim_num){
  for (j in 1:N) {
    selected_pattern <- sample(patterns, 1, prob = probabilities)
    KS_0[j,c(((K*s)-3):(K*s))] <- as.numeric(unlist(strsplit(selected_pattern, "")))
  }
}

#==============================================================================
#==============================================================================
# Step 3: linear test
PCCR_linear <- numeric(sim_num)
ACCR_linear <-  matrix(NA, nrow = sim_num, ncol = K) 
KS_EAP_linear <- matrix(NA, nrow = N, ncol = K*sim_num) 

set.seed(1112) # Set seed for reproducibility
for (s in 1:sim_num){
  for (i in 1:N) {
    # randomly select one test from the 5 parallel linear item bank
    col_groups <- split(1:ncol(itembank_linear), ceiling((1:ncol(itembank_linear)) / 8))
    selected_linear <- sample(1:length(col_groups), size = 1)
    selected_cols <- col_groups[[selected_linear]]
    
    itembank_0 = itembank_linear[c(((J*s)-(J-1)):(J*s)),selected_cols]
    Q_linear = itembank_0[, c(4,5,6,7), drop = FALSE]
    eta <- ETA(1, KS_0[i,c(((K*s)-3):(K*s))], Q_linear) 
    
    # simulate the responses of examinee
    response <- response_gen(1, itembank_0[,2], itembank_0[,3], eta) 
    KS_EAP_linear[i,c(((K*s)-3):(K*s))] <- EAP_estimation(itembank_0,response,K)
  }
  # The accuracy of attributes estimation
  PCCR_linear[s] <- round(PCCR(KS_0[,c(((K*s)-3):(K*s))],KS_EAP_linear[,c(((K*s)-3):(K*s))]),3)
  ACCR_linear[s,] <- round(ACCR(KS_0[,c(((K*s)-3):(K*s))],KS_EAP_linear[,c(((K*s)-3):(K*s))]),3)
}  

#==============================================================================
#==============================================================================
# Step 4: CD-CAT
# You need to change the values for different conditions 
M0 = M[3]
min_con0 = upper[3]
min_attr0 = min_attr[3]

PCCR_CD_CAT <- numeric(sim_num)
ACCR_CD_CAT <-  matrix(NA, nrow = sim_num, ncol = K) 
KS_EAP_CD_CAT <- matrix(NA, nrow = N, ncol = K*sim_num) 

# Set seed for PWKL & M[1,2,3] reproducibility
# set.seed(19961) 
# set.seed(19962) 
# set.seed(19963) 

# Set seed for JSD & M[1,2,3] reproducibility
# set.seed(19964) 
# set.seed(19965) 
set.seed(19966) 
for (ss in 1:sim_num){
  itembank_CD_CAT0 <- itembank_CD_CAT[,c(((ss*8)-7):(ss*8))]
  used_items_id <- integer(0) 
  used_attr_num <- matrix(0,nrow = 1, ncol = K)
  used_cont_num <- matrix(0,nrow = 1, ncol = S) 
  Q <- itembank_CD_CAT0[,c(4,5,6,7)]
  
  for(i in 1:N){
    # 1. select the first group items 
    # Select first items considering both the content and attribute balancing 
    num_first <- lower*K
    selected_items <- matrix(NA, nrow = num_first, ncol = dim(itembank_CD_CAT0)[2])
    content_areas <- unique(selected_items[, 8])
    while (length(content_areas) < 4) {
      for (ii in 1:K) {
        sub_itembank <- itembank_CD_CAT0[which(itembank_CD_CAT0[, (ii + 3)] == 1), , drop = FALSE]
        selected_items[ii,] <- sub_itembank[sample(1:nrow(sub_itembank), 1), , drop = FALSE]
      }
      content_areas <- unique(selected_items[, 8])
    }
    
    first_items_id <- selected_items[,1]
    
    # 2. update the used item information
    used_items <- itembank_CD_CAT0[which(itembank_CD_CAT0[,1] %in% first_items_id),]
    for(nn in 1:K){
      used_attr_num[,nn] <- sum(used_items[,(nn+3)])
      for(sss in 1:S){
        used_cont_num[,sss] <- nrow(used_items[which(used_items[,8] %in% sss),,drop = FALSE])
      }
    }
    used_items_id <- used_items[,1]
    
    # 3. estimate the responses for the first selected items
    eta <- ETA(1, KS_0[i,c(((K*ss)-3):(K*ss))], used_items[, c(4,5,6,7), drop = FALSE]) 
    response <- response_gen(1, used_items[,2], used_items[,2], eta)
    
    while (length(used_items_id) < M0) { 
      # 4. update the EAP for the current examinee
      KS_EAP_CD_CAT[i,c(((K*ss)-3):(K*ss))] <- EAP_estimation(used_items,response,K)
      
      # 5. defined the unused items 
      unused_items <- itembank_CD_CAT0[!itembank_CD_CAT0[,1] %in% used_items_id,]
      
      # 6. select the next item for the examinee
      # the current KS estimation
      KS_estimate <- KS_EAP_CD_CAT[i, c(((K*ss)-3):(K*ss)), drop = FALSE]
      # (a) posterior-weighted Kullback-Leibler information 
      PWKL_estimation <- PWKLest(K,unused_items,KS_estimate)
      # (b) Jensen-Shannon divergence index
      JSD_estimation <- JSDest(K,unused_items)
      
      #----compute an attribute-balancing index----
      unused_Q <- unused_items[,c(4,5,6,7)]
      attr_weight <- numeric(nrow(unused_items))
      for (tt in 1:nrow(unused_items)) {
        attr_weight[tt] <- prod(((min_attr0 - used_attr_num)/min_attr0)^unused_Q[tt,])
      }
      
      #----compute an content-balancing index----
      cont_weight <- numeric(nrow(unused_items))
      # create a C matrix imitate Q matrix
      C = matrix(0,nrow = nrow(unused_items), ncol = S)
      for (cc in 1:nrow(unused_items)){
        v <-  as.numeric(unused_items[,8])
        C[cc, v[cc]] <- 1  # Update the value to 1 based on the vector
      }
      for (tc in 1:nrow(unused_items)) {
        cont_weight[tc] <- prod(((min_con0 - used_cont_num)/min_con0)^C[tc,])
      }
      
      # Final Item Selection Index (ISI)
      # ISI <- attr_weight*cont_weight*PWKL_estimation
      ISI <- attr_weight*cont_weight*JSD_estimation
      
      selected_next_item_id <- unused_items[which.max(ISI),1]
      selected_next_item <- unused_items[which(unused_items[,1] %in% selected_next_item_id), ,drop = FALSE]
      
      # 7. update the used item information
      used_items_id0 <- c(used_items_id, as.numeric(selected_next_item_id))
      
      used_items <- itembank_CD_CAT0[which(itembank_CD_CAT0[,1] %in% used_items_id0),]
      for(nn in 1:K){
        used_attr_num[,nn] <- sum(used_items[,(nn+3)])
        for(sss in 1:S){
          used_cont_num[,sss] <- nrow(used_items[which(used_items[,8] %in% sss),,drop = FALSE])
        }
      }
      used_items_id <- used_items[,1]
      
      # 8. update the response 
      eat_next <- ETA(1, KS_0[i,c(((K*ss)-3):(K*ss))], selected_next_item[, c(4,5,6,7), drop = FALSE])
      response_next <- response_gen(1, selected_next_item[,2], selected_next_item[,3], eat_next)
      index_next <- which(used_items[,1] %in% selected_next_item_id)
      response <- append(response, response_next, after = index_next-1)
    }
  }
  # The accuracy of attributes estimation
  PCCR_CD_CAT[ss] <- round(PCCR(KS_0[,c(((K*ss)-3):(K*ss))],KS_EAP_CD_CAT[,c(((K*ss)-3):(K*ss))]),3)
  ACCR_CD_CAT[ss,] <- round(ACCR(KS_0[,c(((K*ss)-3):(K*ss))],KS_EAP_CD_CAT[,c(((K*ss)-3):(K*ss))]),3)
}


