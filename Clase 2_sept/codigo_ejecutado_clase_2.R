

library(tidyverse)
library(openxlsx)
library(lubridate)


base <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/potenciar-trabajo-titulares-activos.csv'
                 , encoding = "UTF-8")

# dimensiones de la base
dim(base)

# nombre de las columnas
colnames(base)

#valores unicos de una variable
unique(base$provincia)


# resumen de las variables
summary(base)

# primeras filas de la base
head(base)

# ultimas filas de la base
tail(base)

# filter

mendoza <- base %>% 
  filter(provincia == "Mendoza")

unique(mendoza$provincia)

colnames(mendoza)

## select()

mendoza_select <- mendoza %>% 
  select(periodo, provincia, departamento, municipio, titulares)

colnames(mendoza_select)
head(mendoza_select)

mendoza_select <- mendoza %>% 
  select(1,2,4,6,8)

mendoza_select <- mendoza %>% 
  select(-(c(provincia_id, departamento_id, municipio_id)))

mendoza_select_2 <- mendoza %>% 
  select(c(1:4, 7:8))

head(mendoza_select)

### Rename

colnames(base)

mendoza <- mendoza %>% 
  rename(cantidad_de_titulares = "cantidad de titulares")

colnames(mendoza)

#### Mutate

mendoza <- mendoza %>% 
  mutate(titulares_por_2 =cantidad_de_titulares * 2)

head(mendoza)

class(mendoza$periodo)

mendoza <- mendoza %>% 
  mutate(periodo = ymd(periodo))

class(mendoza$periodo)

mendoza$periodo[1] + days(1)

mendoza$periodo[1] + months(1)

mendoza$periodo[1] + years(10)

mendoza <- mendoza %>% 
  mutate(mes = months(periodo))

head(mendoza)
unique(mendoza$mes)

mendoza <- mendoza %>% 
  mutate(anio = year(periodo))

head(mendoza)
unique(mendoza$anio)

mendoza <- mendoza %>% 
  mutate(mes_n = month(periodo))
head(mendoza)

view(mendoza)

## Arrange

mendoza_ordenado <- mendoza %>% 
  arrange(cantidad_de_titulares)

head(mendoza_ordenado)

mendoza_ordenado <- mendoza %>% 
  arrange(-cantidad_de_titulares)

mendoza_ordenado <- mendoza %>% 
  arrange(desc(cantidad_de_titulares))

head(mendoza_ordenado)

mendoza_ordenado <- mendoza %>% 
  arrange(mes)
head(mendoza_ordenado)

month.name

mendoza_ordenado <- mendoza %>% 
  mutate(mes = factor(mes,
                      levels = month.name))

mendoza_ordenado <- mendoza_ordenado %>% 
  arrange(anio, mes)

head(mendoza_ordenado)

sum(is.na(mendoza_ordenado$mes))

# summarise

promedio_titulares <- mendoza %>% 
  summarise(promedio = mean(cantidad_de_titulares))


promedio_titulares <- promedio_titulares %>% 
  mutate(promedio = as.integer(promedio))

promedio_titulares

## group_by 

datos_provincias <- base %>% 
  mutate(periodo = ymd(periodo)) %>% 
  group_by(provincia, periodo) %>% 
  summarise(total = sum(titulares))

datos_provincias


###

contagios <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/catorce_dias_contagios.csv', encoding='UTF-8')
poblacion <- read.xlsx('https://github.com/pachedi/INTRO_R_CS/blob/main/poblacion_provincias.xlsx?raw=true')

head(contagios)

contagios <- contagios %>% 
  select(-1)



head(poblacion)
## left join
union_base <- left_join(contagios, poblacion, 
                        by= c("residencia_provincia_nombre" = "provincias"))

head(union_base)

# renombrar el valor que no coincide entre las bases
poblacion$provincias[1] = "CABA"
head(poblacion)

view(union_base)

# creamos una nueva variable: contagios cada 100 mil habitantes
union_base <- union_base %>% 
  mutate(contagios_c_100_mil =Total_14_dias / poblacion *100000)

head(union_base)

union_base <- union_base %>% 
  arrange(-contagios_c_100_mil)

union_base

## pivot wider
wider <- union_base %>% 
  select(1,4) %>% 
  pivot_wider(names_from = residencia_provincia_nombre, 
              values_from= contagios_c_100_mil)

wider

## pivot longer
longer <- wider %>% 
  pivot_longer(1:ncol(.), names_to = "Provincia", values_to= "Contagios")

longer

