
# Obtener directorio de trabajo
getwd()

# Configurar directorio de trabajo
setwd("C:/Users/dpach/OneDrive - sociales.UBA.ar/Curso Introduccion a R CS/Bases de datos/")


getwd()

# Cargar base
base <- read.csv("potenciar-trabajo-titulares-activos.csv")

# Cargar base a través de link
vacunas_caba <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/vacunas_caba.csv')

# Cargar librerias
library(tidyverse)
library(openxlsx)

# Manejo de valores faltantes o NA

con_na <- c(NA, 10, NA, 9, 20, NA, 5)

con_na[1]

# Identificar valores faltantes
is.na(con_na)

# Sumar cantidad de valores faltantes
sum(is.na(con_na))

# omitir valores faltantes
sin_na <- na.omit(con_na)

# Reemplazar valores faltantes por 0
con_na[is.na(con_na)] <- 0

con_na

####


base <- read.csv("potenciar-trabajo-titulares-activos.csv")

getwd()

# Remover un objeto
rm(sin_na)

####

unique(base$provincia)

corrientes <- base %>% 
  filter(provincia == "Corrientes")

class(corrientes$periodo)

# Transformar una variable en formato fecha
corrientes <- corrientes %>% 
  mutate(periodo = ymd(periodo))

class(corrientes$periodo)

corrientes$periodo[1] + days(1)

# Crear nueva variable extrayendo el mes
corrientes <- corrientes %>% 
  mutate(mes = months(periodo))

head(corrientes)
# Crear nueva variable extrayendo el año
corrientes <- corrientes %>% 
  mutate(anio = year(periodo))

head(corrientes)

# Crear nueva variable extrayendo el mes (numérico)
corrientes <- corrientes %>% 
  mutate(mes_n = month(periodo))

head(corrientes)


# Summarise 

promedio_titulares <- base %>% 
  summarise(promedio_titulares = mean(titulares))

promedio_titulares
 
# Promedio agrupando por provincia
promedio_provincias <- base %>% 
  group_by(provincia) %>% 
  summarise(promedio = mean(titulares))

# Promedio agrupando por provincia y periodo        
promedio_provincias <- base %>% 
  group_by(provincia, periodo) %>% 
  summarise(promedio = mean(titulares))
  
jujuy <- base %>% 
  filter(provincia == "Jujuy" & departamento == "Cochinoca")


colnames(jujuy)

jujuy <- jujuy %>% 
  arrange(desc(titulares))


promedio_provincias$provincia[1]

sum(is.na(promedio_provincias$provincia))

# Filtramos por valores "distinto a"
promedio_provincias <- promedio_provincias %>% 
  filter(provincia != "")

promedio_provincias

###
library(openxlsx)
?read.xlsx

contagios <- read.csv("catorce_dias_contagios.csv")

poblacion <- read.xlsx("poblacion_provincias.xlsx")

contagios <- contagios %>% 
  select(-1)

# Renombramos la columna en común
contagios <- contagios %>% 
  arrange(desc(Total_14_dias)) %>% 
  rename(provincias = residencia_provincia_nombre)

# Fusionamos bases por columna en común
base_unida_2 <- left_join(poblacion, contagios)

#base_unida <- left_join(poblacion, contagios, 
#                         by= c("provincias" = "residencia_provincia_nombre")) 

# Cambiamos el nombre de la categoría para que sea igual en ambas tablas
poblacion$provincias[1] <- "CABA"

base_unida_2 <- left_join(poblacion, contagios)


# Obtenemos una nueva variable a partir de la fusión de tablas
base_unida_2 <- base_unida_2 %>% 
  mutate(contagios_100_mil = Total_14_dias / poblacion * 100000) %>% 
  arrange(-contagios_100_mil)

head(base_unida_2)

# Pivot wider
wider <- base_unida_2 %>% 
  select(1,4) %>% 
  pivot_wider(names_from = "provincias", values_from = "contagios_100_mil")

# Pivot longer
longer <- wider %>% 
  pivot_longer(cols= 1:24, names_to = "Provincias", values_to = "Contagios100")





