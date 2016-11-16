# ABAP-Utilities-File-Class
Report to check the translations elements in ABAP

## How to use it:

### CALCULATE_FILE_SIZE

INPUT:
> TYPE = ASC (ASCII File) or BIN (Binary File)
> DATA = File Content

OUTPUT:
> SIZE = File size in MegaBytes

### CREATE_ZIP_FILE_APP_SVR

INPUT:
> ZIP_NAME = Name of the ZIP file to create in the Application Server
> FILES    = Content of the ZIP file.

FILES:

1. FILE_NAME        = File to add into the ZIP
2. FILE_NAME_IN_ZIP = Name of the file into the ZIP
