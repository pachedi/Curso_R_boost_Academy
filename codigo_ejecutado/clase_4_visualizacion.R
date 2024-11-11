

iris <- iris

unique(iris$Species)

iris[1:10, ]

plot(iris$Sepal.Width, type= "p")


plot(iris$Petal.Width, type="l")

plot(iris$Petal.Width, type= "p")


plot(iris$Petal.Width, type="b")

hist(iris$Sepal.Width, col="red", main="Mi primer histograma")

getwd()

ruta <- "mi_histograma.png"
png(ruta)
hist(iris$Sepal.Width, col= "blue", main="Mi histograma")
dev.off()

## Ggplot

mtcars <- mtcars

ggplot(data=mtcars, aes(x=wt, y= hp))+
  geom_point()

ggplot(data=mtcars, aes(x=wt, y= hp))+
  geom_point()+
  labs(title = "Peso y potencia de los autos",
       subtitle = "mtcars")


ggplot(data=mtcars, aes(x=wt, y= hp, col= cyl))+
  geom_point()+
  facet_wrap(~vs)+
  labs(title = "Peso y potencia de los autos",
       subtitle = "mtcars")+
  theme_minimal()

ggplot(data=mtcars, aes(x=wt, y= hp, col= cyl))+
  geom_point()+
  facet_wrap(~vs)+
  labs(title = "Peso y potencia de los autos",
       subtitle = "mtcars")+
  theme_classic()


ggplot(data=mtcars, aes(x=wt, y= hp, col= cyl))+
  geom_point()+
  facet_wrap(~vs)+
  labs(title = "Peso y potencia de los autos",
       subtitle = "mtcars")+
  theme_void()

ggplot(data=mtcars, aes(x=wt, y= hp, col= cyl))+
  geom_point()+
  facet_wrap(~vs)+
  labs(title = "Peso y potencia de los autos",
       subtitle = "mtcars")+
  theme_void()

ggplot(data=mtcars, aes(x=wt, y= hp, col= cyl))+
  geom_point()+
  facet_wrap(~vs)+
  labs(title = "Peso y potencia de los autos",
       subtitle = "mtcars")+
  theme_dark()

ggplot(data=mtcars, aes(x=wt, y= hp, col= cyl))+
  geom_point()+
  facet_wrap(~vs)+
  labs(title = "Peso y potencia de los autos",
       subtitle = "mtcars",
       caption = "Fuente: Base de datos mtcars",
       x="Peso de los autos",
       y="Potencia de los autos")+
  theme_minimal()

## Base SUBE

base_sube <- read.csv("https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/dat-ab-usuarios-2020.csv",sep=';', encoding = 'UTF-8')

head(base_sube)


primero_enero <- base_sube %>% 
  filter(DIA_TRANSPORTE == "2020-01-01")


summary(primero_enero)

unique(primero_enero$DATO_PRELIMINAR)

unique(primero_enero$AMBA)

unique(primero_enero$MOTIVO_ATSF)

sum(is.na(primero_enero$MOTIVO_ATSF))

unique(primero_enero$TIPO_TRANSPORTE)






