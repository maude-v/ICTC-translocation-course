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

#add data to metadata
#round 1
my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = "albatross_round1.xlsx",
                              round = 1)

my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = "albatross_round1_nd.xlsx",
                              round = 1)

#check loaded metadata
my_elic_cont
#plot raw values
plot(my_elic_cont, round = 1, var = "survival")

#add data to metadata
#round 2
my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = "albatross_round2_nd.xlsx",
                              round = 2)

plot(my_elic_cont, round = 2,var = "survival")

#sample from group data
samp_cont <- cont_sample_data(my_elic_cont, round = 2)

#view sampled data
samp_cont

#plot as density vs round 2 raw data
library(gridExtra)
grid.arrange(plot(my_elic_cont, round = 2,var = "survival",
                  group = TRUE),
             plot(samp_cont, var = "survival", type = "density",
                  group = TRUE),
             nrow = 1)

#plot as density vs round 2 raw data + truth
grid.arrange(plot(my_elic_cont, round = 1,var = "survival",
                  group = TRUE,
                  truth = list(min = 10, max = 20, best = 15)),
             plot(my_elic_cont, round = 2,var = "survival",
                  group = TRUE,
                  truth = list(min = 10, max = 20, best = 15)),
             nrow = 1)
