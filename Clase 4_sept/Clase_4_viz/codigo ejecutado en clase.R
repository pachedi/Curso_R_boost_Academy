
  library(openxlsx)
  library(tidyverse)
  
  base_1t_2020 <- read.xlsx('https://github.com/pachedi/INTRO_R_CS/blob/main/usu_individual_T120.xlsx?raw=true')


base_recortada <- base_1t_2020 %>% 
  select(CH04, CH06, ESTADO, PONDERA)

head(base_recortada)

sum(base_recortada$PONDERA)

## Tasa de ocupacion
ocupados_1t <- base_recortada %>% 
  summarise(total_poblacion = sum(PONDERA),
            empleados = sum(PONDERA[ESTADO == 1]),
            tasa_empleados = empleados / total_poblacion,
            empleados_porc = tasa_empleados * 100)

ocupados_1t

ocupados_1t <- ocupados_1t %>% 
  mutate(empleados_porc = round(empleados_porc, 2))

ocupados_1t

# tasas del mercado laboral
tasas_mercado_laboral <- base_recortada %>% 
  filter(CH06 %in% 18:70) %>% 
  group_by(CH04) %>% 
  summarise(poblacion = sum(PONDERA),
            ocupados = sum(PONDERA[ESTADO == 1]),
            desocupados = sum(PONDERA[ESTADO == 2]),
            PEA = ocupados + desocupados,
            tasa_empleo = ocupados / poblacion,
            tasa_desempleo = desocupados / PEA)

tasas_mercado_laboral


######## Visualizacion de datos


iris[1:10,]

iris = iris

unique(iris$Species)

#point (scatter plot)
plot(iris$Sepal.Length, type = "p")

# line plot
plot(iris$Sepal.Length, type = "l")

# b = both (line / point)
plot(iris$Sepal.Length, type = "b")

# main = titulo
hist(iris$Sepal.Width, col = "blue", main = "Mi primer histograma")

mtcars

# scatter plot
ggplot(data = mtcars, aes(x = wt, y = hp, color = cyl))+
  geom_point()+
  labs(title = "Peso y potencia de autos")+
  facet_wrap(~vs)

# carga base sube
base_sube <- read.csv("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/dat-ab-usuarios-2020.csv",sep=';', encoding = 'UTF-8')

# filtro amba
base_amba <- base_sube %>% 
  filter(AMBA == "SI")

# total
base_totales <- base_amba %>% 
  filter(TIPO_TRANSPORTE == "TOTAL")

head(base_totales)

# agrupamiento por fecha y genero
filtro_genero <- base_totales %>% 
  group_by(DIA_TRANSPORTE, GENERO) %>% 
  summarise(total_viajes = sum(CANT_TRJ) )

head(filtro_genero)

unique(filtro_genero$GENERO)

# renombrando los valores vacios
filtro_genero$GENERO[filtro_genero$GENERO == ''] <- "Sin_registro"

class(filtro_genero$DIA_TRANSPORTE)

library(lubridate)


# transformo a formato fecha con lubridate
filtro_genero <- filtro_genero %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

class(filtro_genero$DIA_TRANSPORTE)

ggplot(data = filtro_genero, aes(x = DIA_TRANSPORTE,y =total_viajes))+
  geom_line()

ggplot(data = filtro_genero, aes(x = DIA_TRANSPORTE,y =total_viajes))+
  geom_line()+
  facet_wrap(~GENERO)


ggplot(data = filtro_genero, aes(x = DIA_TRANSPORTE,y =total_viajes, 
                                 fill = GENERO, color=GENERO))+
  geom_line()+
  scale_x_date(date_breaks = "1 month")+
  theme_classic()+
  theme(axis.text.x = element_text(angle = 90))
  
p <- ggplot(data = filtro_genero, aes(x = DIA_TRANSPORTE,y =total_viajes, 
                                 fill = GENERO, color=GENERO))+
  geom_line()

p +
  geom_vline(aes(xintercept= as.Date("2020-03-20"),col="ASPO")
             ,linetype="dashed")+
  scale_x_date(date_breaks = "1 month")+
  theme_classic()+
  theme(axis.text.x = element_text(angle = 90))+
  labs(title = "Movilidad tarjeta SUBE 2020",
       subtitle = "Por sexo",
       caption= "Fuente: Base abierta datos SUBE 2020",
       x = "Fecha", y = "Cantidad de viajes")

library(plotly)

# grafico interactivo
mi_grafico <- p +
  scale_y_continuous(breaks= seq(0, 2000000, by = 1000000))+
  geom_vline(aes(xintercept= as.Date("2020-03-20"),col="ASPO")
             ,linetype="dashed")+
  scale_x_date(date_breaks = "1 month")+
  theme_classic()+
  theme(axis.text.x = element_text(angle = 90))+
  labs(title = "Movilidad tarjeta SUBE 2020",
       subtitle = "Por sexo",
       caption= "Fuente: Base abierta datos SUBE 2020",
       x = "Fecha", y = "Cantidad de viajes")

ggplotly(mi_grafico)

# guardo mi grafico
ggsave("plot_sube.png")

# obtengo la carpeta donde se guardo el grafico
getwd()
