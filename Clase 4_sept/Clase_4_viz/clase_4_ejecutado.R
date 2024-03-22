
library(tidyverse)
library(plotly)
library(openxlsx)

# Cargar base mtcars
mtcars
mtcars <- mtcars

# Grafico de puntos
ggplot(data = mtcars, aes(x= wt , y= hp, col= cyl))+
  geom_point(alpha= 0.5)+
  facet_wrap(~vs)+
  labs(title= "Peso y potencia de los autos")


# Cargar iris
iris <- iris


unique(iris$Species)  

# Grafico de puntos
plot(iris$Sepal.Width, type="p")

# Grafico de linea
plot(iris$Sepal.Width, type="l")

# Puntos y linea
plot(iris$Sepal.Width, type="b")


?plot
# Histograma
hist(iris$Sepal.Width, col="red", main="Histograma iris")

# Cargar base sube
base_sube <- read.csv("usuarios_sube-2020.csv", sep=";")
base_sube <- read.csv("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/dat-ab-usuarios-2020.csv",sep=';', encoding = 'UTF-8')

# Exploramos
unique(base_sube$MOTIVO_ATSF)

unique(base_sube$GENERO)

unique(base_sube$AMBA)

# Filtro AMBA
base_amba <- base_sube %>% 
  filter(AMBA == "SI")

# Filtro totales
base_amba <- base_amba %>% 
  filter(TIPO_TRANSPORTE == "TOTAL")

# Cambiar a tipo fecha
base_amba <- base_amba %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

class(base_amba$DIA_TRANSPORTE)

# Agrupar por dia sumando cantidad de viajes
base_totales <- base_amba %>% 
  group_by(DIA_TRANSPORTE) %>% 
  summarise(total_viajes = sum(CANT_TRJ))

options(scipen=999)

# Plot por dia
plot(base_totales$total_viajes, type= "l")

# plot de linea
ggplot(data = base_totales, aes(x=DIA_TRANSPORTE,
                                y= total_viajes))+
  geom_line()

# Agrupamos por genero también
base_totales <- base_amba %>% 
  group_by(DIA_TRANSPORTE, GENERO) %>% 
  summarise(total_viajes = sum(CANT_TRJ))


# Facet wrap por genero
ggplot(data = base_totales, aes(x=DIA_TRANSPORTE,
                                y= total_viajes))+
  geom_line()+
  facet_wrap(~GENERO)

# Creamos break por mes

ggplot(data = base_totales, aes(x=DIA_TRANSPORTE,
                                y= total_viajes))+
  geom_line()+
  scale_x_date(date_breaks = "1 month")+
  theme_minimal()+
  theme(axis.text.x= element_text(angle = 90))
  
# Reemplazamos los vacios por no registrado
base_totales$GENERO[base_totales$GENERO == ""] <- "no_registrado"

unique(base_totales$GENERO)


# Otra manera de cambiar las categorias con case_when()
base_totales2 <- base_totales %>%
 mutate(GENERO = case_when(GENERO == "no_registrado" ~ "NO_REGISTRADO",
                           GENERO == "F" ~ "Femenino",
                           GENERO == "M" ~ "Masculino"))

# Agregamos titulos, nombre de variables y fuente
ggplot(data = base_totales, aes(x=DIA_TRANSPORTE,
                                y= total_viajes, col=GENERO))+
  geom_line()+
  geom_vline(aes(xintercept= as.Date("2020-03-20")), linetype = "dashed")+
  scale_x_date(date_breaks = "1 month")+
  theme_minimal()+
  theme(axis.text.x= element_text(angle = 90))+
  labs(title = "Movilidad transacciones SUBE",
       subtitle = "Año 2020",
       x= "Fecha", y= "Transacciones por día",
       caption= "Fuente: Elaboración propia en base a datos SUBE")


#install.packages("plotly")
library(plotly)


# lo guardamos en un objeto y convertimos en interactivo
grafico <- ggplot(data = base_totales, aes(x=DIA_TRANSPORTE,
                                y= total_viajes, col=GENERO))+
  geom_line()+
  geom_vline(aes(xintercept= as.Date("2020-03-20")), linetype = "dashed")+
  scale_x_date(date_breaks = "1 month")+
  theme_minimal()+
  theme(axis.text.x= element_text(angle = 90))+
  labs(title = "Movilidad transacciones SUBE",
       subtitle = "Año 2020",
       x= "Fecha", y= "Transacciones por día",
       caption= "Fuente: Elaboración propia en base a datos SUBE")

ggplotly(grafico)

# guardamos grafico con ggsave
ggsave("grafico_sube.png", grafico)

getwd()


# Para grafico de columnas

# Filtramos solo Femenino y masculino
total_sin_na <- base_amba %>% 
  filter(GENERO == "M" | GENERO == "F")

# filtramos mes abril
mes_abril <- total_sin_na %>% 
  filter(DIA_TRANSPORTE >= "2020-04-01" & DIA_TRANSPORTE <= "2020-04-30")

# Agrupamos por motivo de descuento y genero
descuento_abril <- mes_abril %>% 
  group_by(MOTIVO_ATSF,GENERO) %>% 
  summarise(total = sum(CANT_TRJ))


# Creamos el grafico de columnas
ggplot(data= descuento_abril, aes(x= reorder(MOTIVO_ATSF, -total), y= total, fill=GENERO
                                  ))+
  geom_col(col="black",
           position = position_dodge())+
  coord_flip()+
  labs(title="Cantidad de transacciones con descuento",
       subtitle = "SUBE abril de 2020",
       caption= "Fuente: Elaboración propia en base a datos SUBE",
       x= "Motivo de descuento", y = "Cantidad de transacciones")+
  theme_minimal()



