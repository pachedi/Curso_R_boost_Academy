library(tidyverse)
library(lubridate)
library(openxlsx)
options(scipen=999)

# Levantamos la base SUBE
base_sube <- read.csv("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/dat-ab-usuarios-2020.csv",sep=';', encoding = 'UTF-8')

# Para levantar la base desde nuestro disco local
base_sube <- read.csv(file.choose(), sep=";")

# Obtener valores únicos de una columna
unique(base_sube$MOTIVO_ATSF)

# Filtramos por AMBA
base_amba <- base_sube %>% 
  filter(AMBA == 'SI')

# Filtramos por los totalos
base_totales <- base_amba %>% 
  filter(TIPO_TRANSPORTE == 'TOTAL')

# Agrupamos por fecha obteniendo el total de viajes por día
filtro_totales <- base_totales %>% 
  group_by(DIA_TRANSPORTE) %>% 
  summarise(total_viajes = sum(CANT_TRJ))

class(filtro_totales$DIA_TRANSPORTE)

# Modificamos la columna fecha para que tenga el formato correcto
filtro_totales <- filtro_totales %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

class(filtro_totales$DIA_TRANSPORTE)

# Gráfico con el total de viajes por día
ggplot(data = filtro_totales, aes(x=DIA_TRANSPORTE, y=total_viajes))+
  geom_line()
  
# Agrupamos por fecha y por genero obteniendo el total 
# de viajes por día por género
filtro_genero <- base_totales %>% 
  group_by(DIA_TRANSPORTE,GENERO) %>% 
  summarise(total_viajes = sum(CANT_TRJ)) %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

# modificamos los valores '' por la categoría "sin registro"
filtro_genero$GENERO[filtro_genero$GENERO == ''] <- "sin_registro"


# obtenemos 1 gráfico por cada categoría de la variable GENERO
ggplot(data = filtro_genero, aes(x=DIA_TRANSPORTE, y=total_viajes))+
  geom_line()+
  facet_wrap(~GENERO)

# Obtenemos un gráfico con 1 línea por categoría de GENERO
ggplot(data = filtro_genero, aes(x=DIA_TRANSPORTE, y=total_viajes,
                                 color= GENERO))+
  geom_line()+
  labs(title = "Movilidad SUBE 2020", x = "Fecha", y ="Cantidad de viajes",
       caption = "Fuente: Base abierta SUBE 2020")+
  scale_color_manual(name="GENERO",values=c("F"="black",
                                            M="red", 
                                            sin_registro="yellow"),
                     labels = c("Femenino", "Masculino","SR"))+
  theme_grey()

library(plotly)

# Guardamos el gráfico en un objeto p
p <- ggplot(data = filtro_genero, aes(x=DIA_TRANSPORTE, y=total_viajes,
                                      color= GENERO))+
  geom_line()+
  labs(title = "Movilidad SUBE 2020", x = "Fecha", y ="Cantidad de viajes",
       caption = "Fuente: Base abierta SUBE 2020")+
  scale_color_manual(name="GENERO",values=c("F"="black",
                                            M="red", 
                                            sin_registro="yellow"),
                     labels = c("Femenino", "Masculino","SR"))+
  theme_classic()

# Lo convertimos en interactivo con la función ggplotly
ggplotly(p)

# Guardamos nuestro gráfico en un archivo .html

htmltools::save_html(
  html = htmltools::as.tags(
    x = plotly::toWebGL(p),
    standalone = TRUE),
  file = "plot_sube.html")

# Guardamos en formato excel la tabla procesada
write.xlsx(filtro_genero, "base_sube_procesada.xlsx")



