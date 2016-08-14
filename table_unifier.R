setwd(".")
library(dplyr)

type_table <- read.csv("car_types.csv", stringsAsFactors = FALSE)
important_addons_table <- read.csv("important_properties_list.csv", stringsAsFactors = FALSE)
general_table <- read.csv("car_specific_properties.csv", stringsAsFactors = FALSE)

final_table <- left_join(left_join(type_table, important_addons_table), general_table)

write.csv(final_table, "final_table.csv", row.names = FALSE)