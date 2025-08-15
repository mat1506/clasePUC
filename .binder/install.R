# Establecer un repositorio actualizado de CRAN
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Instalar paquetes principales
install.packages(c(
  "ggplot2","devtools","jsonlite","Rcpp", "dplyr", "tidyverse", "MASS", "Matrix", "sf",
  "units", "rmarkdown", "rnaturalearth", "here", "httr",
  "shinydashboard", "leaflet", "dplR","remotes", "rbacon", "neotoma2"
), dependencies = TRUE)

# Instalar geoChronR y lipdR desde GitHub
remotes::install_github("nickmckay/lipdR", force = TRUE)
remotes::install_github("nickmckay/geoChronR", force = TRUE)

# Registrar el kernel de R para Jupyter
install.packages("IRkernel")
IRkernel::installspec(user = FALSE)
