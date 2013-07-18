#!/bin/bash

# File:         changeDownloadasName.sh
# Author:       Roberto Rosende Dopazo 
#               <roberto[dot]rosende[dot]dopazo[at]gmail[dot]com>

# Script renames files *.avi or *.mkv inside a dir
# it puts first name of dir to the file and then "clean" name 

if [ $# -lt 1 ];
then
        echo -e "\tUsage: changeDownloadsName.sh <path/with/dirs/to/rename>"
        exit 1
fi

if [ ! -d "$1" ];
then
        echo -e "\tUsage: changeDownloadsName.sh <path/with/dirs/to/rename>"
        echo -e "\tError: $1 is not a valid directory"
        exit 1
fi

PATHD=`readlink -f .`/
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
find $1 -mindepth 1 -type d |
while read -r DIR
do
        if [ "$DIR" != "$PATHD" ]&& [ "$DIR" != ".." ];
        then
                DIRNEWNAME=`
                                        echo ${DIR}     | \
                                        sed -e 's/\[/./gI'              | \
                                        sed -e 's/\]/./gI'              | \
                                        sed -e 's/\.$//gI'              \
                                        `
                DIRNEW=${DIRNEWNAME}
                if [ "${DIR}" != "${DIRNEW}" ];
                then
                        mv "$DIR"/*.avi "$DIRNEW.avi"
                        mv "$DIR"/*.mkv "$DIRNEW.mkv"
                        rm -rf $DIR
                fi
        fi
done
##now rename all files erasing unwanted parts
find $1 -type f -iname "*.avi" -o -iname "*.mkv" |
while read -r FILE
do
        FILENEW=`
                echo $FILE                                      | \
                sed 's/\[/./gI'                                 | \
                sed 's/\]/./gI'                                 | \
                sed 's/www.newpct.com//gI'                      | \
                sed 's/newpct.com//gI'                          | \
                sed 's/www.newpcestrenos.com//gI'               | \
                sed 's/newpcestrenos.com//gI'                   | \
                sed 's/www.pctestrenos.com//gI'                 | \
                sed 's/pctestrenos.com//gI'                     | \
                sed 's/(EliteTorrent.net)//gI'                  | \
                sed 's/HDTV 720px//gI'                          | \
                sed 's/HDTV 720p//gI'                           | \
                sed 's/HDTV 720//gI'                            | \
                sed 's/HDTV //gI'                               | \
                sed 's/HDV//gI'                                 | \
                sed 's/HQ//gI'                                  | \
                sed 's/TV//gI'                                  | \
                sed 's/-NoTV//gI'                               | \
                sed 's/REPACK//gI'                              | \
                sed 's/DVDRip//gI'                              | \
                sed 's/DSRRIP//gI'                              | \
                sed 's/BluRayRIP//gI'                           | \
                sed 's/BluRay Rip//gI'                          | \
                sed 's/AC3//gI'                                 | \
                sed 's/FRENCH//gI'                              | \
                sed 's/XViD//gI'                                | \
                sed 's/-PEPiTO//gI'                             | \
                sed 's/XviD-FQM//gI'                            | \
                sed 's/HD//gI'                                  | \
                sed 's/VTV//gI'                                 | \
                sed 's/-LOL//gI'                                | \
                sed 's/XviD-MiNT//gI'                           | \
                sed 's/Español Castellano//gI'                  | \
                sed 's/AC3 5.1 //gI'                            | \
                sed 's/Spanish//gI'                             | \
                sed 's/\(Proper\)//gI'                          | \
                sed 's/Temporada \([0-9]\{1,\}\)//gI'           | \
                sed 's/Temp.\([0-9]\{1,\}\)//gI'                | \
                sed -e 's/[^a-zA-Z0-9]-[^a-zA-Z0-9]/ /gI'       | \
                sed 's/[ ]\{2,\}/./gI'                          | \
                sed -e 's/\s\{1,\}[\.]/./gI'                    | \
                sed -e 's/\([\.]\{2,\}\)/./gI'                  \
                `
        if [ "${FILE}" != "${FILENEW}" ];
        then
                echo -e "Renaming: \n\t $FILE \n\t\t into \n\t $FILENEW" 
                mv "${FILE}" "${FILENEW}"
        fi
done

IFS=$SAVEIFS                                                                                                                                                                           
exit 0
