install.packages(c("pak", "gridExtra"))
pak::pak("CREWdecisions/elicitr")

library(elicitr)

#create metadata object
my_elic_cont <- cont_start(var_names = c("survival"),
                           var_types = "p",
                           elic_types = "4",
                           experts = 11)

#check metadata
my_elic_cont

#round 1
#add data to metadata
my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = "albatross_round1.xlsx",
                              round = 1)

#remove first column from dataset
my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = "albatross_round1_nd.xlsx",
                              round = 1)

#check loaded metadata
my_elic_cont

#plot raw values for round 1
plot(my_elic_cont, round = 1, var = "survival")

#round 2
#add data to metadata
my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = "albatross_round2_nd.xlsx",
                              round = 2)

#plot raw values for round 2
plot(my_elic_cont, round = 2,var = "survival")

#sample from group data of round 2
samp_cont <- cont_sample_data(my_elic_cont, round = 2, n_votes = 1000)

#view sampled data
View(samp_cont)

#compare round 2 raw data and sampled group density mean
library(gridExtra)
grid.arrange(plot(my_elic_cont, round = 2,var = "survival",
                  group = TRUE),
             plot(samp_cont, var = "survival", type = "density",
                  group = TRUE),
             nrow = 1)

#compare round 1&2 raw data, group mean & truth
grid.arrange(plot(my_elic_cont, round = 1,var = "survival",
                  group = TRUE,
                  truth = list(min = 0.05, max = 0.25, best = 0.15, conf = 100)),
             plot(my_elic_cont, round = 2,var = "survival",
                  group = TRUE,
                  truth = list(min = 0.05, max = 0.25, best = 0.15, conf = 100)),
             nrow = 1)

#compare sampled group density mean and round 2 raw data, group mean & truth
grid.arrange(plot(samp_cont, var = "survival", type = "density",
                  group = TRUE),
             plot(my_elic_cont, round = 2,var = "survival",
                  group = TRUE,
                  truth = list(min = 0.05, max = 0.25, best = 0.15, conf = 100)),
             nrow = 1)

summary(sample_cont)
