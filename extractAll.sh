#!/bin/bash

# File:         renameTVShows.sh
# Author:       Roberto Rosende Dopazo 
#               <roberto[dot]rosende[dot]dopazo[at]gmail[dot]com>

# Script extracts all zip/rar/ace files in a given directory
# compressed files are deleted after extraction
# unzip, unace and unrar are required

if [ $# -lt 1 ];
then
        echo -e "\tUsage: extractAll.sh <path/with/files/to/extract>"
        exit 1
fi

if [ ! -d "$1" ];
then
        echo -e "\tUsage: extractAll.sh <path/with/files/to/extract>"
        echo -e "\tError: $1 is not a valid directory"
        exit 1
fi

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for f in `find $1 -name '*.zip'`;
do
  	#echo "Extracting: $f"
	unzip -o $f
	rm $f
done

for f in `find $1 -name '*.rar'`;
do
	#echo "Extracting: $f"
	unrar x -y $f
	rm $f
done

for f in `find $1 -name '*.ace'`;
do
	#echo "Extracting: $f"
	unace e -y $f
	rm $f
done
IFS=$SAVEIFS

exit 0
