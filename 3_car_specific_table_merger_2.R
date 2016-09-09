cars <- list.files("./binded_tables/")
overall_property_list <- c()

for (car in cars){
  print(car)
  property_table <- tryCatch(read.csv(paste0("./binded_tables/", car), stringsAsFactors = FALSE), error = function(e){"M"})
  if (property_table != "M"){
    overall_property_list <- unique(c(overall_property_list, property_table[,1]))
  }
}

overall_property_list <- sort(overall_property_list)

property_frame <- data.frame(matrix(0, length(cars), (length(overall_property_list) + 1)))
colnames(property_frame) <- c("ID", overall_property_list)

i <- 0
for (car in cars){
  i <- i + 1
  print(i)
  property_table <- tryCatch(read.csv(paste0("./binded_tables/", car), stringsAsFactors = FALSE), error = function(e){"M"})
  if (property_table != "M"){
    for (p in property_table[, 1]){
      property_frame[i, p] <- property_table[p == property_table[, 1], 2]
    }
  }
  property_frame[i, 1] <- strsplit(car, ".csv")[[1]][1]
}

write.csv(property_frame,file = "car_specific_properties.csv",row.names = FALSE)
