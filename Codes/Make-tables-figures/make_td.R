library(ofpetrial)
library(ggplot2)
library(dplyr)
library(data.table)
library(sf)



###====== Create blocks for trial design ======###
data("td_single_input")

td_with_blocks <- add_blocks(td_single_input)

td_with_blocks$trial_design

viz(td_with_blocks, type = "block_id")




###====== assign treatment rates for each subplot ======###

data(exp_data)
exp_data

data(rate_info)
rate_info

td <- assign_rates(exp_data, rate_info)

viz(td)

#--- change rates of some strips ---#
strip_ids <- 1:5
plot_ids <- 5:10
new_rates <- 200
td_modified <- change_rates(td_single_input, "NH3", strip_ids, plot_ids, new_rates)
#--- visualize ---#
viz(td_modified)
