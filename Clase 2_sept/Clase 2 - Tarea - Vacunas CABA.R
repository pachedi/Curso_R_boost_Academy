
library(openxlsx)
library(tidyverse)
library(stringr)
library(lubridate)
vacunas_caba <- read.csv("../vacunas_caba.csv") %>% 
  select(-(1))
# https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/vacunas_caba.csv

vacunas_caba_fecha <- vacunas_caba %>% 
mutate(FECHA_ADMINISTRACION =  str_sub(vacunas_caba$FECHA_ADMINISTRACION, 1,9))

vacunas_caba_fecha <- vacunas_caba_fecha %>% 
  mutate(FECHA_ADMINISTRACION = dmy(FECHA_ADMINISTRACION))

write.csv(vacunas_caba_fecha, 'vacunas_caba.csv')
####################

sum(vacunas_caba$DOSIS_1)







