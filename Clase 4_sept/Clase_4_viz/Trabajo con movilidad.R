library(tidyverse)
library(openxlsx)
library(ggplot2)
library(lubridate)
library(RCurl)
options(scipen=999)

#Cargo la base de datos desde GITHUB

base <- getURL("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/dat-ab-usuarios-2020.csv")

base_sube <- read.csv(text = base, sep = ';')

#Filtramos la base por el Area Metropolitana

base_amba <- base_sube %>% 
  filter(AMBA == 'SI')

# Filtramos la base para saber solo los totales

filtro_totales <- base_amba %>% 
  filter(TIPO_TRANSPORTE == 'TOTAL')

# Agrupamos por dia y genero

filtros_genero <- filtro_totales %>% 
  group_by(DIA_TRANSPORTE,GENERO) %>% 
  summarise(Cantidad_total = sum(CANT_TRJ))

# Excluimos las lineas que no tienen genero identificado

filtros_genero_2 <- filtros_genero  %>% 
  filter(GENERO == 'M' | GENERO == 'F')

# Casteamas los dias en formato fecha

filtros_genero_3 <- filtros_genero_2 %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

# Creamos una base agrupada por dia

Total_agrupado <- filtro_totales %>% 
  group_by(DIA_TRANSPORTE) %>% 
  summarise(Cantidad = sum(CANT_TRJ))

# Creamos un grafico basico a partir de los totales

plot(prueba_2$Cantidad, type = 'l')

# Generamoas el grafico por genero

ggplot(data = filtros_genero_3, aes(x = DIA_TRANSPORTE, y = Cantidad_total))+
  geom_line()+
  facet_wrap(~GENERO)

# Mujeres 
FEM <- filtros_genero_3 %>% 
  filter(GENERO == 'F')
# Varones

MASC <- filtros_genero_3 %>% 
  filter(GENERO == 'M')

# Hacemos un plot de Varones y Mujeres en el mismo grafico

plot(FEM$DIA_TRANSPORTE, FEM$Cantidad_total, type = 'l', col = 'red', main = 'Movilidad durante 2020 H vs M')
lines(FEM$DIA_TRANSPORTE, MASC$Cantidad_total, col = 'blue')

# Ahora con ggplot

ggplot(FEM, aes(DIA_TRANSPORTE, Cantidad_total)) + 
  geom_line(data = MASC,aes(y = Cantidad_total, colour = "Masculino")) +
  geom_line(data = FEM,aes(y = Cantidad_total, colour = "Femenino"))+
  labs(title = 'Movilidad diaria SUBE por Sexo en 2020')

# Podemos cambiar los nombres de los ejes para que sea más prolijo:

ggplot(FEM, aes(DIA_TRANSPORTE, Cantidad_total)) + 
  geom_line(data = MASC,aes(y = Cantidad_total, colour = "Masculino")) +
  geom_line(data = FEM,aes(y = Cantidad_total, colour = "Femenino"))+
  labs(title = 'Movilidad diaria SUBE por Sexo en 2020',
       x = 'Fecha',
       y = 'Cantidad de viajes SUBE')

# Podemos agregar la fuente:

my_plot <-  ggplot(FEM, aes(DIA_TRANSPORTE, Cantidad_total)) + 
  geom_line(data = MASC,aes(y = Cantidad_total, colour = "Masculino")) +
  geom_line(data = FEM,aes(y = Cantidad_total, colour = "Femenino"))+
  labs(title = 'Movilidad diaria SUBE por Sexo en 2020',
       x = 'Fecha',
       y = 'Cantidad de viajes SUBE',
       caption = 'Elaboracion propia en base a datos abiertos SUBE',
       col = 'Sexo')

# Casteamos la fecha en los filtros totales

filtro_totales_2 <- filtro_totales %>% 
  mutate(DIA_TRANSPORTE = ymd(DIA_TRANSPORTE))

unique(filtro_totales_2$MOTIVO_ATSF)

ggplot(filtro_totales_2, aes(DIA_TRANSPORTE,CANT_TRJ)) + 
  geom_line(data = filter(filtro_totales_2, MOTIVO_ATSF == 'PERSONAL DEL TRABAJO DOMÉSTICO'),aes(y = CANT_TRJ, col = 'Trabajo domestico'))+
  geom_line(data = filter(filtro_totales_2, MOTIVO_ATSF == 'JUBILACION'),aes(y = CANT_TRJ, col = 'Jubilacion'))+
  labs(title = 'Movilidad diaria SUBE por AUH y Personal de trabajo domestico en 2020',
       x = 'Fecha', y = 'Cantidad de viajes SUBE',
       col = 'Tipo de descuento')+ scale_color_manual(values=c("#CC6666", "#9999CC"))


# 2 maneras de salvar el grafico
pdf("myplot.pdf")
myplot <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
print(my_plot)
dev.off()

ggsave('my_plot.png')

######################################################
# Grafico de barras

# Filtramos los vacios
totales_sin_na <- filtro_totales_2 %>% 
  filter(GENERO == 'M' | GENERO == 'F') %>% 
  filter(MOTIVO_ATSF != "")

