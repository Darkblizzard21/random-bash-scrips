#!/bin/bash
# Copyright (c) 2023 Pirmin Pfeifer

if [ "$#" -ne 1 ]; then
    echo "Usage: folderToVis ouputFile"
    exit 1
fi

if ! command -v "dot" &>/dev/null; then
	read -p "dot is not available. Do you want to install graphviz? (y/n): " choice

	if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
			sudo apt update
			sudo apt install -y graphviz
	else
			echo "Installation of graphviz aborted. Exiting."
			exit 1
	fi
fi
x=$1
folderToVis="data"
ouputFile="vis.svg"

if [ ! -d "$folderToVis" ]; then
    echo "$folderToVis is not a directory or does not exist."
fi

str=""
for file in $folderToVis/*[0-9]; do
    file_number=$(echo "$file" | grep -oE '[0-9]+$')  # Extracting the number from the filename

    if [ "$file_number" -le "$x" ]; then
        echo $file_number
       str+=$(cat "$file")
    fi
done

result="digraph { ${str//./} }"
echo $result
echo $result | dot -Tsvg -o $ouputFile