library(tidyverse)
library(openxlsx)
#install.packages("plotly")
library(plotly)
options(scipen=999)

# ggplot2 


iris <- iris

summary(iris)

dim(iris)

unique(iris$Species)

class(iris$Species)

plot(iris$Sepal.Width, type="p")

plot(iris$Sepal.Width, type="l")

plot(iris$Sepal.Width, type="b")

hist(iris$Sepal.Width, col="blue", main="Mi histograma")

ruta_png <- "mi_histograma.png"
png(ruta_png)
hist(iris$Sepal.Width, col="red", main="Histograma")
hist(iris$Sepal.Width, col="blue", main="Histograma")
dev.off()

getwd()

##

mtcars <- mtcars

ggplot(data = mtcars, aes(x = wt , y= hp, col=cyl))+
  geom_point(alpha= 0.3)+
  labs(title="Peso y potencia de los autos",
       subtitle = "Base MTCARS")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))


ggplot(data = mtcars, aes(x = wt , y= hp, col=cyl))+
  geom_point(alpha= 0.8)+
  facet_wrap(~vs)+
  labs(title="Peso y potencia de los autos",
       subtitle = "Base MTCARS")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

######


base_sube <- read.csv("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/dat-ab-usuarios-2020.csv",sep=';', encoding = 'UTF-8')

summary(base_sube)

unique(base_sube$MOTIVO_ATSF)

unique(base_sube$AMBA)


base_amba <- base_sube %>% 
  filter(AMBA == "SI")

base_sube$AMBA[1] == "SI"

unique(base_amba$AMBA)

class(base_amba$DIA_TRANSPORTE)

base_amba <- base_amba %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

class(base_amba$DIA_TRANSPORTE)

unique(base_amba$GENERO)

base_amba$GENERO[base_amba$GENERO == "sin_registrar"] <- "Sin registrar"

unique(base_amba$GENERO)

base_totales <- base_amba %>% 
  filter(TIPO_TRANSPORTE == "TOTAL")

dia_agrupado <- base_totales %>% 
  group_by(DIA_TRANSPORTE,GENERO) %>% 
  summarise("Total de viajes" = sum(CANT_TRJ))

plot(dia_agrupado$`Total de viajes`, type="l")


ggplot(data=dia_agrupado, aes(x=DIA_TRANSPORTE, 
                              y= `Total de viajes`))+
  geom_line()+
  facet_wrap(~GENERO)


ggplot(data=dia_agrupado, aes(x=DIA_TRANSPORTE, 
                              y= `Total de viajes`))+
  geom_line()+
  scale_x_date(date_breaks = "1 month", position="top")+
  theme(axis.text.x= element_text(angle= 45))
  
  
ggplot(data=dia_agrupado, aes(x=DIA_TRANSPORTE, 
                              y= `Total de viajes`,
                              color=GENERO))+
  geom_line()+
  geom_vline(aes(xintercept = as.Date("2020-03-20"), col="Aislamiento"),
             linetype="dashed")+
  scale_x_date(date_breaks = "1 month")+
  theme_minimal()+
  theme(axis.text.x= element_text(angle= 90))+
  labs(x="Fecha", title="Cantidad de viajes por día",
       subtitle="Área Metropolitana de Buenos Aires",
       caption="Fuente: Base abierta de tarjetas SUBE")+
  scale_color_manual(name= "Referencias:", values= c(
    "Aislamiento" = "black",
    "F" = "red",
    "M" = "blue",
    "Sin registrar" = "green"
  ))
  

ggplot(data=dia_agrupado, aes(x=DIA_TRANSPORTE, 
                              y= `Total de viajes`))+
  geom_line()+
  scale_x_date(date_breaks = "1 month", position="top")+
  theme(axis.text.x= element_text(angle= 45))


p <- ggplot(data=dia_agrupado, aes(x=DIA_TRANSPORTE, 
                              y= `Total de viajes`,
                              color=GENERO))+
  geom_line()+
  geom_vline(aes(xintercept = as.Date("2020-03-20"), col="Aislamiento"),
             linetype="dashed")+
  scale_x_date(date_breaks = "1 month")+
  theme_minimal()+
  theme(axis.text.x= element_text(angle= 90))+
  labs(x="Fecha", title="Cantidad de viajes por día",
       subtitle="Área Metropolitana de Buenos Aires",
       caption="Fuente: Base abierta de tarjetas SUBE")+
  scale_color_manual(name= "Referencias:", values= c(
    "Aislamiento" = "black",
    "F" = "red",
    "M" = "blue",
    "Sin registrar" = "green"))

print(p)

library(plotly)

ggplotly(p)

###############

totales_sin_faltantes <- base_totales %>% 
  filter(GENERO %in% c("F", "M") & MOTIVO_ATSF != "")

unique(totales_sin_faltantes$GENERO)

unique(totales_sin_faltantes$MOTIVO_ATSF)

class(totales_sin_faltantes$DIA_TRANSPORTE)

totales_abril <- totales_sin_faltantes %>% 
  filter(DIA_TRANSPORTE >= "2020-04-01" &
           DIA_TRANSPORTE <= "2020-04-30")


min(totales_abril$DIA_TRANSPORTE)
max(totales_abril$DIA_TRANSPORTE)

abril_agrupado <- totales_abril %>% 
  group_by(MOTIVO_ATSF, GENERO) %>% 
  summarise(Total = sum(CANT_TRJ))

ggplot(data = abril_agrupado, aes(x=reorder(MOTIVO_ATSF, -Total),
                                  y= Total, fill=GENERO))+
  geom_col(color="black", position = position_dodge())+
  coord_flip()


ggplot(data = abril_agrupado, aes(x=reorder(MOTIVO_ATSF, -Total),
                                  y= Total, fill=GENERO))+
  geom_col(color="black")+
  coord_flip()+
  labs(x= "Motivo de descuento",
       title= "Cantidad de viajes con descuento",
       subtitle = "Mes de abril año 2020",
       caption="Fuente: Base abierta SUBE")+
  theme_minimal()

  







