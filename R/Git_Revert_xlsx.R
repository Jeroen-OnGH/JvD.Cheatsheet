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

#Ik ga nu even wat acties doen die niet in Gert staan
#Mijn globale advies is, blijf bij gert, het doet alles wat je wilt, en wat het niet kan wil je in Azure oplossen.
#Echter breek ik hier even deze regel voor makkelijk tutoriallen.

#Ik verwijder nu alleen verandering 1:
system("git revert b1ab70e124db35390b177149eccafbe2187ae98b")

#Met een text of .R:
file.create("R/Verandering.R")
write_lines(c("Verandering 0"),"R/Verandering.R",append = TRUE)
git_add(".")
git_commit("Verandering 0")
write_lines(c("Verandering_1"),"R/Verandering.R",append = TRUE)
git_add(".")
git_commit("Verandering 1")
write_lines(c("Verandering_2"),"R/Verandering.R",append = TRUE)
git_add(".")
git_commit("Verandering 2")

git_log(ref = "revert_xlsx_csv",max = 3)
hash_1 <- git_log(ref = "revert_xlsx_csv",max = 3)[2,1]
Terminal_Command <- paste0("git revert ",hash_1)
system(Terminal_Command)
#Opschonen

git_reset_hard()
git_branch_checkout("master")
git_branch_delete("revert_xlsx_csv")

#In het kort,
#veel te ingewikkeld.
#maar goed dat er naar is gekeken.
#we gaan gewoon door met git reset.

git_reset_soft()
#changes back to a previous commit, but does not change anything in the files.
#Thus it will keep all changes in git pane

git_reset_mixed()
