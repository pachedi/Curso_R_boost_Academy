
# Acceder a la documentación
?print

# Tipos de dato

a <- 10  

print(a)

class(a)

b <- "Hola programación en R"

class(b)

c <- 5
d <- 3

c + d

e <- "9"

c + e

as.numeric(e)

c + e

e <- as.numeric(e)
class(e)

c + e

# Multiplicacion

9 * 8

# Resta

10 - 5

resultado_resta <- 10 - 5

# Potencia

3**2


# Operadores logicos

TRUE # 1
FALSE # 0

TRUE + TRUE 
FALSE + FALSE
TRUE + FALSE

numero1 <- 20
numero2 <- 30
numero3 <- 20

numero1 > numero2

numero2 > numero1

numero1 >= numero2  

numero1 != numero2 
numero1 != numero3

numero1 == numero2
numero1 == numero3 

b <- 7.5

class(b)

v_num <- c(9,b,8,10)

v_num[1]
v_num[4]

b <- 9

v_num[2]

# Vectores 

vec_num <- c("2", 4,5,10,20)  

vec_num

vec_chr <- c("Esto", "es", "un", "vector", "chr")

a_factorear <- c(3,2,2,3,1,2,1,2,1,2,3)

a_etiquetar <- factor(a_factorear, 
                      labels = c("Provincia","Departamento",
                                 "Localidad"))

a_etiquetar

vec_num2 <- c(2,1,3,4)

vec_num2 + 10

rango_numero <- c(1:50)

rango_numero

rango_numero[1] <- "Uno"

rango_numero

rango_numero <- c(1:50)

rango_numero <- append(rango_numero, c(51:100))

rango_numero

seq(1,50,2)

rango_nuevo <- c(20:30)

rango_nuevo

rango_nuevo[-1]

# Data frames

edad <- c(20, 10, 35, 50, 75)
genero <- c("", "Mujer", "Mujer", "Mujer", "Varon")
pais <- c("España", "Francia", "Alemania", "Argentina", "Brasil")
ingresos <- c(3000, 5000.7, 500, 200.5 , 1500)

df <- data.frame(edad, genero, pais)

df$ingresos <- c(3000, 5000.7, 500, 200.5 , 1500)

df["ingresos2"] <- ingresos 

View(df)

df$edad

df$pais

df$genero

df[1 , 1]

tabla_mujeres <- df[df$genero == "Mujer", ]

View(tabla_mujeres)

df[df$ingresos > 1000 & df$genero == "Mujer", ]

# Valores faltantes

con_na <- c(2, 10, NA, NA, 3, NA, 30, NA)

con_na[3]

is.na(con_na)

# TRUE = 1  // FALSE = 0

sum(is.na(con_na))

na.omit(con_na)

con_na[ is.na(con_na) ] <- 0

con_na

df[1, ]

a <- c(20:50)
b <- "string de prueba"
c <- TRUE

mi_lista <- list(a,b,c, mi_df = df)

mi_lista

mi_lista$mi_df$genero[3]

install.packages("openxlsx")

library(openxlsx)

write.xlsx(df, "mi_df_R.xlsx")

getwd()

setwd("C:/Users/dpach/OneDrive - sociales.UBA.ar/")

getwd()


