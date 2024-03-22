
library(lubridate)
library(plotly)
library(tidyverse)
options(scipen = 999)

base_caba <- read.csv('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/vacunas_caba.csv') %>% 
  select(-(1))
## Creamos base con la suma de las dosis
base_caba_ac <- base_caba %>% 
  mutate(FECHA = ymd(FECHA_ADMINISTRACION)) %>% 
  group_by(FECHA) %>% 
  summarise(dosis_1 = sum(DOSIS_1),
            dosis_2 = sum(DOSIS_2),
            dosis_3 = sum(DOSIS_3, na.rm= TRUE))
            
# Creamos las frecuencias acumuladas
base_acu <- base_caba_ac %>% 
  mutate(Dosis1= cumsum(dosis_1),
         Dosis2 = cumsum(dosis_2),
         Dosis3 = cumsum(dosis_3))

# seleccionamos las columnas
base_acu <- base_acu %>%             
  select(1,5,6,7)            

# Graficamos
ggplot(data = base_acu, aes(x = FECHA, y =Dosis1))+
  geom_area(aes(y = Dosis1, color= 'green'),  fill = 'green')+
  geom_area(aes(y = Dosis2, color = 'dark green'),  fill = 'dark green', 
            alpha = 0.75)+
  geom_area(aes(y = Dosis3, color = 'black'), fill = 'black', 
            alpha = 0.5)+
  labs(title = 'Vacunación acumulada en CABA',
       subtitle = 'Año 2021',
       y= 'Cantidad de aplicaciones',
       x = 'Fecha',
       caption = 'Fuente: elaboración propia a partir de datos abiertos CABA',
       col = 'Número de dosis')+
  theme_minimal()+
  scale_fill_brewer(palette = 'Greens')+
  scale_x_date(breaks = '1 month')+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_continuous(breaks = seq(0, 3000000, by = 500000))+
  scale_color_identity(breaks = c("green", "dark green", "black"),
                       labels = c("Dosis 1", "Dosis 2", "Dosis 3"),
                       guide = "legend")

# Pivot para tener la aplicación total
acum_2 <- base_acu %>% 
  pivot_longer(., cols = 2:4, names_to = 'Nro_dosis',values_to = 'Cantidad')
  
# Obtenemos las dosis por separado y la cantidad total de aplicaciones
ggplot(data = acum_2, aes(x = FECHA,y=Cantidad, fill= Nro_dosis))+
  geom_area( color = 'black', alpha = 0.75)+
  labs(title = 'Vacunación acumulada en CABA',
       subtitle = 'Año 2021',
       y= 'Cantidad de aplicaciones',
       x = 'Fecha',
       caption = 'Fuente: elaboración propia a partir de datos abiertos CABA',
       fill = 'Número de dosis')+
  theme_minimal()+
  scale_fill_brewer(palette = 'Greens')+
  scale_x_date(breaks = '1 month')+
  theme(axis.text.x = element_text(angle = 90))

#######
a <- ggplot(data = acum_2, aes(x = FECHA, y =Cantidad, fill= Nro_dosis))+
  geom_area(aes(y = Cantidad), color = 'black', alpha = 0.75)+
  labs(title = 'Vacunación acumulada en CABA',
       subtitle = 'Año 2021',
       y= 'Cantidad de aplicaciones',
       x = 'Fecha',
       caption = 'Fuente: elaboración propia a partir de datos abiertos CABA',
       fill = 'Número de dosis')+
  theme_minimal()+
  scale_fill_brewer(palette = 'Greens')+
  scale_x_date(breaks = '1 month')+
  theme(axis.text.x = element_text(angle = 90))

ggplotly(a)

ggsave('vacuna_caba.png')
#####

a <- ggplot(data = base_acu, aes(x = FECHA, y =Dosis1))+
  geom_area(aes(y = Dosis1, color= 'green'),  fill = 'green')+
  geom_area(aes(y = Dosis2, color = 'dark green'),  fill = 'dark green', 
            alpha = 0.75)+
  geom_area(aes(y = Dosis3, color = 'black'), fill = 'black', 
            alpha = 0.5)+
  labs(title = 'Vacunación acumulada en CABA',
       subtitle = 'Año 2021',
       y= 'Cantidad de aplicaciones',
       x = 'Fecha',
       caption = 'Fuente: elaboración propia a partir de datos abiertos CABA',
       col = 'Número de dosis')+
  theme_minimal()+
  scale_fill_brewer(palette = 'Greens')+
  scale_x_date(breaks = '1 month')+
  theme(axis.text.x = element_text(angle = 90))+
  scale_y_continuous(breaks = seq(0, 3000000, by = 500000))+
  scale_color_identity(breaks = c("green", "dark green", "black"),
                       labels = c("Dosis 1", "Dosis 2", "Dosis 3"),
                       guide = "legend")

ggplotly(a)



  