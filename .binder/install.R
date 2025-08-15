# Repositorio CRAN rápido y configuración paralela
options(repos = c(CRAN = "https://cloud.r-project.org"))
options(Ncpus = max(1L, parallel::detectCores() - 1L))
Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS = "true")

# SOLO paquetes que no están en conda (el resto ya llega por environment.yml):
# Estos dos estaban causando errores cuando se pedían desde conda (no existen como r-*)
install.packages(c("rbacon", "neotoma2"), dependencies = TRUE)

# lipdR y geoChronR desde GitHub (sin viñetas y sin forzar upgrades)
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github(
  "nickmckay/lipdR",
  upgrade = "never",
  dependencies = NA,
  build_vignettes = FALSE,
  quiet = TRUE
)
remotes::install_github(
  "nickmckay/geoChronR",
  upgrade = "never",
  dependencies = NA,
  build_vignettes = FALSE,
  quiet = TRUE
)

# ¡NO registres IRkernel aquí! En Binder, hacerlo como root da "Permission denied".
# Lo registramos en postBuild con user=TRUE.


