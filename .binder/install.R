# Establecer un repositorio de CRAN actualizado
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Instalar paquetes adicionales de R
install.packages(c("leaflet", "rmarkdown", "sf", "rnaturalearth", "dplR"))

# Instalar paquetes desde GitHub
remotes::install_github("nickmckay/lipdR", force = TRUE)
remotes::install_github("nickmckay/geoChronR", force = TRUE)

# Registrar el kernel de R
install.packages("IRkernel")
IRkernel::installspec(user = FALSE)