# Agrupamos por genero y tipo de descuento
descuentos <- totales_sin_na %>% 
  group_by(MOTIVO_ATSF, GENERO) %>% 
  summarise(Total = sum(CANT_TRJ))

# Graficamos
ggplot(data = descuentos) +
  aes(x = MOTIVO_ATSF, y = Total, fill = GENERO) +
  geom_bar(stat = "identity", color = 'black',
           position = position_dodge())+
  labs(title = 'Cantidad de viajes realizados con tarjeta SUBE con descuento en 2020',
       x = 'Tipo de descuento', fill = 'SEXO',
       caption = 'Elaboracion propia en base a datos abiertos SUBE 2020')+
  coord_flip()

# Trabajo la base para obtener los porcentajes

descuentos <- totales_sin_na %>% 
  group_by(MOTIVO_ATSF) %>% 
  summarise(Total = sum(CANT_TRJ),
            Varones_N = sum(CANT_TRJ[GENERO == 'M']),
            Mujeres_N = sum(CANT_TRJ[GENERO == 'F']),
            Varones = Varones_N/Total * 100,
            Mujeres = Mujeres_N/Total * 100) %>% 
  select(MOTIVO_ATSF, Mujeres, Varones) %>% 
  pivot_longer(.,cols =  2:3, names_to = 'SEXO', values_to = 'Porcentaje' )

descuentos <- descuentos %>% 
  mutate(Porcentaje = round(Porcentaje, 2))

ggplot(data = descuentos) +
  aes(x = MOTIVO_ATSF, y = Porcentaje, fill = SEXO) +
  geom_bar(stat = "identity", color = 'black',
           position = position_dodge())+
  labs(title = 'Cantidad de viajes realizados con tarjeta SUBE con descuento en 2020',
       x = 'Tipo de descuento', fill = 'SEXO',
       caption = 'Elaboracion propia en base a datos abiertos SUBE 2020')+
  coord_flip()

# En una sola barra
ggplot(data = descuentos) +
  aes(x = MOTIVO_ATSF, y = Porcentaje, fill = SEXO) +
  geom_bar(stat = "identity", color = 'black')+
  labs(title = 'Cantidad de viajes realizados con tarjeta SUBE con descuento en 2020',
       x = 'Tipo de descuento', fill = 'SEXO',
       caption = 'Elaboracion propia en base a datos abiertos SUBE 2020')+
  coord_flip()

ggsave('viajes_porcentual.png')


###### Agrupar por mes
# el mes se ordena alfabeticamente, de esta manera queda c
# de manera cronologica
x_por_mes <- Total_agrupado %>% 
  mutate(FECHA = ymd(DIA_TRANSPORTE)) %>%
  group_by(Mes = month(FECHA)) %>% 
  mutate(Mes = month.name[Mes]) %>% 
  select(-(DIA_TRANSPORTE))%>% 
  summarise(Cantidad = sum(Cantidad)) %>% 
  mutate( Mes = factor(Mes, levels = month.name) ) %>% 
  arrange(Mes)


# Graficamos

ggplot(data = x_por_mes) +  
  aes(y = Cantidad, x = Mes, fill = Cantidad) +  
  geom_col(color = "black")+
  scale_fill_gradient(low = 'red',high = "yellow")+
  labs(title='Cantidad de viajes por mes con tarjeta SUBE',
       subtitle = 'Año 2020',
       caption = 'Fuente: Base SUBE 2020')
  
# Y si agregamos una linea por Sexo?


Total_agrupado <- filtro_totales %>% 
  group_by(DIA_TRANSPORTE) %>% 
  summarise(Cantidad = sum(CANT_TRJ),
            FEM = sum(CANT_TRJ[GENERO == 'F']),
            MASC = sum(CANT_TRJ[GENERO == 'M']))

x_por_mes <- Total_agrupado %>% 
  mutate(FECHA = ymd(DIA_TRANSPORTE)) %>% 
  group_by(Mes = month(FECHA)) %>% 
  mutate(Mes = month.name[Mes]) %>% 
  select(-(DIA_TRANSPORTE))%>% 
  summarise(Cantidad = sum(Cantidad),
            FEM  = sum(FEM),
            MASC = sum(MASC)) %>% 
  mutate( Mes = factor(Mes, levels = month.name) ) %>% 
  arrange(Mes)

# Hay que agregar una linea con 12 para tener 2 variables numericas
x_por_mes <- x_por_mes %>% 
  mutate(mes_numero = c(1:12))

ggplot(data = x_por_mes, aes(x = Mes)) +  
  geom_col(aes(y = Cantidad, x = Mes, fill = Cantidad),color = "black")+
  geom_line(data = x_por_mes,aes(x=mes_numero, y = FEM, color = 'F'))+
  geom_line(data = x_por_mes,aes(x=mes_numero, y = MASC, color = 'M'))+
  scale_fill_gradient(low = 'white',high = "blue")+
  labs(title='Cantidad de viajes por mes con tarjeta SUBE',
       subtitle = 'Año 2020',
       caption = 'Fuente: Base SUBE 2020')



#RColorBrewer::display.brewer.all()

