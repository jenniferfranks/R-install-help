Instructions and code to help speed up new installs and updates of R versions (esp for single cell analysis)

Developed using MacOS and Linux cluster (created 2023, last updated 8/2024)

Be sure to update filepaths as appropriate. 

Sasquatch Users: please reference: http://gonzo/hpcGuide_dev/0_QuickStart.html

***YMMV!***

General steps:
1) Prepare the environment for installing R:
   - if using MacOS, see system_prep-MacOS-Intel
   - for SCRI HPC, see Sasquatch_environment_building
2) Prepare list of R packages to be installed
   - for new install, download list.of.R.packages.txt
   - for R update on same machine, locate folder with list of packages
3) Run through: Re-InstallingPackages.R (recommend doing this line by line to address issues) 
