
library(ggplot2)

iris <- iris

unique(iris$Species)

plot(iris$Sepal.Width, type= "p")

plot(iris$Sepal.Width, type="l")

plot(iris$Sepal.Width, type= "b")


hist(iris$Sepal.Width, col="blue",
     main="Mi histograma")

nombre_plot <- "mi_histograma.png"
png(nombre_plot)
hist(iris$Sepal.Width, col="blue",
     main="Mi histograma")
dev.off()

getwd()

mtcars <- mtcars

ggplot(data= mtcars, aes(x=wt, y=hp))+
  geom_point()+
  labs(title="Peso y potencia de los autos")

ggsave("peso_autos.png")






