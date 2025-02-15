## code to prepare `DATASET` dataset goes here

Pokemon <- tibble::as_tibble(read.csv(file.path(system.file(package = "JvD.Cheatsheet"),"data-raw","pokemon.csv")))

usethis::use_data(Pokemon, overwrite = TRUE)
