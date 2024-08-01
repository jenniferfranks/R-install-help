# -----------------------------------------------------------------------------
# Jennifer Franks - April 2023
#
#       Re-install packages on new version of R
#          -or-
#        Install packages on new R install
#
#       if Mac: Make sure to have xcode and homebrew installed (follow system prep info)
#       if HPC (Sasquatch): Make sure to prepare environment using miniforge/mamba
# -----------------------------------------------------------------------------

install.packages("rgeos", repos="http://R-Forge.R-project.org", type="source")
require(rgeos)

#install.packages("rgdal", repos="http://R-Forge.R-project.org", type="source") # deprecated as of May 2023?
#require(rgdal)

install.packages("remotes", repos="https//cran.us.r-project.org")
library(remotes)
install_github("r-spatial/sf")

# list all packages installed on old version of R (MacOS location)
if(exists("//Library/Frameworks/R.framework/Versions/4.0/Resources/library")){      #Intel 
  temp <- list.dirs("//Library/Frameworks/R.framework/Versions/4.0/Resources/library", 
                  full.names = F, recursive = F)
  } else if (exists("~/Library/R/arm64/4.4/library/")){     # M1
  temp <- list.dirs("~/Library/R/arm64/4.4/library/", 
                  full.names = F, recursive = F)
  } else {   # import list of packages from file 
  temp <- read.table("list.of.R.packages.txt", header = F)
  temp <- temp$V1
  }
  


# install packages available from CRAN 
new.packages <- temp[!(temp %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="https//cran.us.r-project.org")


# install packages from bioconductor 
remaining.packages <- new.packages[!(new.packages %in% installed.packages()[,"Package"])]
if(length(remaining.packages)) BiocManager::install(remaining.packages)
BiocManager::install("Rgraphviz")


# finish with installing Github directories
install.packages("devtools")
devtools::install_github('cran/speedglm') 
devtools::install_github('cran/Matrix.utils') 
devtools::install_github('cran/spatstat.core') 
devtools::install_github('cran/hiertest') 

remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')
remotes::install_github("guokai8/scGSVA")
remotes::install_github('satijalab/seurat-wrappers')
remotes::install_github("RubD/Giotto")
remotes::install_github("sqjin/CellChat")

remotes::install_github("bnprks/BPCells/r")
devtools::install_github('cole-trapnell-lab/monocle3', ref="develop")
devtools::install_github('cole-trapnell-lab/garnett', ref="monocle3")
devtools::install_github('scfurl/m3addon')

devtools::install_github('cole-trapnell-lab/PLNmodels', ref="torch_gpu") # needs R 4.1



# get PAT authorization token from github to download private repositories

devtools::install_github('cole-trapnell-lab/hooke', ref="develop", 
                         auth_token = "")



