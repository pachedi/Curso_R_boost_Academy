library(tidyverse)
library(openxlsx)


base <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/potenciar-trabajo-titulares-activos.csv', encoding = "UTF-8")

base_ordenada <- base %>% 
  arrange(titulares)

head(base_ordenada)

min(base_ordenada$titulares)

max(base_ordenada$titulares)

base_ordenada <- base_ordenada %>% 
  arrange(desc(titulares))


## Summarise

promedio <- base %>% 
  summarise(promedio_titulares = round(mean(titulares),2))

summary(base)

promedio_provincias <- base %>% 
  group_by(provincia) %>% 
  summarise(promedio = round(mean(titulares), 2)) %>% 
  arrange(-promedio)

##

contagios <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/catorce_dias_contagios.csv')

poblacion <- read.xlsx('https://github.com/pachedi/INTRO_R_CS/blob/main/poblacion_provincias.xlsx?raw=true')

contagios <- contagios %>% 
  select(-1)

contagios <- contagios %>% 
  rename(provincias = residencia_provincia_nombre)

poblacion$provincias[1] <- "CABA"

#tabla_unida <- left_join(poblacion, contagios, by="provincias")

tabla_unida2 <- left_join(poblacion, contagios, 
                         by= c("provincias" = "residencia_provincia_nombre"))


tabla_unida <- tabla_unida %>% 
  arrange(-Total_14_dias)

head(tabla_unida)

tabla_unida <- tabla_unida %>% 
  mutate(cada_100_mil = round((Total_14_dias / poblacion) *100000,2)) %>% 
  arrange(-cada_100_mil)


wider <- tabla_unida %>%
  select(1,4) %>% 
  pivot_wider(names_from = "provincias", values_from = "cada_100_mil")


longer <- wider %>% 
  pivot_longer(cols= 1:ncol(.), names_to = "Provincias", values_to = "Contagios")

t(wider)


tabla_nueva <-  t(longer)

colnames(tabla_nueva) <-  tabla_nueva[1, ] 

tabla_nueva <- as.data.frame(tabla_nueva)

tabla_nueva <- tabla_nueva %>% 
  slice(2)


mil_base <- base %>% 
  slice(1:1000)

mil_base <- head(base, 200)

otra_base <- base %>% 
  slice(c(1,100,20:50))


contagios <- contagios %>% 
  slice(-23) %>% 
  select(-residencia_provincia_nombre)


union_columnas <- bind_cols(poblacion, contagios)



base_a <- poblacion %>% 
  slice(1:12) %>% 
  rename(cantidad_poblacion = poblacion)

base_b <- poblacion %>% 
  slice(13:24)

apilar_bases <- bind_rows(base_b, base_a)













