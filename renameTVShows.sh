#!/bin/bash

# File:		renameTVShows.sh
# Author:	Roberto Rosende Dopazo 
# 		<roberto.rosende.dopazo[at]gmail[dot]com

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

if [ ! -d $1 ];
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
		echo ${FILENAME}                        | \
                sed 's/\[/./g'                          | \
                sed 's/\]/./g'                          | \
                sed 's/www.newpct.com//g'               | \
                sed 's/newpct.com//g'                   | \
                sed 's/www.newpcestrenos.com//g'        | \
                sed 's/newpcestrenos.com//g'            | \
                sed 's/www.pctestrenos.com//g'          | \
                sed 's/pctestrenos.com//g'              | \
                sed 's/(EliteTorrent.net)//g'           | \
		sed 's/HDTV 720px//g'                   | \
                sed 's/HDTV 720p//g'                    | \
		sed 's/HDTV 720//g'                     | \
		sed 's/HDTV //g'                        | \
		sed 's/HDV//g'                          | \
		sed 's/HQ//g'                           | \
		sed 's/TV//g'                           | \
		sed 's/-NoTV//g'                        | \
		sed 's/REPACK//g'                       | \
		sed 's/DVDRip//g'                       | \
		sed 's/dvdrip//g'                       | \
		sed 's/DSRRIP//g'                       | \
		sed 's/DSRRiP//g'                   	| \
		sed 's/FRENCH//g'                       | \
		sed 's/XViD//g'                         | \
		sed 's/-PEPiTO//g'                      | \
		sed 's/XviD-FQM//g'                     | \
		sed 's/XVID//g'                         | \
                sed 's/HD//g'                           | \
                sed 's/VTV//g'                          | \
                sed 's/-LOL//g'                         | \
                sed 's/XviD-MiNT//g'                    | \
                sed 's/Español Castellano//g'           | \
                sed 's/AC3 5.1 //g'                     | \
                sed 's/DVDRIP//g'                       | \
                sed 's/Spanish//g'                      | \
		sed 's/SPANISH//g'			| \
		sed 's/Castellano//g'			| \
                sed 's/Temporada \([0-9]\{1,\}\)//g'    | \
                sed 's/Temp.\([0-9]\{1,\}\)//g'         | \
                sed -e 's/[^a-zA-Z0-9]-[^a-zA-Z0-9]//g' | \
                sed 's/[ ]\{2,\}/./g'                   | \
                sed -e 's/\s\{1,\}[\.]/./g'             | \
                sed -e 's/\([\.]\{2,\}\)/./g'           \
                `
	FILENEW=${FILEPATH}/${FILENEWNAME}
        if [ "${FILE}" != "${FILENEW}" ];
        then
                echo -e "Renaming: \n\t $FILE \n\t\t into \n\t $FILENEW \n" 
                mv "${FILE}" "${FILEPATH}/{${FILENEW}"
        fi
done

IFS=$SAVEIFS

exit 0
