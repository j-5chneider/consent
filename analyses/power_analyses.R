library(tidyverse)
library(brms)

############################################################################## #
## Create function to simulate data                                         ####
############################################################################## #
simulate_data <- function(n_per_cell) {
  return(
    expand_grid(                   # create 2x3 grid with combination of
      data_sharing = c(0,1),       # factor 1 "data sharing"
      data_type = c(0,1,2)) %>%    # factor 2 "data type"
    slice(                         # grab row...
      rep(1:n(),                   # from 1 to end of grid
          each = n_per_cell)) %>%  # repeat each n_per_cell times
    dplyr::mutate(                 # create dummy for data_type
        data_type_interview = ifelse(data_type == 1, 1, 0),
        data_type_video = ifelse(data_type == 2, 1, 0),
        perceived_sensitivity_z = as.numeric(scale(rnorm(n(), 3.5, 1.2))), # create perceived_sensitivity (which is totally normally distributed) and standardize
        eta = 0 +
          0.0  * data_sharing +   # no main effect of data_sharing (I know, I could drop this)
          0.1 * data_sharing * data_type_interview +  # very small effect of data_type_interview
          0.35 * data_sharing * data_type_video +  # small effect of data_type_video
          0.5  * perceived_sensitivity_z +  # medium effect of perceived_sensitivity_z
          0.35 * data_sharing * perceived_sensitivity_z, # small to medium interaction effect
        willingness_participate_z = rnorm(n(), # simulate outcome
                                          mean = eta, # with predicted eta
                                          sd = .5))   # and some noise
    )
}






# loop for poweranalyse
# summarize power


n_per_cell_from <- 30
n_per_cell_to <- 55
n_per_cell_step <- 5
n_sim <- 1000


# create empty results data frame for power results
results_power <- data.frame(BF_concl_sharing = as.numeric(),
                            BF_concl_sharing_interview = as.numeric(),
                            BF_concl_sharing_video = as.numeric(),
                            Post.Prob_sharing = as.numeric(),
                            Post.Prob_sharing_interview = as.numeric(),
                            Post.Prob_sharing_video = as.numeric())

for (sample_size in seq(n_per_cell_from, n_per_cell_to, n_per_cell_step)) {
  # create empty results data frame for this sample size
  results_n <- data.frame(Evid.Ratio_sharing = as.numeric(),
                          Evid.Ratio_sharing_interview = as.numeric(),
                          Evid.Ratio_sharing_video = as.numeric(),
                          Post.Prob_sharing = as.numeric(),
                          Post.Prob_sharing_interview = as.numeric(),
                          Post.Prob_sharing_video = as.numeric())
  
  for (i in 1:n_sim) {
    set.seed(sample_size + i)
    data_sim <- simulate_data(sample_size)
    fit <- brm(
      formula = bf(willingness_participate_z ~ data_sharing * data_type_interview + 
                     data_sharing * data_type_video +
                     data_sharing * perceived_sensitivity_z),
      data = data_sim,
      family = gaussian(),
      chains = 4,
      cores = 4,
      iter = 4000,
      warmup = 1000,
      control = list(adapt_delta = 0.95))
    
    
    hyp_sharing <- brms::hypothesis(fit, "abs(data_sharing) < .10") # Using ROPE according to ...
    hyp_sharing_interview <- brms::hypothesis(fit, 
                                              c("data_sharing:data_type_interview > 0", # between 0 and .15
                                                "data_sharing:data_type_interview < 0.15"))
    hyp_sharing_video <- brms::hypothesis(fit, "data_sharing:data_type_video > 0") # Using ROPE according to ...
    
    results_n <- results_n %>%
      add_row(Evid.Ratio_sharing = hyp_sharing$hypothesis$Evid.Ratio[1],
              Evid.Ratio_sharing_interview = hyp_sharing_interview$hypothesis$Evid.Ratio[1],
              Evid.Ratio_sharing_video = hyp_sharing_video$hypothesis$Evid.Ratio[1],
              Post.Prob_sharing = hyp_sharing$hypothesis$Post.Prob[1], 
              Post.Prob_sharing_interview = hyp_sharing_interview$hypothesis$Post.Prob[1], 
              Post.Prob_sharing_video = hyp_sharing_video$hypothesis$Post.Prob[1])
  }

  # summarize results and add row  
  results_power <- results_power %>%
    add_row(sample_size = sample_size,
            BF_concl_sharing = mean(results_n$Evid.Ratio_sharing >= 5),
            BF_concl_sharing_interview = mean(results_n$Evid.Ratio_sharing_interview >= 5),
            BF_concl_sharing_video = mean(results_n$Evid.Ratio_sharing_video >= 5),
            Post.Prob_sharing = mean(results_n$Post.Prob_sharing),
            Post.Prob_sharing_interview = mean(results_n$Post.Prob_sharing_interview),
            Post.Prob_sharing_video = mean(results_n$Post.Prob_sharing_video))
}


results_power %>%
  dplyr::select(sample_size,
                BF_concl_sharing,
                BF_concl_sharing_interview,
                BF_concl_sharing_video) %>%
  pivot_longer(2:4, names_to = "predictor", values_to = "power") %>%
  ggplot(aes(sample_size, power, colour = predictor)) +
    geom_line(size=1, alpha = .7) +
    geom_hline(colour = "red", size = 2, yintercept = 0.8) +
    scale_color_viridis_d() +
    scale_y_continuous(limits = c(0,1)) +
    theme_minimal()
