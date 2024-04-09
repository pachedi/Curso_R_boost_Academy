
#install.packages("tidyverse")

library(tidyverse)
library(openxlsx)


base <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/potenciar-trabajo-titulares-activos.csv')

#setwd("")

# cargar base con una ventana de selección de archivos
base_nueva <- read.csv(choose.files())

# Dimensiones del df
dim(base)

# nombres de columnas
colnames(base)

# valores unicos de una variable
unique(base$provincia)


# Sumar valores NA
sum(is.na(base$provincia))


# Resumen de datos del df
summary(base)

sum(is.na(base$provincia_id))

# Encabezado con 5 filas
head(base, 5)

# Filtrar 
santa_fe <- base %>%
  dplyr::filter(provincia == "Santa Fe")

# Filtrar por dos valores
SFC <- base %>% 
  filter(provincia == "Santa Fe" | provincia == "Córdoba")


SFC2 <- base %>% 
  filter(provincia %in% c("Santa Fe", "Córdoba"))

unique(santa_fe$provincia)

colnames(santa_fe)

# Descartar variables con select

santa_fe_sinid <- santa_fe %>% 
  dplyr::select(-c(municipio_id, provincia_id, departamento_id))

colnames(santa_fe_sinid)
  
dim(santa_fe_sinid)

head(santa_fe_sinid)  
  
  
colnames(santa_fe)

santa_fe_sinid2 <- santa_fe %>% 
  select(-c(3,5,7))

colnames(santa_fe_sinid2)

# Renombrar variables
santa_fe <- santa_fe %>% 
  rename(cantidad_de_titulares = titulares)

colnames(santa_fe)

head(santa_fe, 3)

#Crear una nueva variable

santa_fe <- santa_fe %>% 
  mutate(titulares_x_2 = cantidad_de_titulares * 2 )

head(santa_fe)

santa_fe <- santa_fe %>% 
  mutate(depto_prov = paste(departamento,provincia , sep="-"))


class(santa_fe$periodo)

# Formato fecha
santa_fe <- santa_fe %>% 
  mutate(periodo = ymd(periodo))

head(santa_fe)

class(santa_fe$periodo)

#Operaciones con fecha
santa_fe$periodo[1] + days(1)

santa_fe$periodo[1] + years(1)

santa_fe$periodo[1] + months(1)

santa_fe <- santa_fe %>% 
  mutate(meses = months(periodo))

head(santa_fe,5)

santa_fe <- santa_fe %>% 
  mutate(meses_n  = month(periodo),
         anio = year(periodo)) 

head(santa_fe)

# Ordenar df por variable
santa_fe_orden <- santa_fe %>% 
  arrange(cantidad_de_titulares)

head(santa_fe_orden)

min(santa_fe_orden$cantidad_de_titulares)

santa_fe_orden <- santa_fe %>% 
  arrange(desc(cantidad_de_titulares))

head(santa_fe_orden)

max(santa_fe_orden$cantidad_de_titulares)


####

colnames(base)

# Crear tabla resumen
promedio <- base %>% 
  summarise(promedio_de_titulares = mean(titulares))

promedio

summary(base)

# Crear tabla resumen con agrupamiento

titulares_x_prov <- base %>% 
  group_by(provincia) %>% 
  summarise(total_titulares = sum(titulares))


titulares_x_prov  <- titulares_x_prov %>% 
  slice(2:nrow(titulares_x_prov))

dim(titulares_x_prov)
  
length(titulares_x_prov)

ncol(titulares_x_prov)
  
nrow(titulares_x_prov)


class(base$periodo)

base <- base %>% 
  mutate(periodo = ymd(periodo),
         anio = year(periodo))


head(base)

unique(base$anio)

# Crear nueva base con bind cols

base_promedio <- base %>% 
  group_by(anio) %>% 
  summarise(promedio_titulares = mean(titulares))

base_promedio

base_promedio <- base %>% 
  group_by(anio, provincia) %>% 
  summarise(promedio_titulares = mean(titulares))

base_promedio_2020 <- base_promedio %>% 
  filter(anio == 2020)

base_promedio_2021 <- base_promedio %>% 
  filter(anio == 2021)

base_promedio_2021 <- base_promedio_2021 %>% 
  slice(-1)

base_promedio_2021 <- base_promedio_2021 %>% 
  select(-provincia)

base_promedio_2021 <- base_promedio_2021 %>%
  rename(anio_21 = anio,
         promedio_titulares_21 = promedio_titulares)


base_promedios_2020_2021 <- bind_cols(base_promedio_2020,base_promedio_2021)


base_promedios_2020_2021 <- base_promedios_2020_2021 %>% 
  mutate(diferencia = round(promedio_titulares_21 - promedio_titulares,2))

#### Left join

contagios <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/catorce_dias_contagios.csv')

poblacion <- read.xlsx('https://github.com/pachedi/INTRO_R_CS/blob/main/poblacion_provincias.xlsx?raw=true')


contagios <- contagios %>% 
  select(-1)

poblacion$provincias[1] <- "CABA"

poblacion$provincias[1]

base_join <- left_join(poblacion, contagios, 
                       by= c("provincias" = "residencia_provincia_nombre"))

contagios <- contagios %>% 
  rename(provincias = residencia_provincia_nombre)

colnames(contagios)

base_join2 <- left_join(poblacion, contagios)

base_join2 <- base_join2 %>% 
  arrange(desc(Total_14_dias))

base_join2 <- base_join2 %>% 
  mutate(cada_100_mil = round(Total_14_dias / poblacion * 100000,2)) %>% 
  arrange(-cada_100_mil)


## transposiciones


tabla_nueva <- base_join2 %>% 
  select(1,4)


tabla_wider <- tabla_nueva %>% 
  pivot_wider(names_from = "provincias", values_from = "cada_100_mil")

tabla_wider

tabla_longer <- tabla_wider %>% 
  pivot_longer(cols= 1:ncol(.),   
               names_to= "PROVINCIAS", values_to= "CONTAGIOS CADA 100 MIL")

tabla_longer


trasp <- t(base_join2)

class(trasp)

tabla <- as.data.frame(t(base_join2))

tabla[1, ]

colnames(tabla) <- tabla[1, ]

tabla <- tabla %>% 
  slice(-1)
  













