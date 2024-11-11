
library(tidyverse)
library(openxlsx)
options(scipen=999)

#Cargar base
base_sube <- read.csv("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/dat-ab-usuarios-2020.csv", sep=";", encoding = 'UTF-8')

unique(base_sube$AMBA)

summary(base_sube)

# Filtrar base
amba <- base_sube %>% 
  filter(AMBA == "SI" ) #  & TIPO_TRANSPORTE == "TOTAL"

unique(amba$AMBA)

# Transformar en tipo fecha
amba <- amba %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

class(amba$DIA_TRANSPORTE)

min(amba$DIA_TRANSPORTE)
max(amba$DIA_TRANSPORTE)

# Filtrar por totales
amba_total <- amba %>% 
  filter(TIPO_TRANSPORTE == "TOTAL")

unique(amba_total$TIPO_TRANSPORTE)

#Agrupamiento por día
total_viajes <- amba_total %>% 
  group_by(DIA_TRANSPORTE) %>% 
  summarise(total_tarjetas = sum(CANT_TRJ))

# plot básico
plot(total_viajes$total_tarjetas, type="l")

# plot viajes x dia
ggplot(data= total_viajes, aes(x=DIA_TRANSPORTE, y=total_tarjetas))+
  geom_line()

unique(amba_total$GENERO)

# renombrar los valores vacíos
amba_total$GENERO[amba_total$GENERO== ""] <- "sin_registrar"

# agrupamiento por genero
total_viajes2 <- amba_total %>% 
  group_by(DIA_TRANSPORTE, GENERO) %>% 
  summarise(total_tarjetas = sum(CANT_TRJ))

# un grafico por genero
ggplot(data=total_viajes2, aes(x=DIA_TRANSPORTE,
                               y=total_tarjetas))+
  geom_line()+
  facet_wrap(~GENERO)

#guardar el grafico en un objeto
p <- ggplot(data=total_viajes2, aes(x=DIA_TRANSPORTE,
                               y=total_tarjetas))+
  geom_line(aes(col= GENERO))+
  geom_vline(aes(xintercept=as.Date("2020-03-20"),col="ASPO"),
             linetype="dashed")+
  scale_x_date(date_breaks = "1 month")+
  #theme_classic()+
  #theme_dark()+
  #theme_minimal()+
  theme_gray()+
  theme(axis.text.x= element_text(angle=90))+
  labs(title = "Movilidad SUBE 2020",
       subtitle = "AMBA",
       x="Fecha", y="Total de viajes",
       caption="Fuente: Elaboración propia en base a datos SUBE")+
  scale_color_manual(name="Referencias:",
                     values=c(ASPO = "black",
                              "F"= "red",
                              "M" = "green",
                              sin_registrar= "blue"))


print(p)

getwd()

#setwd("")
# guardar grafico en imagen
ggsave("mi_grafico_sube.png")

#install.packages("plotly")

library(plotly)

#transformar en interactivo
ggplotly(p)

#guardar en formato html
htmltools::save_html(
  html = htmltools::as.tags(
    x = plotly::toWebGL(p),
    standalone = TRUE),
  file = "plot_sube.html")

### Grafico de columnas

# eliminar los vacios de tarifa social
sin_vacios <- amba_total  %>% 
  filter(MOTIVO_ATSF != "")

unique(sin_vacios$MOTIVO_ATSF)

unique(sin_vacios$GENERO)

# filtramos por mes de abril
tarifa_social_abril <- sin_vacios %>% 
  filter(DIA_TRANSPORTE >= "2020-04-01" & 
           DIA_TRANSPORTE <= "2020-04-30")

min(tarifa_social_abril$DIA_TRANSPORTE)
max(tarifa_social_abril$DIA_TRANSPORTE)

# agrupamos por motivo tarifa social
agrupado_ts <- tarifa_social_abril %>% 
  group_by(MOTIVO_ATSF) %>% 
  summarise(total_viajes = sum(CANT_TRJ))

# graficamos
ggplot(data= agrupado_ts, aes(x= MOTIVO_ATSF, 
                              y= total_viajes))+
  geom_col()+
  coord_flip()

# eje x reordenado
ggplot(data= agrupado_ts, aes(x= reorder(MOTIVO_ATSF,
                                         -total_viajes), 
                              y= total_viajes))+
  geom_col()+
  coord_flip()

# agrupado por genero
agrupado_genero <- tarifa_social_abril %>% 
  group_by(MOTIVO_ATSF,GENERO) %>% 
  summarise(total_viajes = sum(CANT_TRJ))

write.xlsx(agrupado_genero, "tarjetas_genero.xlsx")

# separar las columnas por genero
ggplot(agrupado_genero, aes(x=reorder(MOTIVO_ATSF,
                                      total_viajes), 
                            y=total_viajes))+
  geom_col(aes(fill=GENERO),
           col="black",
           position=position_dodge())+
  coord_flip()

# calcular porcentajes
datos_porcentajes <- tarifa_social_abril %>% 
  group_by(MOTIVO_ATSF) %>% 
  summarise(total = sum(CANT_TRJ),
            varones_n = sum(CANT_TRJ[GENERO == "M"]),
            mujeres_n = sum(CANT_TRJ[GENERO == "F"]),
            Varones = round(varones_n / total * 100,2),
            Mujeres = round(mujeres_n / total *100,2)) %>% 
  select(MOTIVO_ATSF, Varones, Mujeres) %>% 
  pivot_longer( col=2:3, names_to = "GENERO", values_to="Porcentaje")

# graficar porcentajes
ggplot(data = datos_porcentajes)+
  geom_col(aes(x= MOTIVO_ATSF, y= Porcentaje, fill=GENERO),
           col="black",
           position = position_dodge())+
  coord_flip()+
  labs(title = "Porcentaje de viajes con tarifa social por género",
       subtitle = "Abril 2020 AMBA",
       x="Tipo de tarifa social",
       caption="Fuente: Elaboración propia en base a datos abiertos SUBE")+
  theme_minimal()




