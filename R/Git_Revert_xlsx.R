#Dit is bedoeld als hoofdstuk om git revert uit te leggen en waarom het niet werkt met excel.

library(tidyverse)
library(gert)

#Maak een nieuwe test branch:
gert::git_branch_create("revert_xlsx_csv")

#Maken Bron bestand----
Revert_Data <- tibble::tibble(
  Changes = c("Basis")
)
write.csv2(Revert_Data,"data-raw/Revert_Data.csv")
xlsx::write.xlsx(Revert_Data,"data-raw/Revert_Data.xlsx")

git_add(".")
git_commit("Maken Bron")

#Eerste Aanpassing----

Revert_Data <- Revert_Data %>%
  add_row(Changes = "Verandering 1")

write.csv2(Revert_Data,"data-raw/Revert_Data.csv")
xlsx::write.xlsx(Revert_Data,"data-raw/Revert_Data.xlsx")

git_add(".")
git_commit("Verandering 1")

#Tweede Aanpassing----

Revert_Data <- Revert_Data %>%
  add_row(Changes = "Verandering 2")

write.csv2(Revert_Data,"data-raw/Revert_Data.csv")
xlsx::write.xlsx(Revert_Data,"data-raw/Revert_Data.xlsx")

git_add(".")
git_commit("Verandering 2")

#Resultaten bekijken
git_log(ref = "revert_xlsx_csv",max = 3)

read.csv2("data-raw/Revert_Data.csv")
xlsx::read.xlsx2("data-raw/Revert_Data.xlsx",sheetIndex = 1)

git_reset_soft()

#Opschonen

git_add(".")
git_commit("Afronden Revert")
git_branch_checkout("master")
git_branch_delete("revert_xlsx_csv")
