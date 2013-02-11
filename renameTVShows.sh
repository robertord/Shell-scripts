#!/bin/bash

# File:         renameTVShows.sh
# Author:       Roberto Rosende Dopazo 
#               <roberto[dot]rosende[dot]dopazo[at]gmail[dot]com>

# Script renames downloaded files "cleaning" long filenames
#
# Script rename files returned by -iname expressions in given path 
# you can add more filetypes adding more <-o -iname ".ext"> params and 
# it deletes any matching expression with sed lines
# To include more expressions to delete or substitute only add sed 
# expressions on FILENEWNAME build

if [ $# -lt 1 ];
then
        echo -e "\tUsage: renameTVShows.sh <path/with/files/to/rename>"
        exit 1
fi

if [ ! -d "$1" ];
then
        echo -e "\tUsage: renameTVShows.sh <path/with/files/to/rename>"
        echo -e "\tError: $1 is not a valid directory"
        exit 1
fi

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

find $1 -type f -iname "*.avi" -o  \
                -iname "*.mkv" -o  \
                -iname "*.mp4" -o  \
                -iname "*.mpeg" -o \
                -iname "*.mpg" -o  \
                -iname "*.srt"     |
while read -r FILE
do
        FILENAME=`basename ${FILE}`
        FILEPATH=`dirname ${FILE}`
        FILENEWNAME=`
                echo ${FILENAME}                        	| \
                sed 's/\[/./gI'                          	| \
                sed 's/\]/./gI'                          	| \
                sed 's/www.newpct.com//gI'               	| \
                sed 's/newpct.com//gI'                   	| \
                sed 's/www.newpcestrenos.com//gI'        	| \
                sed 's/newpcestrenos.com//gI'            	| \
                sed 's/www.pctestrenos.com//gI'          	| \
                sed 's/pctestrenos.com//gI'              	| \
                sed 's/(EliteTorrent.net)//gI'           	| \
                sed 's/HDTV 720px//gI'                   	| \
                sed 's/HDTV 720p//gI'                    	| \
                sed 's/HDTV 720//gI'                     	| \
                sed 's/HDTV //gI'                        	| \
                sed 's/HDV//gI'                          	| \
                sed 's/HQ//gI'                           	| \
                sed 's/TV//gI'                           	| \
                sed 's/-NoTV//gI'                        	| \
                sed 's/REPACK//gI'                       	| \
                sed 's/DVDRip//gI'                       	| \
                sed 's/DSRRIP//gI'                       	| \
                sed 's/DVBRIP//gI'                       	| \
                sed 's/FRENCH//gI'                       	| \
                sed 's/BluRayRip//gI'                    	| \
                sed 's/XViD//gI'                         	| \
                sed 's/-PEPiTO//gI'                      	| \
                sed 's/XviD-FQM//gI'                     	| \
                sed 's/XVID//gI'                         	| \
                sed 's/HD//gI'                           	| \
                sed 's/VTV//gI'                          	| \
                sed 's/-LOL//gI'                         	| \
                sed 's/XviD-MiNT//gI'                    	| \
                sed 's/Español Castellano//gI'           	| \
                sed 's/Español//gI'                      	| \
                sed 's/Espa??ol//gI'                     	| \
                sed 's/espa??ol//gI'                     	| \
                sed 's/español//gI'                      	| \
                sed 's/AC3 5.1 //gI'                     	| \
                sed 's/AC3 5.1//gI'                      	| \
                sed 's/www.tumejortv.com//gI'            	| \
                sed 's/DVDRIP//gI'                       	| \
                sed 's/Spanish//gI'                      	| \
                sed 's/Castellano//gI'                   	| \
                sed 's/by k2_power//gI'                  	| \
                sed 's/Temporada \([0-9]\{1,\}\)//gI'    	| \
                sed 's/Temp.\([0-9]\{1,\}\)//gI'         	| \
                sed -e 's/[^a-zA-Z0-9]-[^a-zA-Z0-9]//gI' 	| \
                sed -e 's/\([0-9]\)x\([0-9]\{2\}\)/.\1\2./gI'   |\
                sed 's/[ ]\{2,\}/./gI'                   	| \
                sed -e 's/\s\{1,\}[\.]/./gI'             	| \
                sed -e 's/\([\.]\{2,\}\)/./gI'           	\
        `
        FILENEW=${FILEPATH}/${FILENEWNAME}
        if [ "${FILE}" != "${FILENEW}" ];
        then
                echo -e "Renaming: \n\t $FILE \n\t\t into \n\t $FILENEW \n" 
                mv "$FILE" "$FILENEW"
        fi
done

IFS=$SAVEIFS

exit 0

