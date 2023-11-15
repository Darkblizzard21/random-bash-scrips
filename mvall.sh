#!/bin/bash
# Copyright (c) 2023 Pirmin Pfeifer

# Überprüfen, ob die Anzahl der Parameter korrekt ist
if [ "$#" -ne 2 ] && [ "$#" -ne 3 ]; then
    echo "Usage: $0 [--log] <target_directory> <file_extension>"
    exit 1
fi

# check if log is on
if [ "$#" -eq 3 ] && [ "$1" != "--log" ]; then
    echo "Error: Invalid option '$1'. Expected '--log'."
    exit 1
fi

extension="N/A"
folder="N/A"

if [ "$#" -eq 2 ]; then
    extension=$1 
    folder=$2
else 
    extension=$2 
    folder=$3
fi


# create folder 
if [ -e "$folder" ]; then
    if [ "$#" -eq 3 ]; then
        echo "Target directory '$folder' already exists skip creating folder"
    fi
else 
    mkdir "$folder"
fi

# count files
file_count=$(find . -maxdepth 1 -type f -name "*.pdf" | wc -l)

# move files
if [ "$file_count" -gt 0 ]; then
    mv *$extension "$folder"/
fi

# write log info if needed
if [ "$#" -eq 3 ]; then
    echo "Moved $file_count files to $folder"
fi
