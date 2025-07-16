
#install.packages("tidyverse")

library(tidyverse)

base <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/potenciar-trabajo-titulares-activos.csv', encoding = "UTF-8")

dim(base)
dim(base)[1]
dim(base)[2]

nrow(base)
ncol(base)

colnames(base)

unique(base$provincia)

sum(is.na(base$provincia))

base <- base %>% 
  filter(provincia != "")

unique(base$provincia)

summary(base)

head(base)

?head


prov_chaco <- base %>% 
  filter(provincia == "Chaco")

unique(prov_chaco$provincia)

chaco_sin_id <- prov_chaco %>% 
  select(periodo, provincia, departamento, municipio, titulares)

colnames(chaco_sin_id)

head(chaco_sin_id)











