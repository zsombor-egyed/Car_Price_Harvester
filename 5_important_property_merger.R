cars <- list.files("./important_properties_list/")
overall_property_list <- c()

for (car in cars){
  print(car)
  property_elements <- tryCatch(read.csv(paste0("./important_properties_list/", car), stringsAsFactors = FALSE), error = function(e){"M"})
  if (property_elements != "M"){
    overall_property_list <- unique(c(overall_property_list, property_elements[,1]))
  }
}

overall_property_list <- sort(overall_property_list)

property_frame <- data.frame(matrix(0, length(cars), (length(overall_property_list) + 1)))

colnames(property_frame) <- c("ID", overall_property_list)

i <- 0
for (car in cars){
  i <- i + 1
  print(i)
  property_elements <- tryCatch(read.csv(paste0("./important_properties_list/", car) , stringsAsFactors = FALSE), error = function(e){"M"})
  if (property_elements != "M"){
    for (p in property_elements){
      property_frame[i, p] <- 1
    }
  }
  property_frame[i, 1] <- strsplit(car, ".csv")[[1]][1]
}

write.csv(property_frame, file = "important_properties_list.csv", row.names = FALSE)
