
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

chaco_sin_id <- chaco_sin_id %>% 
  rename(Fecha = periodo)

colnames(chaco_sin_id)

class(chaco_sin_id$Fecha)

chaco_sin_id <- chaco_sin_id %>% 
  mutate(Fecha = ymd(Fecha))

class(chaco_sin_id$Fecha)

chaco_sin_id <- chaco_sin_id %>% 
  mutate(titulares_x_2 = titulares * 2)

head(chaco_sin_id)

chaco_sin_id$Fecha[1] + days(1)
chaco_sin_id$Fecha[1] + years(10)
chaco_sin_id$Fecha[1] + months(5)

chaco_sin_id <- chaco_sin_id %>% 
  mutate(mes = months(Fecha))

chaco_sin_id <- chaco_sin_id %>% 
  mutate(mes_n = month(Fecha))

chaco_sin_id <- chaco_sin_id %>% 
  mutate(anio = year(Fecha))

unique(chaco_sin_id$anio)

chaco_ordenado_titulares <- chaco_sin_id %>% 
  arrange(titulares)

min(chaco_ordenado_titulares$titulares)
max(chaco_ordenado_titulares$titulares)

chaco_ordenado_titulares <- chaco_ordenado_titulares %>% 
  arrange(desc(titulares))

chaco_ordenado_titulares <- chaco_ordenado_titulares %>% 
  arrange(mes)

meses_nombre <- c("enero", "febrero", "marzo", "abril",
                  "mayo", "junio", "julio","agosto", "septiembre",
                  "octubre", "noviembre", "diciembre")

chaco_ordenado_titulares <- chaco_ordenado_titulares %>% 
  mutate(mes = factor(mes, 
                      levels= meses_nombre))

chaco_ordenado_titulares <- chaco_ordenado_titulares %>% 
  arrange(anio, mes)

promedio <- chaco_sin_id %>% 
  summarise(promedio_titulares = round(mean(titulares),1))

base <- base %>% 
  mutate(periodo = ymd(periodo))

datos_provincias <- base %>% 
  group_by(provincia, periodo) %>% 
  summarise(cant_titulares = sum(titulares))

agrupado_chaco <- datos_provincias %>% 
  filter(provincia == "Chaco")

library(openxlsx)

getwd()
setwd("C:/Users/dpach/OneDrive - sociales.UBA.ar/Curso Introduccion a R CS/Curso_R_boost_Academy/")

write.xlsx(agrupado_chaco, "tabla_chaco.xlsx")


contagios <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/catorce_dias_contagios.csv')

poblacion <- read.xlsx('https://github.com/pachedi/INTRO_R_CS/blob/main/poblacion_provincias.xlsx?raw=true')

contagios <- contagios %>% 
  select(-1)

tabla_fusionada <- left_join(poblacion, contagios,
                             by= c("provincias"="residencia_provincia_nombre"))

contagios <- contagios %>% 
  rename(provincias = residencia_provincia_nombre)

tabla_fusionada2 <- left_join(poblacion, contagios)

poblacion$provincias[1] <- "CABA"

tabla_fusionada3 <- right_join(poblacion, contagios)


tabla_fusionada2 <- tabla_fusionada2 %>% 
  mutate(cant_contagios_100h = as.integer(Total_14_dias / poblacion * 100000))

tabla_fusionada2 <- tabla_fusionada2 %>% 
  arrange(-cant_contagios_100h)


tabla_ancha <- tabla_fusionada2 %>% 
  select(1,4) %>% 
  pivot_wider(names_from= "provincias", values_from = "cant_contagios_100h")
  
ncol(tabla_ancha)

tabla_larga <- tabla_ancha %>% 
  pivot_longer(cols= 1:ncol(.), names_to = "Provincias_arg", values_to ="contagios_100h")
  
  
tabla_trasp <- t(tabla_fusionada2) %>% 
  data.frame()
  
colnames(tabla_trasp) <-  tabla_trasp[1, ]

tabla_trasp  <-  tabla_trasp %>% 
  slice(-1)







