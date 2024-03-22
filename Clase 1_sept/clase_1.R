
# Creamos un objeto
a = 1

b <- 2

class(a)

# Objeto character
texto <- "hola programación en R"

texto

# Obtenemos el tipo de dato
class(texto)

a

texto
# suma
a + b

c <- a + b

# Numero tipo character
e <- "10"

a + e

class(e)

# Transformamos el objeto en numerico
e <-  as.numeric(e)

class(e)

a + e

# operadores aritmeticos
10 * 10

12 / 4

10 - 5

3**2


numeromayor <- 10
numeromenor <- 5

# Operadores lógicos
numeromayor > numeromenor

numeromayor < numeromenor

numeromayor == numeromenor

numeromenor <- 10

numeromayor == numeromenor

# comando mayor o igual
a >= b

a <= b

b != a

# este comando verifica si un objeto distinto a otro
numeromayor != numeromenor

# Esto es un comentario

# Vectores
vector_num <- c(10, 20, 30, 40, 50)

vector_texto <- c("hola", "esto", "tambien", "es", "un", "vector")

vector_texto

vector_texto[c(2,4)]

# Reemplazamos por 100 el elemento 1
vector_num[1] <- 100

vector_num

# Creamos vetor numerico
a_factorear <- c(3,1,2,2,2,1,1,1,3)

# creamos vector con etiquetas
genero <- c("varon", "mujer","no binario")

# reemplazamos las codigos por etiquetas
etiquetas <- factor(a_factorear,
                    labels= genero)

etiquetas[2]

# creamos un rango
vector_denumeros <- c(1:20)

vector_denumeros_2 <- c(23:42)

vector_denumeros

# agregamos un rango a un vector numerico
mas_largo <- append(vector_denumeros, c(21:50))

mas_largo

# creamos vectores del mismo largo
nombres <- c("diego", "carlos", "maria")
edades <- c(36, 50, 25)
ciudad <- c("CABA", "Cordoba", "Salta")

# los convertimos en df

df <- data.frame(nombres, edades, ciudad)

df

# accedemos a las columnas del df
df$nombres

df$edades

# accedemos a un elemento de la columna
df$nombres[2]

df[3, 3]

# abrir el df en una pestaña
View(df)



















