

#install.packages("tidyverse")

#Cargo librerias
library(tidyverse)
library(openxlsx)

# Cargo la base a mi ambiente
base <- read.csv("potenciar-trabajo-titulares-activos.csv",
                 encoding = "UTF-8")

# Obtengo las dimensiones de mi DF
dim(base)

# Nombre de columnas del DF
colnames(base)


base$provincia

# Valores únicos de una columna
unique(base$provincia)

# Valores resumen de las variables
summary(base)


class(base$provincia)

# Encabezado de la tabla
head(base)

# Ultimos registro de la tabla
tail(base)

# Filtro por una provincia
catamarca <- base %>% 
  filter(provincia == "Catamarca")

unique(catamarca$provincia)

colnames(catamarca)

# Selecciono columnas
catamarca_sinid <- catamarca %>% 
  select(periodo, provincia, departamento, municipio, titulares)

colnames(catamarca_sinid)

# Renombrar columna
catamarca_sinid <- catamarca_sinid %>% 
  rename(cantidad_de_titulares = titulares)

# Crear una nueva columna a partir de los datos originales
catamarca_sinid <- catamarca_sinid %>% 
  mutate(titulares_por_dos =  cantidad_de_titulares * 2)


head(catamarca_sinid)


class(base$periodo)

#install.packages("lubridate")

#Libreria para el trabajo con fechas
library(lubridate)


class(catamarca$periodo)

# Transformo a tipo fecha
catamarca <-  catamarca %>% 
  mutate(periodo = ymd(periodo))

class(catamarca$periodo)

# Operaciones sobre una fecha
catamarca$periodo[1] + days(1)
catamarca$periodo[1] + years(1)
catamarca$periodo[1] - months(10)

# Nueva columna que indica los meses (con nombre)
catamarca <- catamarca %>% 
  mutate(meses = months(periodo))

# Nueva columna que extrae el año de la fecha
catamarca <- catamarca %>% 
  mutate(anio = year(periodo))

# Nueva columna que extrae el numero de mes
catamarca <- catamarca %>% 
  mutate(mes_n = month(periodo))

# Ordena tabla en función de una variable
catamarca_ordenado <- catamarca %>% 
  arrange(titulares)

head(catamarca_ordenado)

# Valor minimo
min(catamarca_ordenado$titulares)

# Valor maximo
max(catamarca_ordenado$titulares)

# Ordenar de manera descendente
catamarca_ordenado <- catamarca %>% 
  arrange(desc(titulares))

catamarca_ordenado <- catamarca %>% 
  arrange(-titulares)

head(catamarca_ordenado)


catamarca_ordenado <- catamarca %>% 
  arrange(meses)

head(catamarca_ordenado)

# Creo un vector con los meses por orden
nom_meses <- c("enero","febrero","marzo","abril", "mayo",
               "junio", "julio", "agosto","septiembre", "octubre",
               "noviembre", "diciembre")

# Factorizo la variable meses para que utilice el orden del vector
catamarca <- catamarca %>% 
  mutate(meses = factor(meses, nom_meses)) %>% 
  arrange(anio,meses)

unique(catamarca$anio)

  head(catamarca)

# Nueva tabla resumen con promedio
promedio_titulares <- base %>% 
  summarise(promedio = mean(titulares))

promedio_titulares

# Agrupamiento por provincias y promedio de titulares
promedio_provincia <- base %>% 
  group_by(provincia) %>% 
  summarise(promedio = mean(titulares)) %>% 
  arrange(-promedio)

# Filtro los valores vacíos
promedio_provincia <- promedio_provincia %>% 
  filter(provincia != "")


catamarca <- catamarca %>% 
  select(c(8,1:7, 9:11))

# Mover una columna
catamarca <- catamarca %>% 
  relocate(3, .after = 1)


