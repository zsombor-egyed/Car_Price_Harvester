library(XML)
library(plyr) 
library(RCurl)

for (i in 1:7000){
  print(i)
  url <- paste0("http://www.hasznaltauto.hu/talalatilista/auto/",
                "SC2ZW2KHPYQMT2DHP263GFD267PUUQTH0IRC035H67PMIA6",
                "FEPAUE8ZUOHKSOZJJEL7ZQH7J07007PUI526AEOJEA0MJR7",
                "8IP4DF9ZGD5P270KZ5Q3O34GQDQK0GZ0Q4AGA51HK4FJA/page", i)

  link_set <- htmlParse(url)
  links <- xpathSApply(link_set, "//a/@href")

  links <- unique(links[grepl("w.hasznaltauto.hu/auto/", links) == TRUE])
  subpage_counter <- 0
  for (l in links[1:10]){
  
    subpage_counter <- subpage_counter + 1
    adcode <- (i - 1)* 10 + subpage_counter
    
    car_specific_webpage  <- getURL(l)
    car_specific_lists <- readHTMLList(car_specific_webpage)
    specific_list_control <- length(car_specific_lists)
    
    important_properties_list <- c()
    if (specific_list_control > 3){
      for (s in 4:(specific_list_control - 1)){
          if (length(car_specific_lists[[s]]) > 1 &  !("Adatlap QR kódja" %in% car_specific_lists[[s]])){
            important_properties_list <- c(important_properties_list, car_specific_lists[[s]])
          }
      
      }
    }
    
    car_type <- strsplit(strsplit(links[1],"http://www.hasznaltauto.hu/auto/")[[1]][2],"/")[[1]][2]
  
    car_maker <- strsplit(strsplit(links[1],"http://www.hasznaltauto.hu/auto/")[[1]][2],"/")[[1]][1]
    
    car_subtype <- strsplit(strsplit(links[1],"http://www.hasznaltauto.hu/auto/")[[1]][2],"/")[[1]][3]
    
    car_type_properties <- c(car_type,car_maker,car_subtype)
  
    car_type_properties <- data.frame(car_type_properties)
  
    important_properties_list <- data.frame(important_properties_list)
  
    car_specific_tables <- readHTMLTable(car_specific_webpage)

    tables_length <- length(car_specific_tables)
  
    for (t in 1:tables_length){
      write.csv(car_specific_tables[[t]], file = paste0("./car_specific_tables/", adcode, "_", t, ".csv"), row.names = FALSE)
    }
    
    write.csv(important_properties_list, file = paste0("./important_properties_list/", adcode, ".csv"), row.names = FALSE)
    write.csv(car_type_properties, file = paste0("./car_type_property_tables/", adcode, ".csv"), row.names = FALSE)
  }
}

