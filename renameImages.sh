#!/bin/bash

# File:         renameTVShows.sh
# Author:       Roberto Rosende Dopazo 
#               <roberto[dot]rosende[dot]dopazo[at]gmail[dot]com>

# Script to rename image files with its date from exif info
# it must be instantiated with files extension jpeg, jpg, JPG, JPEG
# jhead program is required

if [ $# -lt 1 ];
then
        echo -e "\tUsage: renameImages.sh <path/with/files/to/rename>"
        exit 1
fi

if [ ! -d "$1" ];
then
        echo -e "\tUsage: renameImages.sh <path/with/files/to/rename>"
        echo -e "\tError: $1 is not a valid directory"
        exit 1
fi

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

find $1 -type f -iname "*.jpeg" -o  \
                -iname "*.jpg" -o   \
                -iname "*.JPG" -o   \
                -iname "*.JPEG"	    |
while read -r FILE
do
	FILENAME=`basename ${FILE}`
        FILEPATH=`dirname ${FILE}`
        NEW=`jhead "$FILE" | grep date | sed 's/^File date[^:]\+: \(.\+\)$/\1/' | sed 's/\:/\./g'`.${FILENAME#*.}
	echo  mv -vn "$FILE" "$FILEPATH/$NEW"
done

IFS=$SAVEIFS
exit 0
