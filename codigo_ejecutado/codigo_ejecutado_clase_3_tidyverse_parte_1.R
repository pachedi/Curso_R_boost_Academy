

### 

#install.packages("tidyverse")
library(tidyverse)

base <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/potenciar-trabajo-titulares-activos.csv',
                 encoding = "UTF-8")

View(base)

dim(base)

dim(base)[1]

dim(base)[2]

nrow(base)

ncol(base)

colnames(base)

unique(base$provincia)

summary(base)

head(base,5)

tail(base)

tail(base, 5)

unique(base["provincia"])


rio_negro <- base %>% 
  filter(provincia == "Río Negro")


dos_provincias_1 <- base %>% 
  filter(provincia == "Río Negro" | provincia == "San Juan")

dos_provincias_2 <- base %>% 
  filter(provincia %in% c("Río Negro", "San Juan"))

provincias_interes <-  c("Río Negro", "San Juan")

dos_provincias_2 <- base %>% 
  filter(provincia %in%  provincias_interes)


provincia_san <- base %>% 
  filter(startsWith(provincia, "San"))

unique(provincia_san$provincia)

?startsWith
?starts_with

termina_es <- base %>% 
filter(endsWith(provincia, "es"))

unique(termina_es$provincia)

unique(rio_negro$periodo)

rio_negro_sin_id <- rio_negro %>% 
  select(periodo, provincia, departamento, municipio, titulares)

head(rio_negro_sin_id)

rio_negro_sin_id <- rio_negro %>% 
  select(-c(provincia_id, municipio_id, departamento_id))

head(rio_negro_sin_id)


jurisdicciones <- rio_negro_sin_id %>% 
  select(2:4)

head(jurisdicciones)

rio_negro_sin_id <- rio_negro_sin_id %>% 
  rename(cantidad_de_titulares = titulares)

colnames(rio_negro_sin_id)

rio_negro_sin_id <- rio_negro_sin_id %>% 
  mutate(titulares_por_2 = cantidad_de_titulares * 2)

head(rio_negro_sin_id)

class(rio_negro_sin_id$periodo)

rio_negro_sin_id <- rio_negro_sin_id %>% 
  mutate(periodo = ymd(periodo))

class(rio_negro_sin_id$periodo)

rio_negro_sin_id$periodo[1] + days(1)

rio_negro_sin_id$periodo[1] + months(1)

rio_negro_sin_id$periodo[1] + years(10)

rio_negro_sin_id <- rio_negro_sin_id %>% 
  mutate(anio = year(periodo))

head(rio_negro_sin_id)

unique(rio_negro_sin_id$anio)






