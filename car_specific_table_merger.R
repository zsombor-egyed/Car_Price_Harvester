harvested_tables <- list.files("./car_specific_tables/")

position <- unlist((lapply(strsplit(harvested_tables, ''), function(x) which(x == '_'))))
page_origin <- as.numeric(substr(harvested_tables, 1, position - 1))
indices <- unique(page_origin)

for (i in indices){
  print(i)
  proper_tables <- harvested_tables[page_origin == i]
  flag  <- 0
  for (p in proper_tables){
    input_table <- tryCatch(read.csv(paste0("./car_specific_tables/", p), stringsAsFactors = FALSE), error = function(e){"M"})
    input_table <- data.frame(input_table, stringsAsFactors = FALSE)
    if (nrow(input_table)>5){
      if (flag == 0){
        output_table <- input_table
        flag <- 1
      }
      else{
        output_table <- rbind(output_table,input_table)
      }
    }
  }
  write.csv(output_table,file = paste0("./binded_tables/", i, ".csv"), row.names = FALSE)
}
