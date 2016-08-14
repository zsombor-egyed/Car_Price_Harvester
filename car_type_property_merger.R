
cars <- list.files("./car_type_property_tables/")

car_types <- data.frame(matrix("", length(cars), 4), stringsAsFactors = FALSE)

colnames(car_types) <- c("ID",
                         "Type",
                         "Producer",
                         "Subtype")

i <- 0
for (car in cars){
  i <- i + 1
  print(car)
    property_tab <- tryCatch(read.csv(paste0("./car_type_property_tables/", car), stringsAsFactors = FALSE), error = function(e){"NA"})
    if (property_tab !="NA"){
      car_types$ID[i] <- strsplit(car, ".csv")[[1]][1]
      car_types[i,2:4] <- property_tab[,1]
  } 
}

write.csv(car_types, "car_types.csv", row.names = FALSE)