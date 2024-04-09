#Configurar directorio de trabajo
setwd("C:/Users/dpach/")

# OBtener directorio de trabajo
getwd()

numero = 5

# alt + guion medio  

numero_2 <- 10 

# tipo de dato
class(numero)

# Acceder a documentación
?class

# Vectores
texto <- 'Hola programación en R'

print(texto)

rm(texto)

class(numero_2)

numero + numero_2

numero_problema <- "100"

numero + numero_problema

class(numero_problema)

numero_problema <- as.numeric(numero_problema)

class(numero_problema)

numero + numero_problema

suma <- 10 + 20

10 + 20

print(suma)

# Operadores matematicos
5 * 2

100 / 4

20 - 10

3**2

10**2

3 / 2

#Operadores lógicos
numero > numero_2

numero < numero_2

numero != numero_2 

numero != numero

numero <= numero_2 

numero >= numero_2

?sqrt
# Raíz
sqrt(9)

vector_num <- c(1, 10, 30, 25)

vector_num[2]

1:10

vector_num[2:4]

# Vector caracter
vector_caracter <- c("hola esto es un vector", "de tipo", "caracter")

vector_caracter[2]

class(vector_num)

vector_num <- c(1, 10, 30, 25,"hola")

class(vector_num[1])

# Etiquetado con factor
factorear <- c(2,1,1,1,2,2,2,2,1)

variable_sexo <-  factor(factorear, labels= c("Mujer", "Varon"))

print(variable_sexo)


vector_num <- c(1, 10, 30, 25)

vector_num + 10

rango100 <- c(1:100)

rango100

rango150 <- append(rango100, c(101:150))
rango150

# Rangos invertidos
abs(seq(-100, 1, 2))

rev(seq(1,100,1))

abs(-100)

?seq

rango100[-100]

desde50 <- c(50:100)
desde50

desde50[-1]

rev(vector_num)

#Data frame
nombre <- c("Carlos", "Maria", "Alberto", "Rosa", "Marta")
genero <- c("Varon", "Mujer", "Varon", "Mujer", "Mujer")
ciudad <- c("Barcelona", "Madrid", "Coruña", "Buenos aires", "Ciudad autonoma")

data.frame(nombre, genero, ciudad)

df <- data.frame(nombre, genero, ciudad)

View(df)

df$nombre[3]

df
df[1, 2 ]
df[5, 3]

df[5, ] 

df[ , 2]

df
# Filtro
df[df$genero == "Mujer" , ]

mujeres <- df[df$genero == "Mujer" , ]

mujeres

#install.packages("openxlsx")

library(openxlsx)

# Guardar y cargar dfs
write.csv(df, "primer_data_frame.csv")

write.xlsx(df, "primer_data_frame.xlsx")

lectura_df <- read.xlsx("primer_data_frame.xlsx")

lectura_df


# Manejo de valores faltantes
con_na <- c(2,5,9, NA, 100,NA)

con_na

class(con_na)

is.na(con_na)

sum(is.na(con_na))

sin_na <- na.omit(con_na)
sin_na

sum(is.na(sin_na))

sin_na[4]

con_na[is.na(con_na)] <- 0

con_na










