#Este documento contiene código para descargar, leer, guardar y manipular en R la base de datos correspondiente al Cuestionario de Contexto del Docente del EXCALE 06 (Sexto de Primaria), aplicación 2013.

#1. Instalación de paquetes necesarios.
#Comprobación de que los paquetes requeridos están instalados; si están instalados, los incluye al espacio de trabajo; si no están instalados, los descarga e instala.
ifelse("readr" %in% installed.packages(), require("readr"), install.packages("readr"))

#2. Descarga del archivo .zip que contiene la base de datos.
download.file("http://www.inee.edu.mx/images/stories/documentos_pdf/Bases_Datos/EXCALE06_2013/Excale06_2013_Doc_Cuest.zip", "Excale06_2013_Doc_Cuest.zip")

#3. Extracción de la base de datos a la carpeta de trabajo.
unzip("Excale06_2013_Doc_Cuest.zip", files = "Excale06_2013_Doc_Cuest.TXT")

#4. Asignación de información de anchos de columnas y nombres de columnas a las variables "anchos" y "nombres".
anchos <- c(1, 4, 2, 19, 1, 3, 7, 6, 12, 11, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 3, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11)
nombres <- c("NACIONAL", "ESCUELA", "ID_ENT", "NOM_ENT", "ID_MOD", "MOD", "ESTRATO", "ENTEST", "ID_INSTR", "W_DOC", "DOCENTE", "PP001", "PP002", "PP003", "PP004", "PP005", "PP006", "PP007", "PP008", "PP009", "PP010", "PP011", "PP012", "PP013", "PP014", "PP015", "PP016", "PP017", "PP018", "PP019", "PP020", "PP021", "PP022", "PP023", "PP024", "PP025", "PP026", "PP027", "PP028", "PP029", "PP030", "PP031", "PP032", "PP033", "PP034", "PP035", "PP036", "PP037_1", "PP037_2", "PP037_3", "PP037plot_4", "PP037_5", "PP037_6", "WVARSTRR", "W_FSTR1", "W_FSTR2", "W_FSTR3", "W_FSTR4", "W_FSTR5", "W_FSTR6", "W_FSTR7", "W_FSTR8", "W_FSTR9", "W_FSTR10", "W_FSTR11", "W_FSTR12", "W_FSTR13", "W_FSTR14", "W_FSTR15", "W_FSTR16", "W_FSTR17", "W_FSTR18", "W_FSTR19", "W_FSTR20", "W_FSTR21", "W_FSTR22", "W_FSTR23", "W_FSTR24", "W_FSTR25", "W_FSTR26", "W_FSTR27", "W_FSTR28", "W_FSTR29", "W_FSTR30", "W_FSTR31", "W_FSTR32", "W_FSTR33", "W_FSTR34", "W_FSTR35", "W_FSTR36", "W_FSTR37", "W_FSTR38", "W_FSTR39", "W_FSTR40", "W_FSTR41", "W_FSTR42", "W_FSTR43", "W_FSTR44", "W_FSTR45", "W_FSTR46", "W_FSTR47", "W_FSTR48", "W_FSTR49", "W_FSTR50", "W_FSTR51", "W_FSTR52", "W_FSTR53", "W_FSTR54", "W_FSTR55", "W_FSTR56", "W_FSTR57", "W_FSTR58", "W_FSTR59", "W_FSTR60", "W_FSTR61", "W_FSTR62", "W_FSTR63", "W_FSTR64", "W_FSTR65", "W_FSTR66", "W_FSTR67", "W_FSTR68", "W_FSTR69", "W_FSTR70", "W_FSTR71", "W_FSTR72", "W_FSTR73", "W_FSTR74", "W_FSTR75", "W_FSTR76", "W_FSTR77", "W_FSTR78", "W_FSTR79", "W_FSTR80", "W_FSTR81", "W_FSTR82", "W_FSTR83", "W_FSTR84", "W_FSTR85", "W_FSTR86", "W_FSTR87", "W_FSTR88", "W_FSTR89", "W_FSTR90", "W_FSTR91", "W_FSTR92", "W_FSTR93", "W_FSTR94", "W_FSTR95", "W_FSTR96", "W_FSTR97", "W_FSTR98", "W_FSTR99", "W_FSTR100")

#5. Lectura de la base de datos y asignación a la variable doc.
#En este paso se emplea el paquete "readr" para leer la base de datos con la funcion read_fwf, la cual es más rápida que la función read.fwf del paquete "base", diferencia notable particularmente en equipos de cómputo poco poderosos. ("readr" es instalado en el paso 1.)
doc <- read_fwf("Excale06_2013_Doc_Cuest.TXT", fwf_widths(anchos, nombres))

#6. Recodificación de valores numéricos que indican datos perdidos a NA.
doc[ , 8][doc[ , 8] == "999"] <- NA
doc[ , c(12:45, 47:53)][doc[ , c(12:45, 47:53)] > 7] <- NA
doc[ , 46][doc[ , 46] > 97] <- NA

#7. Escritura de la base de datos a un archivo csv, que permite una lectura más sencilla de la misma con la función read_csv de "readr" o read.csv de "base".
write_csv(doc, "excale06_2013_cuest_doc.csv")

#8. Lectura de la base de datos como csv y asignación a la variable doc.
doc <- read_csv("excale06_2013_cuest_doc.csv")

#9. Eliminación de las variables anchos y nombres.
rm(anchos, nombres)
