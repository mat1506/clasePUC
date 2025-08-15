# Repositorio CRAN rápido
options(repos = c(CRAN = "https://cloud.r-project.org"))
options(Ncpus = max(1L, parallel::detectCores() - 1L))
Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS = "true")

# Solo lo que no está en conda: lipdR y geoChronR desde GitHub
# (Asumimos que sus dependencias pesadas vienen por conda: dplR, lme4, nloptr, XML, etc.)
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("nickmckay/lipdR",
                        upgrade = "never",
                        dependencies = NA,
                        build_vignettes = FALSE,
                        quiet = TRUE)
remotes::install_github("nickmckay/geoChronR",
                        upgrade = "never",
                        dependencies = NA,
                        build_vignettes = FALSE,
                        quiet = TRUE)

# NO instales IRkernel aquí ni como root (causa "Permission denied" en Binder).
# Se registra en postBuild con user=TRUE.

