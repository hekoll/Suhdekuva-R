# Suhdekuva

# Kuvatyyppi, jolla voi kuvata kahden muuttujan valista suhdetta 
# niiden erotuksen janalla

# Luodaan malliaineisto, joka pysyy annetun ala- ja ylarajan valilla

# Funktion komponentit
# mu = odotusarvo, sd = keskihajonta, n = lopullinen otoskoko
# m = random otoskoko, yla = ylaraja, ala = alaraja

otosrajalla <- function(mu, sd, n, m, yla, ala){
  x <- rnorm(m, mu, sd) 
  x <- which(x <= yla)
  x <- which(x >= ala)
  x <- sample(x, n)
  return(x)
}

x <- otosrajalla(2, 1, 20, 1000, 10, 0)
y <- otosrajalla(2, 1, 20, 1000, 10, 0)
id <- c(1:20)

# Kuvan koko  

par(mar = c(5.1, 4.1, 4.1, 8.1), xpd = TRUE)

# Kuva

plot(y~id, col = 1, xlab = "id", ylab = "Y", main = "Y ja X suhteen vertaaminen")
points(x~id, col = 2)
legend("topright",inset = c(-0.1,0), legend = c("Y","X"), col = c("black","red"),
       pch = 1, box.lty = 0)

# Janat

for (i in 1:length(id)){
  par(new = TRUE)
  segments(y0 = x[i], x0 = id[i], y1 = y[i], x2 = id[i])
} 
