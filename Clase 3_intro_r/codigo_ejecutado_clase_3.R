library(tidyverse)
# Respuesta a consulta por la tarea
base_vacunas <- read.csv("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/vacunas_caba.csv")

# Identificar valores faltantes
is.na(base_vacunas$DOSIS_3)

# Crear columna con valores TRUE o FALSE según
# es faltante o no
base_vacunas$DOSIS_3_NA = is.na(base_vacunas$DOSIS_3)

# Sumatorio de valores faltantes
sum(is.na(base_vacunas$DOSIS_3))

# reemplazar valores faltantes por 0
base_vacunas$DOSIS_3[is.na(base_vacunas$DOSIS_3)] = 0

sum(is.na(base_vacunas$DOSIS_3))

# Reemplazar categorías por códigos
base_codificado <- base_vacunas %>% 
  mutate(GENERO_2 = case_when(GENERO == "F" ~ 0,
                              GENERO == "M" ~ 1))


base_codificado <- base_codificado %>% 
  select(GENERO, GENERO_2)

base_vacunas$GENERO[base_vacunas$GENERO == "M"] = 1
base_vacunas$GENERO[base_vacunas$GENERO == "F"] = 0

####

library(tidyverse)

base <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/potenciar-trabajo-titulares-activos.csv', encoding = "UTF-8")

colnames(base)

# Crear base nueva con el promedio de los titulares
promedio <- base %>% 
  summarise(promedio = mean(titulares))

promedio

summary(base)

# Promedio de titulares agrupado por provincia
datos_provincias <- base %>% 
  group_by(provincia) %>% 
  summarise(promedio = mean(titulares))

print(datos_provincias)

View(datos_provincias)

class(base$periodo)

# Agrupamiento por año y provincia
base_nueva <- base %>% 
  mutate(periodo = ymd(periodo),
         anio = year(periodo)) %>% 
  group_by(anio, provincia) %>% 
  summarise(promedio = round(mean(titulares),2))

head(base_nueva)

unique(base_nueva$anio)

dim(base_nueva)

# Eliminar valores vacíos
sin_vacio <- base_nueva %>% 
  filter(provincia != "" )

# eliminar filas
nuevo <- base_nueva %>% 
  slice(-25)

unique(base$provincia)

# Filtrar por valores de un vector
patagonia <- c("Chubut", "Río Negro", "Santa Cruz", "Tierra del Fuego",
               "Neuquén")

base_patagonia <- base_nueva %>% 
  filter(provincia %in% patagonia)

###
library(openxlsx)

contagios <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/catorce_dias_contagios.csv')


poblacion <- read.xlsx('https://github.com/pachedi/INTRO_R_CS/blob/main/poblacion_provincias.xlsx?raw=true')



contagios_ordenada <- contagios %>% 
  arrange(-Total_14_dias)

# Realizar join de tablas
tabla_unida <- left_join(contagios, poblacion,
                         by= c("residencia_provincia_nombre" = "provincias"))

poblacion$provincias[1] <- "CABA"

poblacion$provincias[1]

tabla_unida <- left_join(contagios, poblacion,
                         by= c("residencia_provincia_nombre" = "provincias"))

tabla_unida <- tabla_unida %>% 
  select(-1) %>% 
  slice(-23)

tabla_unida <- tabla_unida %>% 
  mutate(cada_100_mil = as.integer(Total_14_dias / poblacion * 100000)) %>% 
  arrange(desc(cada_100_mil))

tabla_unida

# Pivor wider
tabla_wider <- poblacion %>% 
  pivot_wider(names_from = "provincias", values_from = "poblacion")

tabla_wider

# Pivot longer
base_longer <- tabla_wider %>% 
  pivot_longer(cols = 1:ncol(.), names_to = "nombres_provincias",
               values_to = "numero_poblacion")

base_longer

# Transposición
transposicion <- t(base_longer)

class(transposicion)

transposicion <- as.data.frame(t(base_longer))

colnames(transposicion)

transposicion[1,  ]

colnames(transposicion) <- transposicion[1,  ]

transposicion <- transposicion %>% 
  slice(-1)

t(transposicion)


######## Visualización de datos

iris

iris <- iris

unique(iris$Species)

summary(iris)

# Gráfico de puntos
plot(iris$Sepal.Width, type = "p")

# Gráfico de líneas
plot(iris$Petal.Width, type= "l")

# Ambos
plot(iris$Petal.Width, type= "b")

# Histograma
hist(iris$Sepal.Width, col="red",
     main= "Mi primer histograma")

# Guardar histograma
ruta <- "mi_histograma.png"
png(ruta)
hist(iris$Sepal.Width, col="red",
     main= "Mi primer histograma")
dev.off()

getwd()
setwd("C:/Users/dpach/")

mtcars = mtcars

#Crear gráfico con ggplot()
ggplot(data= mtcars, aes(x=wt, y=hp, col= cyl))+
  geom_point()+
  #facet_wrap(~vs)+
  labs(title="Autos peso y potencia")








