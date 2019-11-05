#!/bin/bash
####################################
#
# Backup al servidor remoto
#
####################################

# datos de origen
#daplicacion_fpdata="aplicacion_fpdata"
#daplicacion_fpdata_des="aplicacion_fpdata_desarrollo"

#DESTINO
dest="/datos/backups"
# Crear archivos comprimidos de destino
fecha=$(date +%F)
fechahora=$(date +%F-%T)

#DATOS DE ORIGEN
#webs 
d_webs="/datos/websfp"
#d_webs="/home/fpleaks/pruebas/"
f_webs="websfp"
fc_webs="$f_webs-$fecha.tgz"

#scripts de sincronizacion de datos
d_scripts="/home/fpleaks/"
f_scripts="scripts"
fc_scripts="$f_scripts-$fecha.tgz"

#documentacion
d_doc="/home/fpleaks/"
f_doc="documentacion"
fc_doc="$f_doc-$fecha.tgz"

#proyectos del directorio de datos
d_pdatos="/datos/"
f_fpdata="fpdata"
fc_fpdata="$f_fpdata-$fecha.tgz"
#proyectos del directorio de datos
f_fpmining="fpmining"
fc_fpmining="$f_fpmining-$fecha.tgz"
#mongo
fc_mongo="mongodump-$fecha.tgz"

#mysql
fc_mysqldump="mysqldump-$fecha.tgz"
#crontab
f_crontab="crontab-$fecha"


# Print start status message.
echo "Comenzando backup..."

#Copiado y compresión  de ficheros 
tar czf $dest/$fc_webs $d_webs

tar czf $dest/$fc_scripts $d_scripts/$f_scripts

tar czf $dest/$fc_doc $d_doc/$f_doc


tar czf $dest/$fc_fpdata $d_pdatos/$f_fpdata
tar czf $dest/$fc_fpmining $d_pdatos/$f_fpmining



#crontab
crontab -l > $dest/$f_crontab

#mysql
mysqldump  -uroot -pSuricato1.fp --all-databases > /datos/tmp/mysqldump
tar czf $dest/$fc_mysqldump /datos/tmp/mysqldump

#mongo
mongodump --out /datos/tmp/mongodump
tar czf $dest/$fc_mongo /datos/tmp/mongodump
# Print end status message.


echo
echo "Backup finalizado"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest

msg="Backup correcto a las"
python3 /usr/local/bin/avisotelegram.py $fechahora



