# -----------------------------------------------------------------------------
# Jennifer Franks - April 2023
#
#       Re-install packages on new version of R
#          -or-
#        Install packages on new R install
#
#       if Mac: Make sure to have xcode and homebrew installed (follow system prep info)
#       if HPC (Sasquatch): Make sure to prepare environment using miniforge/mamba
#
#      Recommend to run line-by-line to troubleshoot your specific install!
# -----------------------------------------------------------------------------

# Run if using R through terminal on HPC/Sasquatch
chooseCRANmirror(ind=70)

#----------
# POSIT on Sasquatch INSTRUCTIONS: Activate the mamba environment using reticulate 
# 
#install.packages("reticulate")
#
#Sys.setenv(RETICULATE_CONDA='/data/hps/assoc/private/franks_lab/user/jfra11/miniforge3/condabin/mamba') #change to your "whereis mamba" from terminal
#Sys.setenv(LD_LIBRARY_PATH=“/data/hps/assoc/private/franks_lab/user/jfra11/miniforge3/lib”) #point to where lib folder is
#
#library("reticulate")
#use_condaenv("franks_lab")   #change to your environment name
#-----------

# More environment building for spatial analysis --- 
# These first packages can be kind of problematic to install, they are needed for spatial analysis. 
# SP, GEOS, GDAL are installed with the mamba environment, which is ok for terminal R but not POSIT. 


#ok to skip if issues on terminal/HPC/Sasquatch
install.packages("sp") 

install.packages("rgeos", repos="http://R-Forge.R-project.org", type="source")
require(rgeos)

# ok to skip if issues on terminal/HPC/Sasquatch (deprecated as of May 2023?)
install.packages("rgdal", repos="http://R-Forge.R-project.org", type="source") 
require(rgdal)

install.packages("remotes")
library(remotes)
install_github("r-spatial/sf")


# Begin installing all other packages here ------------- 

# list all packages installed on old version of R (MacOS location)
if(exists("//Library/Frameworks/R.framework/Versions/4.0/Resources/library")){      #Intel 
  temp <- list.dirs("//Library/Frameworks/R.framework/Versions/4.0/Resources/library", 
                  full.names = F, recursive = F)
  } else if (exists("~/Library/R/arm64/4.4/library/")){     # M1
  temp <- list.dirs("~/Library/R/arm64/4.4/library/", 
                  full.names = F, recursive = F)
  } else {   # import list of packages from file 
  temp <- read.table("list.of.R.packages.txt", header = F)   #path to list of packages in a txt doc
  temp <- temp$V1
  }
  

# install CRAN packages ----
new.packages <- temp[!(temp %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


# install BIOCONDUCTOR packages----
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.19")

remaining.packages <- new.packages[!(new.packages %in% installed.packages()[,"Package"])]
if(length(remaining.packages)) BiocManager::install(remaining.packages)
BiocManager::install("Rgraphviz")


# install GITHUB directories -----
install.packages("devtools")

# you may face issues with Github API limits. set a Personal Access Token to bypass this.
usethis::create_github_token()    # this will give you the URL to create a PAT, follow instructions
gitcreds::gitcreds_set()       # enter the PAT when it prompts you to


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

devtools::install_github('cole-trapnell-lab/PLNmodels', ref="torch_gpu") # needs R >4.1
devtools::install_github('cole-trapnell-lab/hooke', ref="develop")



