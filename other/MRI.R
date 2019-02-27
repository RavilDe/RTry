# attach pachages
library(DATforDCEMRI)
library(oro.dicom)
library(oro.nifti)
library(dplyr)

# links:
# https://cran.r-project.org/web/packages/DATforDCEMRI/DATforDCEMRI.pdf

# Good example
# https://cran.r-project.org/web/packages/oro.dicom/vignettes/dicom.pdf

# Sigle File
fname <- system.file(file.path("dcm", "Abdo.dcm"), package = "oro.dicom")
abdo <- readDICOMFile(fname)
names(abdo)

head(abdo$hdr)
tail(abdo$hdr)

extractHeader(abdo$hdr, "BitsAllocated")
extractHeader(abdo$hdr, "Rows")
extractHeader(abdo$hdr, "Columns")

image(t(abdo$img), col=grey(0:64/64), axes = FALSE, xlab = "", ylab = "")

extractHeader(abdo$hdr, "Manufacturer", numeric = FALSE)

extractHeader(abdo$hdr, "RepetitionTime")


# Multiply Files
fname_2 <- system.file(file.path("hk-40", "hk40.RData"), package = "oro.dicom")
load(fname_2)

unlist(lapply(hk40, length))

hk40.info <- dicomTable(hk40$hdr)
# write.csv(hk40.info, file = "hk40_header.csv")
sliceloc.col <- which(hk40$hdr[[1]]$name == "SliceLocation")
sliceLocation <- as.numeric(hk40.info[, sliceloc.col])
head(sliceLocation)
head(diff(sliceLocation))
unique(extractHeader(hk40$hdr, "SliceThickness"))

extractHeader(hk40$hdr, "Manufacturer", numeric = FALSE) %>% unique()



# Third data-set ----------------------------------------------------------
fname <- system.file(file.path("dcm", "MR-sonata-3D-as-Tile.dcm"), 
                     package="oro.dicom")
dcm <- readDICOMFile(fname)
dim(dcm$img)

dcmImage <- create3D(dcm, mosaic = TRUE)
dim(dcmImage)


# new format NIfTI  ------------------------------------------------------
dput(formals(dicom2nifti))

(hk40n <- dicom2nifti(hk40))

image(hk40n)
orthographic(hk40n, col.crosshairs="green")
