library(openxlsx)
library(tidyverse)
library(lubridate)

# Cargamos la base
base_sube <- read.csv("usuarios_sube-2020.csv", sep=";")

unique(base_sube$GENERO)

unique(base_sube$AMBA)

# Filtramos por AMBA
base_amba <- base_sube %>% 
  filter(AMBA == "SI")

# Filtramos por totales
filtro_totales <- base_amba %>% 
  filter(TIPO_TRANSPORTE == "TOTAL") %>% 
  mutate(CANT_TRJ = as.numeric(CANT_TRJ))

# Creamos una nueva tabla agrupada por día y género
filtros_genero <- filtro_totales %>% 
  group_by(DIA_TRANSPORTE, GENERO) %>% 
  summarise(viajes_totales = sum(CANT_TRJ))

# Gráfico simple de linea
plot(filtros_genero$viajes_totales, type="l")

# Transformamos a formato fecha
filtros_genero <- filtros_genero %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

class(filtros_genero$DIA_TRANSPORTE)

# Grafico de linea viajes por dia
ggplot(data = filtros_genero, aes(x = DIA_TRANSPORTE, 
                                  y=viajes_totales))+
  geom_line()

# Nombramos el valor vacío por "sin registro"
filtros_genero$GENERO[filtros_genero$GENERO == ""] <- "Sin_registro"

unique(filtros_genero$GENERO)

# Creamos un gráfico por cada categoría de genero
ggplot(data = filtros_genero, aes(x = DIA_TRANSPORTE, 
                                  y=viajes_totales))+
  geom_line()+
  facet_wrap(~GENERO)

# Agregamos breaks cada 1 mes / Giramos las fechas para que entren
ggplot(data = filtros_genero, aes(x = DIA_TRANSPORTE, 
                                  y=viajes_totales))+
  geom_line()+
  scale_x_date(date_breaks = "1 month")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90))

# Creamos vectores con colores y etiquetas
colores <- c("red","blue","violet","green","yellow")
etiquetas <- c("ASPO", "Femenino","Masculino","Promedio", 
               "Sin registro")

# Agregamos colores, etiquetas, breaks en el eje y
ggplot(data = filtros_genero, aes(x = DIA_TRANSPORTE, 
                                  y=viajes_totales,color=GENERO))+
  geom_line()+
  scale_x_date(date_breaks = "1 month")+
  geom_vline(aes(xintercept= as.Date("2020-03-20"), col="ASPO"),
             linetype= "dashed")+
  geom_hline(aes(yintercept= mean(viajes_totales), col="Promedio"),
             linetype="dashed")+
  scale_color_manual(name="Referencias",values=colores,
                     labels=etiquetas)+
  scale_y_continuous(breaks=seq(0,2000000,by=300000))+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90))+
  labs(title = "Movilidad diaria tarjeta SUBE 2020",
       x = "Fecha", y = "Cantidad de viajes",
       caption = "Fuente: Elaboración propia en base a datos SUBE")


#install.packages("plotly")

library(plotly)

# Guardamos el plot en un objeto
plot <- ggplot(data = filtros_genero, aes(x = DIA_TRANSPORTE, 
                                          y=viajes_totales,color=GENERO))+
  geom_line()+
  scale_x_date(date_breaks = "1 month")+
  geom_vline(aes(xintercept= as.Date("2020-03-20"), col="ASPO"),
             linetype= "dashed")+
  geom_hline(aes(yintercept= mean(viajes_totales), col="Promedio"),
             linetype="dashed")+
  scale_color_manual(name="Referencias",values=colores,
                     labels=etiquetas)+
  scale_y_continuous(breaks=seq(0,2000000,by=300000))+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90))+
  labs(title = "Movilidad diaria tarjeta SUBE 2020",
       x = "Fecha", y = "Cantidad de viajes",
       caption = "Fuente: Elaboración propia en base a datos SUBE")

# Lo hacemos interactivo
ggplotly(plot)

# Guardamos el grafico interactivo en formato html
htmltools::save_html(
  html = htmltools::as.tags(
    x = plotly::toWebGL(plot),
    standalone = TRUE),
  file = "plot_sube.html")

# Guardamos el gráfico estatico 
ggsave("grafico_sube.png", width = 16, height =8)

getwd()

########### Grafico de Columnas #########

# Eliminamos los valores vacios en genero y motivo de descuento

totales_descuento <- filtro_totales %>% 
  filter(GENERO %in% c("M", "F"),
         MOTIVO_ATSF != "")

unique(totales_descuento$MOTIVO_ATSF)

# Creamos una nueva tabla con los totales de los viajes
# agrupado por género

descuentos_agrupado <- totales_descuento %>% 
  group_by(GENERO, MOTIVO_ATSF) %>% 
  summarise(Total = sum(CANT_TRJ))

# Creamos grafico de columnas
ggplot(data= descuentos_agrupado, aes(x=MOTIVO_ATSF,
                                      y=Total))+
  geom_col()

# Quitamos la notación científica
options(scipen= 999)

# Invertimos los ejes x e y
ggplot(data= descuentos_agrupado, aes(x=MOTIVO_ATSF,
                                      y=Total))+
  geom_col()+
  coord_flip()

# Ordenamos en función de la variable Total
ggplot(data= descuentos_agrupado, aes(x= reorder(MOTIVO_ATSF,-Total),
                                      y=Total))+
  geom_col()+
  coord_flip()

# Separamos las columnas por genero
ggplot(data= descuentos_agrupado, aes(x= reorder(MOTIVO_ATSF,-Total),
                                      y=Total, fill=GENERO))+
  geom_col(position = position_dodge(),
           color= "black")+
  coord_flip()+
  theme_minimal()+
  labs(title = "Cantidad de viajes por sexo año 2020",
       x="Tipo de descuento", y="Cantidad de viajes",
       caption = "Fuente: Elaboración propia en base a datos SUBE")+
  theme(axis.text.x = element_text(angle = 90))



ggplot(data= descuentos_agrupado, aes(x= reorder(MOTIVO_ATSF,-Total),
                                      y=Total, fill=GENERO))+
  geom_col(color= "black")+
  coord_flip()+
  theme_minimal()+
  labs(title = "Cantidad de viajes por sexo año 2020",
       x="Tipo de descuento", y="Cantidad de viajes",
       caption = "Fuente: Elaboración propia en base a datos SUBE")+
  theme(axis.text.x = element_text(angle = 90))











