# Prueba Data Engineer Junior #
# NOMBRE:  Diana Alejandra Bermúdez Fajardo

install.packages("readr")
install.packages("readxl")
install.packages("janitor")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyr")
install.packages("openxlsx")

library(readr) 
library(readxl)
library(janitor)
library(dplyr)
library(ggplot2)
library(tidyr)
library(openxlsx)


#EXTRACCION
#1. Leer adecuadamente la base de datos en csv

Data = read.csv('data.csv', header = TRUE,  sep= ",")
View(Data)

names(Data)
summary(Data)
typeof(Data)
str(Data)

#LIMPIEZA
#2. Eliminar columnas redundantes

Data<-select(Data, -c(a_o, mes, d_a, entidad))
View(Data)

#3. Convertir a DATE la fecha

str(Data)
Data$fecha <- as.Date(Data$fecha , format = "%d/%m/%Y")
class(Data$fecha)

#4. Convertir a POSIXct la hora

Data$hora <- as.POSIXct(Data$hora , format = "  %H:%M:%S")
class(Data$hora)
Data$horas <- format(Data$hora , format = "%H:%M:%S")
Data<-select(Data, -c(hora))

#4. Verificación del tipo de las variables

str(Data)

#TRANSFORMACION

#5. Dividir la columna de nombrecomuna

class(Data$nombrecomuna)

Data2 <- Data %>% separate(
  col = nombrecomuna, 
  into = c('codigo_comuna', 'nombre_comuna'),
  sep = ". ")

#6. Renombrar columnas

names(Data2)
Data3 <- Data2 %>% rename (caso = orden, jornada = diurnio_nocturno, 
                           tipo_propietario = propietario_de_veh_culo, 
                           restriccion = hora_restriccion_moto,
                           via = via_1 )

#TRANSFORMACIÓN

Cantidad_gravedad <- table(Data$gravedad)
View(Cantidad_gravedad) 

table(Data$barrio)

Peaton <-subset(Data3,peaton>0)
Peaton<-select(Peaton, c(caso,horas,fecha,peaton))


Automovil <-subset(Data3,automovil>0)
Automovil <-select(Automovil, c(caso,horas,fecha,automovil))


Campaero <-subset(Data3,campaero>0)
Campaero <-select(Campaero, c(caso,horas,fecha,campaero))


Camioneta <-subset(Data3,camioneta>0)
Camioneta <-select(Camioneta, c(caso,horas,fecha,camioneta))

Micro <-subset(Data3,micro>0)
Micro <-select(Micro, c(caso,horas,fecha,micro))


Buseta <-subset(Data3,buseta >0)
Buseta <-select(Buseta , c(caso,horas,fecha,buseta))


Bus <-subset(Data3,bus>0)
Bus <-select(Bus, c(caso,horas,fecha,bus))



Camion <-subset(Data3,camion>0)
Camion <-select(Camion, c(caso,horas,fecha,camion))


Volqueta <-subset(Data3,volqueta>0)
Volqueta <-select(Volqueta, c(caso,horas,fecha,volqueta))


Moto <-subset(Data3,moto>0)
Moto <-select(Moto, c(caso,horas,fecha,moto))


Bicicleta <-subset(Data3,bicicleta>0)
Bicicleta <-select(Bicicleta, c(caso,horas,fecha,bicicleta))


Otro <-subset(Data3,otro>0)
Otro <-select(Otro, c(caso,horas,fecha,otro))


Ubicacion <-select(Data3, c(caso, via, barrio, codigo_comuna, nombre_comuna))

Caso <-select(Data3, c(caso,horas,fecha))

Detalle <-select(Data3, c(caso, gravedad, jornada, restriccion, tipo_propietario))

write.xlsx(Detalle , "Detalle.xlsx")
write.xlsx(Bicicleta, "Bicicleta.xlsx")
write.xlsx(Otro , "Otro.xlsx")
write.xlsx(Caso , "Caso.xlsx")
write.xlsx(Moto , "Moto.xlsx")
write.xlsx(Volqueta , "Volqueta.xlsx")
write.xlsx(Ubicacion , "Ubicacion.xlsx")
write.xlsx(Camion, "Camion.xlsx")
write.xlsx(Bus , "Bus.xlsx")
write.xlsx(Micro , "Micro.xlsx")
write.xlsx(Buseta , "Buseta.xlsx")
write.xlsx(Automovil , "Automovil.xlsx")
write.xlsx(Peaton , "Peaton.xlsx")
write.xlsx(Camioneta , "Camioneta.xlsx")
write.xlsx(Campaero , "Campaero.xlsx")
