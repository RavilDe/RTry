# attach pachages
library(DATforDCEMRI) # this package you already have
library(oro.dicom)    # this you must install by install.packages("oro.dicom")

# read data from DICOM
DICOME_date <- oro.dicom::readDICOM(path = "~/Downloads/nadeeva/DICOMDIR")



# links:
# https://cran.r-project.org/web/packages/DATforDCEMRI/DATforDCEMRI.pdf
# https://cran.r-project.org/web/packages/oro.dicom/vignettes/dicom.pdf



