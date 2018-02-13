# R ja SQL yhteiskaytto ja satunnaisotanta id mukaan esimerkki
# Salatut ----

# Tietokantaan yhdistaminen 

install.packages('RPostgreSQL')
library("RPostgreSQL")
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="localhost", dbname="----",
                 user="----", password="----")

# Satunnaisten otoksien ottaminen tauluista ja naiden taulujen 
# yhdistaminen viiteavaimella

# SQL -kysely id lukumaarasta

maara <- dbGetQuery(con, "SELECT COUNT(viiteavain) AS viiteavain FROM taulu")

set.seed(1)
x <- sample(1:maara[1,], 1000)

# Funktio, joka yhdistaa id arvot lauseeksi sql kutsua varten

yhdistastring <- function(sana, x){
  for(j in 1:1000){
    if(j == 1){
      lause <- paste(sana, "=", toString(x[j]))
    }
    else{
      lause <- paste(lause, paste("OR", sana, "=", toString(x[j])))
    }
  }
  return(lause)
}

# SQL -kysely tarpeellisille muuttujille

q1 <- paste("SELECT viiteavain, muuttujat FROM taulu1
            WHERE ", yhdistastring("viiteavain", x))

q2 <- paste("SELECT viiteavain, muuttujat FROM taulu2
            WHERE ", yhdistastring("viiteavain", x))

otos1 <- dbGetQuery(con, q1)
otos2 <- dbGetQuery(con, q2)


# Yhdistetaan testidata kahdesta otoksesta viiteavaimen avulla

testidata <- merge(otos1, otos2, by="viiteavain")

# Tallennetaan testidata myohempaa kayttoa varten

save(testidata, file="testidata.Rda")

########################################################################