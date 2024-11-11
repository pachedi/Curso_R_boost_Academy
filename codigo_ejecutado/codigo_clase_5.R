library(tidyverse)
library(openxlsx)
library(lubridate)


vacunas_caba <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/vacunas_caba.csv')
#Crear una tabla que exprese el total de 2das 
# dosis aplicadas por año y mes


class(vacunas_caba$FECHA_ADMINISTRACION)

vacunas_caba <- vacunas_caba %>% 
  mutate(FECHA_ADMINISTRACION = ymd(FECHA_ADMINISTRACION))

class(vacunas_caba$FECHA_ADMINISTRACION)


year(vacunas_caba$FECHA_ADMINISTRACION[1])

month(vacunas_caba$FECHA_ADMINISTRACION[1])

vacunas_caba <- vacunas_caba %>% 
  mutate(anio = year(FECHA_ADMINISTRACION))

months(vacunas_caba$FECHA_ADMINISTRACION)

vacunas_caba$mes <- months(vacunas_caba$FECHA_ADMINISTRACION)

month.name

meses_esp <- c("enero", "febrero", "marzo", "abril", "mayo",
               "junio", "julio", "agosto", "septiembre", "octubre",
               "noviembre", "diciembre")


vacunas_mes <- vacunas_caba %>% 
  group_by(anio, mes) %>% 
  summarise(total = sum(DOSIS_2)) %>% 
  mutate(mes = factor(mes, levels=meses_esp )) %>% 
  arrange(anio, mes)

##

base_sube <- read.csv("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/dat-ab-usuarios-2020.csv",sep=';', encoding = 'UTF-8')

unique(base_sube$AMBA)

base_amba <- base_sube %>% 
  filter(AMBA == "SI")

base_totales <- base_sube %>% 
  filter(AMBA == "SI" & TIPO_TRANSPORTE == "TOTAL")

base_totales <- base_amba %>% 
  filter(TIPO_TRANSPORTE == "TOTAL")

base_totales <- base_totales %>% 
  select(-c("AMBA", "DATO_PRELIMINAR"))

head(base_totales)

class(base_totales$DIA_TRANSPORTE)

base_totales <- base_totales %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))
  
class(base_totales$DIA_TRANSPORTE)

total_agrupado <- base_totales %>% 
  group_by(DIA_TRANSPORTE) %>% 
  summarise(cantidad_viajes = sum(CANT_TRJ))

options(scipen = 999)

plot(total_agrupado$cantidad_viajes, type="l")

ggplot(data= total_agrupado)+
  aes(x= DIA_TRANSPORTE,
      y=cantidad_viajes)+
  geom_line()

total_agrupado <- base_totales %>% 
  group_by(DIA_TRANSPORTE, GENERO) %>% 
  summarise(cantidad_viajes = sum(CANT_TRJ))

unique(total_agrupado$GENERO)

total_agrupado$GENERO[total_agrupado$GENERO == ""] <- "no_registrado"

ggplot(data = total_agrupado, 
       aes(x=DIA_TRANSPORTE,
          y= cantidad_viajes))+
  geom_line()+
  facet_wrap(~GENERO)


ggplot(data = total_agrupado, 
       aes(x=DIA_TRANSPORTE,
           y= cantidad_viajes))+
  geom_line()+
  scale_x_date(date_breaks = "1 month")+
  theme(axis.text.x = element_text(angle= 90))


ggplot(data = total_agrupado, 
       aes(x=DIA_TRANSPORTE,
           y= cantidad_viajes))+
  geom_line()+
  scale_x_date(position = "top")+
  theme_minimal()


ggplot(data=total_agrupado,aes(x=DIA_TRANSPORTE,
                               y=cantidad_viajes,
                               col=GENERO))+
  geom_line()+
  geom_vline(aes(xintercept= as.Date("2020-03-20")), 
             col="black", linetype = "dashed")+
  geom_hline(aes(yintercept= mean(cantidad_viajes)),
             linetype="dashed",col= "red")+
  theme_minimal()+
  labs(title = "Movilidad del AMBA",
       subtitle = "2020",
       caption="Fuente: Datos abiertos SUBE",
       x="Cantidad de viajes",
       y= "Fecha")+
  scale_x_date(breaks = "1 month")+
  theme(axis.text.x = element_text(angle=90))

ggsave("grafico_sube.png", width = 16, height = 8)
getwd()
install.packages("plotly")
library(plotly)


p <- ggplot(data=total_agrupado,aes(x=DIA_TRANSPORTE,
                               y=cantidad_viajes,
                               col=GENERO))+
  geom_line()+
  geom_vline(aes(xintercept= as.Date("2020-03-20")), 
             col="black", linetype = "dashed")+
  geom_hline(aes(yintercept= mean(cantidad_viajes)),
             linetype="dashed",col= "red")+
  theme_minimal()+
  labs(title = "Movilidad del AMBA",
       subtitle = "2020",
       caption="Fuente: Datos abiertos SUBE",
       x="Cantidad de viajes",
       y= "Fecha")+
  scale_x_date(breaks = "1 month")+
  theme(axis.text.x = element_text(angle=90))

ggplotly(p)

htmltools::save_html(
  html= htmltools::as.tags(
    x= plotly::toWebGL(p),
    standalone=TRUE),
  file="plot_interactivo.html")
    
htmlwidgets::saveWidget(p, "plot.html")

getwd()

# Grafico de barras

unique(base_totales$MOTIVO_ATSF)

motivo_descuento <- base_totales %>% 
  filter(GENERO == "M" | GENERO == "F") %>% 
  filter(MOTIVO_ATSF != "")


descuento_octubre <- motivo_descuento %>% 
  filter(DIA_TRANSPORTE >= "2020-10-01" &
           DIA_TRANSPORTE < "2020-11-01")


octubre_agrupado <- descuento_octubre %>% 
  group_by(MOTIVO_ATSF) %>% 
  summarise(Total = sum(CANT_TRJ))

ggplot(data= octubre_agrupado, aes(
  x= reorder(MOTIVO_ATSF, Total),
  y=Total))+
  geom_col()+
  coord_flip()

ggplot(data= octubre_agrupado, aes(
  x= reorder(MOTIVO_ATSF, -Total),
  y=Total))+
  geom_col()+
  coord_flip()


octubre_agrupado_g <- descuento_octubre %>% 
  group_by(MOTIVO_ATSF, GENERO) %>% 
  summarise(Total = sum(CANT_TRJ))
  
ggplot(data=octubre_agrupado_g,
       aes(x= reorder(MOTIVO_ATSF, Total),
           y= Total,
           fill= GENERO))+
  geom_col()+
  coord_flip()
  
  
ggplot(data=octubre_agrupado_g,
       aes(x= reorder(MOTIVO_ATSF, Total),
           y= Total,
           fill= GENERO))+
  geom_col(position= position_dodge(),
           color="black")+
  coord_flip()+
  labs(x="Motivo de descuento",
       y="Cantidad de viajes")+
  theme_minimal()

  
unique(octubre_agrupado$MOTIVO_ATSF)
  
  


