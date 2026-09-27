#!/bin/sh

if [ $# -ne 2 ]
then
    echo "Usage: $0 <directory> <string>"
    exit 1
fi

filesdir=$1
searchstr=$2

if [ -d "$filesdir" ]
then
    X=$(find "$filesdir" -type f | wc -l)
    Y=$(grep -r "$searchstr" "$filesdir" | wc -l)
    echo "The number of files are $X and the number of matching lines are $Y"
else
    echo "Error: $filesdir is not a directory"
    exit 1
fi