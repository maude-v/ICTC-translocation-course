install.packages("pak")
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

#plot with group mean
plot(my_elic_cont, round = 1, var = "var2",
     group = TRUE)

#add data to metadata
#round 2
my_elic_cont <- cont_add_data(my_elic_cont,
                              data_source = round_2,
                              round = 2)

#plot raw values next to round 1
library(gridExtra)

plot(my_elic_cont, round = 2,var = "var2",
     group = TRUE)

grid.arrange(plot(my_elic_cont, round = 1, var = "var2",
                  group = TRUE),
             plot(my_elic_cont, round = 2,var = "var2",
                  group = TRUE),
             nrow = 1)

#sample from group data
samp_cont <- cont_sample_data(my_elic_cont, round = 2)

#view sampled data
samp_cont

#plot as violin
grid.arrange(plot(my_elic_cont, round = 2,var = "var2",
                  group = TRUE),
             plot(samp_cont, var = "var2", type = "density"),
             plot(samp_cont, var = "var2", type = "density",
                  group = TRUE),
             nrow = 2)

#plot as violin with group mean
plot(samp_cont, var = "var2", type = "density",
     group = TRUE)

#plot as violin with group mean and truth?
plot(samp_cont, var = "var2", type = "violin",
     truth = list(min = 10, max = 20, best = 15))
