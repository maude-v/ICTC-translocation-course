install.packages(c("pak", "gridExtra"))
pak::pak("CREWdecisions/elicitr")

library(elicitr)

#create metadata object
my_elic_cont <- cont_start(var_names = c("var1", "var2", "var3"),
                           var_types = "ZNp",
                           elic_types = "134",
                           experts = 6)

#check metadata
my_elic_cont

#add data to metadata
#round 1
my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = round_1,
                              round = 1)

#check loaded metadata
my_elic_cont

#plot raw values
plot(my_elic_cont, round = 1, var = "var2")

#add data to metadata
#round 2
my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = round_2,
                              round = 2)

#plot raw values next to round 1
library(gridExtra)

plot(my_elic_cont, round = 2,var = "var2")

#sample from group data
samp_cont <- cont_sample_data(my_elic_cont, round = 2)

#view sampled data
samp_cont

#plot as density vs round 2 raw data
grid.arrange(plot(my_elic_cont, round = 2,var = "var2",
                  group = TRUE),
             plot(samp_cont, var = "var2", type = "density",
                  group = TRUE),
             nrow = 1)

#plot as density vs round 2 raw data + truth
grid.arrange(plot(my_elic_cont, round = 1,var = "var2",
                  group = TRUE,
                  truth = list(min = 10, max = 20, best = 15)),
             plot(my_elic_cont, round = 2,var = "var2",
                  group = TRUE,
                  truth = list(min = 10, max = 20, best = 15)),
             nrow = 1)
