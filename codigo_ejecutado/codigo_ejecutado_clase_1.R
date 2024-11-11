?filter

a = 1

b <- 10

class(a)

?class

c <- 'Hola programación en R'
d <- "Esto es un string"

class(d)


a + b

e <- "100"

a + e

as.numeric(e)

class(e)

e <- as.numeric(e)

class(e)

10 * 10

12 / 2

10 - 5

3**2

3**3

sqrt(9)

a <- 100
b <- 20

a > b

TRUE + 1
FALSE + 1

a < b

a >= b

a <= b

a == b

c <- 100

a == c

a != c


vector_num <- c(10, 20, 30, 50, 100)

vector_char <- c("hola", "esto", "es", "un", "vector")

vector_char[c(1,3)]

vector_char[1:3]

a_factorear <- c(3,3,3,2,1,2,3,1,2,1,2,3,3,1)

etiquetado <- factor(a_factorear,
                   labels = c("Varon", "Mujer", "No binario"))

print(etiquetado)
print(a_factorear)

?factor

vector_num + 10 

rango <- c(10:80)

print(rango)

rango[1] <- "Diez"

print(rango[1])

print(rango)

rango[1] <- 10

rango <- as.numeric(rango)
rango

faltantes <- c(81:100)

rango <- append(rango, faltantes)

rango <- append(rango, c(81:100))

rango

rango[-91]


nombres <- c("Carlos", "Maria", "Roberto", "Martin","Marta")
edades <- c(10, 50, 15, NA ,28)
genero <- c("Varon", "Mujer", "Varon", "Varon", "Mujer")

df <- data.frame(nombres, genero, edades)

View(df)

df$nombres


df$nombres[3]

df[3,2]

df[df$genero=="Varon", ]

varones <- df[df$genero=="Varon" , ]
print(varones)
View(varones)

df

write.csv(df, "tabla_clase_1.csv")

getwd()

setwd("C:/Users/dpach/")
getwd()







