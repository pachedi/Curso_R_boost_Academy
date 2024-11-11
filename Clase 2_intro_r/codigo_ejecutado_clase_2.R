
#install.packages("tidyverse")

library(tidyverse)
library(openxlsx)

# Cargar base
base <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/potenciar-trabajo-titulares-activos.csv', encoding = "UTF-8")

#Guardar base en disco local
write.csv(base, "base_potenciar.csv", row.names = FALSE)

#Obtener directorio de trabajo
getwd()

#setwd("C:/Users/dpach/")

# Listar archivos dentro del directorio de trabajo
list.files()


# leer archivo csv
base <- read.csv("base_potenciar.csv")

# leer archivo csv abriendo el explorador 
base_2 <- read.csv(file.choose())


# Dimension del data frame
dim(base)

# Nombre de columnas del df
colnames(base)

# Valores únicos de una columna
unique(base$provincia)

# Resumen del data frame
summary(base)

# Obtener las primeras 3 filas del df
head(base, 3)

# Eliminar un objeto
rm(misiones)

# Crear un filtro
misiones_base <- base %>% 
  filter(provincia == "Misiones")

misiones_base


unique(misiones$provincia)

colnames(misiones_base)

# Seleccionar columnas
misiones_base <- misiones_base %>% 
  select(periodo, provincia, departamento, municipio, titulares)

dim(misiones_base)

colnames(misiones_base)

misiones_base

head(base)

# renombrar columnas
misiones_base <- misiones_base %>% 
  rename(cantidad_de_titulares = titulares)

colnames(misiones_base)

View(misiones_base)

class(misiones_base$periodo)

# Cambiar formato a tipo fecha
misiones_base <- misiones_base %>% 
  mutate(periodo = ymd(periodo))

class(misiones_base$periodo)

?lubridate

# Funciones para trabajar con datos fecha
misiones_base$periodo[1] + days(1)
misiones_base$periodo[1] + months(10)
misiones_base$periodo[1] + years(12)

# Crear nueva columna
misiones_base <- misiones_base %>% 
  mutate(mas_3_meses = periodo + months(3))

# Obtener filas de 1 a 5 y columnas 1 y 6
misiones_base[1:5 , c(1,6)]

misiones_base <- misiones_base %>% 
  mutate(anio = year(periodo))

head(misiones_base)

unique(misiones_base$anio)

# ordenar la base en función de una columna
misiones_base <- misiones_base %>% 
  arrange(cantidad_de_titulares)

head(misiones_base)

# Valor mínimo de una variable
min(misiones_base$cantidad_de_titulares)

# Ordenar de manera descendente
misiones_base <- misiones_base %>% 
  arrange(-cantidad_de_titulares)

head(misiones_base)

# Valor máximo de una columna
max(misiones_base$cantidad_de_titulares)





