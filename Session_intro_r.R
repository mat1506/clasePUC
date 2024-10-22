########################################################################
#PROGRAMA DE DOCTORADO EN CIENCIAS BIOLÓGICAS
# Taller Paleoclimatología y Paleoecología – 2do semestre 2020
#Sigla : BIO4032
#Carácter : Optativo
#Créditos : 10
#Profesores Encargado Taller : Dr. Claudio Latorre y Dr. Matías Frugone
#Fechas inicio y término : 
#Días : Lunes – Miercoles
#Horario : 14:30 a 18:00 hrs
#Semestre que se dicta : Segundo
######################################################################

########################################################################
#####Sesión 1.2

##### Sesión 1 Análisis exploratorio de datos y gráficos
  # 1.1 Datos en Paleolimnologı́a y Paleoclimatologı́a
  # 1.2 Análisis exploratorio de datos y gráficos

####################################
#DIRECTORIO DE TRABAJO
####################################

#ESTABLECE EL DIRECTORIO DE TRABAJO
library(tidyverse)
library(here)
here()

X <- read_csv(here::here("data/LEM_proxies.csv"))

######### MIREMOS LOS DATOS ############

mode(X)
class(X)
head(X) #para la primeras filas de datos
tail(X) #para la ultimas filas de datos
str(X) #para ver la estructura de los datos
summary(X[,5:16]) # Resumen de los datos
#calcular promedios de una variable para niveles de un factor
tapply(X$TOC, X$Facie, mean) #calcular promedios por factor

##### Análisis exploratorio de datos y gráficos ############

boxplot(X$TOC ~ X$Unit, notch=TRUE, ylab="TOC") #compara las medias visualmente
h <- hist(X$TOC, plot = F)
str(h)
plot(h, col = heat.colors(length(h$mids))[length(h$count) - rank(h$count) + 1], ylim = c(0,   max(h$count) + 5),
     main = "Frequency histogram, El Maule (Organic Carbon)",
     sub = "Total Organic Carbon",
     xlab = "TOC (%)")

if(!require(dplyr)){
  install.packages("dplyr")
  library("dplyr")
}

y01<-na.omit(select(X,TOC))
y02<-na.omit(select(X,Unit,TOC,TIC,TS,TN,TOC.TN))

par(mfrow=c(2,2)) # 2x2 matrix of plots in one figure
boxplot(y01$TOC, data=y01,notch=T, horizontal=T,main="Boxplot of TOC")
hist(y01$TOC, freq=F,main="Probability density for TOC")
lines(density(y01$TOC),lwd=2)
lines(density(y01$TOC, adj=.5),lwd=1)
lines(density(y01$TOC, adj=2),lwd=1.5)
qqnorm(y01$TOC, main="QQ plot for Clay 0-10cm vs Normal distribution",ylab="TOC %")
qqline(y01$TOC, col=4)
qqnorm(log(y01$TOC), main="QQ plot for TOC vs lognormal distribution",ylab="log(TOC %)")
qqline(log(y01$TOC), col=4)
dev.off();

####ggplot Histograma 

if(!require(ggplot2)){
  install.packages("ggplot2")
  library("ggplot2")
}
par(mfrow=c(2,2))
qplot(y01, geom = 'histogram', binwidth = 2) + xlab('TOC (%)')
ggplot(data = y02) +
  geom_histogram(aes(x = TOC, fill = Unit))
ggplot(data = y02) +
  geom_area(aes(x = TOC, fill = Unit), stat = "bin", position = "stack")
ggplot(y01, aes(x = TOC), bins = 30) + 
  geom_histogram(aes(y = ..density..), fill = 'red', alpha = 0.5) + 
  geom_density(colour = 'blue') + xlab(expression(bold('Simulated Samples'))) + 
  ylab(expression(bold('Density')))
dev.off();

#### Analisis Exp. Bivariate ############

par(mfrow=c(2,2))#
plot(y02$TIC,y02$TN,xlim=c(0,1.2),ylim=c(0,1),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5); abline(0,1,lty=2);
title("TIC vs. TN")
abline(h=mean(y02$TN)); abline(v=mean(y02$TIC))
#
plot(y02$TOC,y02$TN,xlim=c(0,5.5),ylim=c(0,1),pch=20,cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5); abline(0,1,lty=2)
title("TOC vs. TN")
abline(h=mean(y02$TN)); abline(v=mean(y02$TOC))
#
plot(y02$TOC,y02$TS,cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5); abline(0,1,lty=2)
title("TOC vs. TS")
abline(h=mean(y02$TS)); abline(v=mean(y02$TOC))
#
plot(y02$TOC,y02$TOC.TN,pch=20,cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5); abline(0,1,lty=2)
title("TOC vs. TOC/TN")
abline(h=mean(y02$TOC.TN)); abline(v=mean(y02$TOC))
#
par(mfrow=c(1,1))  # reset to 1 plot per figure o dev.off();

