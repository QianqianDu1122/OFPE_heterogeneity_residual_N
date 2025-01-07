library(ofpetrial)
library(ggplot2)
library(dplyr)
library(data.table)
library(sf)



###====== Create blocks for trial design ======###
data("td_single_input")

td_with_blocks <- add_blocks(td_single_input)

td_with_blocks$trial_design

viz(td_with_blocks, type = "rate")



###====== assign treatment rates for each subplot ======###

data(exp_data)
exp_data

exp_data$

data(rate_info)
rate_info

td <- assign_rates(exp_data, rate_info) 

viz(td)


###############################################################
###====== Create the trial design based on our demand (Latin Square Trial Design) ======###
###############################################################

n_plot_info <-
  prep_plot(
    input_name = "N",
    unit_system = "imperial",
    machine_width = 30,
    section_num = 1,
    harvester_width = 20,
    headland_length = 30,
    side_length = 60
  )


exp_data <-
  make_exp_plots(
    input_plot_info = n_plot_info,
    boundary_data = system.file("extdata", "boundary-simple1.shp", package = "ofpetrial"),
    abline_data = system.file("extdata", "ab-line-simple1.shp", package = "ofpetrial"),
    abline_type = "free")


plot_info <-
  prep_plot(
    input_name = "N",
    unit_system = "imperial",
    machine_width = 60,
    section_num = 1,
    harvester_width = 30,
    plot_width = 60
  )

rate_info <- prep_rate(
  plot_info,
  gc_rate = 180,
  unit = "lb",
  rates = c(0, 60, 120, 180, 240, 270)
)


###--- create the trial design based on the exp_data and rate_info that we just wrote ---###

td <- assign_rates(exp_data, rate_info) 

viz(td)



###############################################################
###====== Create the trial design based on our demand (Randomized Trial Design) ======###
###############################################################

n_plot_info_R <-
  prep_plot(
    input_name = "N",
    unit_system = "imperial",
    machine_width = 30,
    section_num = 1,
    harvester_width = 20,
    headland_length = 30,
    side_length = 60
  )


exp_data_R <-
  make_exp_plots(
    input_plot_info = n_plot_info_R,
    boundary_data = system.file("extdata", "boundary-simple1.shp", package = "ofpetrial"),
    abline_data = system.file("extdata", "ab-line-simple1.shp", package = "ofpetrial"),
    abline_type = "free")


plot_info_R <-
  prep_plot(
    input_name = "N",
    unit_system = "imperial",
    machine_width = 60,
    section_num = 1,
    harvester_width = 30,
    plot_width = 60
  )

rate_info_R <- prep_rate(
  plot_info,
  gc_rate = 180,
  unit = "lb",
  rates = c(0, 60, 120, 180, 240, 270),
  design_type = "rb"
)


###--- create the trial design based on the exp_data and rate_info that we just wrote ---###

td_R <- assign_rates(exp_data_R, rate_info_R) 

viz(td_R)





#--- change rates of some strips ---#
strip_ids <- 1:5
plot_ids <- 5:10
new_rates <- 200
td_modified <- change_rates(td_single_input, "NH3", strip_ids, plot_ids, new_rates)
#--- visualize ---#
viz(td_modified)
