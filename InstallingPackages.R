# -----------------------------------------------------------------------------
# Jennifer Franks - April 2023
#
#       Re-install packages on new version of R
#
#
# -----------------------------------------------------------------------------

# list all packages installed on old version of R (MacOS location)

temp <- list.dirs("//Library/Frameworks/R.framework/Versions/4.0/Resources/library", 
                  full.names = F, recursive = F)

# install packages available from CRAN 
new.packages <- temp[!(temp %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


# install packages from bioconductor 
remaining.packages <- new.packages[!(new.packages %in% installed.packages()[,"Package"])]
if(length(remaining.packages)) BiocManager::install(remaining.packages)

# finish with installing Github directories

devtools::install_github('cole-trapnell-lab/monocle3', ref="develop")

devtools::install_github('cole-trapnell-lab/garnett')

devtools::install_github('cole-trapnell-lab/PLNmodels')
devtools::install_github('cole-trapnell-lab/hooke', ref="develop")