par(mfrow=c(2,2))
plot(y02$TOC,y02$TS, xlim=c(0,6), ylim=c(0,3), pch=20,cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
#
plot(y02$TOC,y02$TS, xlim=c(0,6), ylim=c(0,3), pch=as.numeric(y02$Unit),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
abline(0,1,lty=2)
abline(h=mean(y02$TS)); abline(v=mean(y02$TOC))
legend(5.1, 2.8, legend=levels(y02$Unit), pch=1:nlevels(y02$Unit), bty="n")
#
plot(y02$TOC,y02$TS, xlim=c(0,6), ylim=c(0,3), pch=20,col=as.numeric(y02$Unit),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
legend(5.1, 2.8, legend=levels(y02$Unit), pch=20,
col=1:nlevels(y02$Unit), bty="n")
abline(0, 1, lty=2)
abline(h=mean(y02$TS)); abline(v=mean(y02$TOC))
#
plot(y02$TOC,y02$TS, xlim=c(0,6), ylim=c(0,3),pch=as.numeric(y02$Unit), col=as.numeric(y02$Unit),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
abline(0, 1, lty=2, col=5)
abline(h=mean(y02$TS)); abline(v=mean(y02$TOC))
legend(5.1, 2.8, levels(y02$Unit), pch=1:nlevels(y02$Unit),
col=1:nlevels(y02$Unit), bty="n")
#
dev.off();

# Correlación Bivariate

sum((y02$TS-mean(y02$TS))*(y02$TOC-mean(y02$TOC)))/(length(y02$TS)-1)
cov(y02$TOC,y02$TS)
sd(y02$TOC); sd(y02$TS)
cov(y02$TOC,y02$TS)/(sd(y02$TOC)*sd(y02$TS))
cor(y02$TOC,y02$TS)
cor.test(y02$TOC,y02$TS)
#####Visualización de Correlación entre variables
if(!require(PerformanceAnalytics)){install.packages("PerformanceAnalytics")
  library("PerformanceAnalytics")
}
chart.Correlation(X[,9:16],
                  method="pearson",
                  histogram=TRUE,
                  pch=16)

####1.2.3 Transformación de datos y datos anómalos
if(!require(psych)){install.packages("psych")
  library("psych")
}
if(!require(MASS)){install.packages("MASS") 
  library("MASS")
}
if(!require(rcompanion)){install.packages("rcompanion")
  library("rcompanion")
}

par(mfrow=c(1,2)) # 1x2 matrix of plots in one figure
plotNormalHistogram(y02$TIC)
qqnorm(y02$TIC, ylab="Sample Quantiles for TIC")
qqline(y02$TIC, col="red")
dev.off();

#####1.2.Transformación raíz cuadrada
par(mfrow=c(2,2))
TIC_sqrt = sqrt(y02$TIC)
plotNormalHistogram(TIC_sqrt)
qqnorm(TIC_sqrt , ylab="Cuantiles para raís cuadrada")
qqline(TIC_sqrt , col="red")
#####1.2.Transformación raís cubica
TIC_cub = sign(y02$TIC) * abs(y02$TIC)^(1/3)
plotNormalHistogram(TIC_cub)
qqnorm(TIC_cub, ylab="Cuantiles para la raíz cubica")
qqline(TIC_cub, col="red")
dev.off();

#####Log transformation
par(mfrow=c(2,2))
TIC_log = log(y02$TIC+1)
plotNormalHistogram(TIC_log)
qqnorm(TIC_log, ylab="Quantiles Log transformation")
qqline(TIC_log, col="red")
#####Tukey’s Ladder of Powers transformation
TIC_tuk = transformTukey(y02$TIC+1,plotit=FALSE)
plotNormalHistogram(TIC_tuk)
qqnorm(TIC_tuk, ylab="Quantiles Tukey’s Ladder")
qqline(TIC_tuk, col="red")
dev.off();
#####Box–Cox transformation for a single variable
Box = boxcox(y02$TIC+1 ~ 1,              # Transformar TOC como un vector
             lambda = seq(-6,6,0.1)      # Valores entre -6 a 6 por 0.1
)
Cox = data.frame(Box$x, Box$y)            # Crear un data frame con los resultados
Cox2 = Cox[with(Cox, order(-Cox$Box.y)),] # Ordenar el nuevo data frame por orden decresiente y
Cox2[1,]  
lambda = Cox2[1, "Box.x"]                 # Extraer el lambda
TIC_box = ((y02$TIC+1) ^ lambda - 1)/lambda   # transformar los datos originales
par(mfrow=c(1,2))
plotNormalHistogram(TIC_box)
qqnorm(TIC_box, ylab="Sample Quantiles for TIC")
dev.off();

##################################################################################################
############## Regresión lineal #########################
##################################################################################################

############## Fitting una regresión lineal 1
plot(y02$TN ~ y02$TOC, pch=20,col=as.numeric(y02$Unit),xlim=c(0,6), ylim=c(0,1),,cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
legend(5.2, 1, levels(y02$Unit), pch=1:nlevels(y02$Unit),col=1:nlevels(y02$Unit), bty="n")
for (f in c(0.1, .5, 2/3, 1)) {
lines(lowess(y02$TOC, y02$TN, f=f), lwd=2) }
abline(lm(y02$TN ~ y02$TOC), lty=2)

