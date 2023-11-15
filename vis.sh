#!/bin/bash

if [ "$#" -ne 2 ]; then
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

folderToVis=$1
ouputFile=$2

if [ ! -d "$folderToVis" ]; then
    echo "$folderToVis is not a directory or does not exist."
fi

folderToVis=$(realpath "$folderToVis")

buildGraph() {
    currentPath="$1"
    currentFolder=$(basename "$currentPath")

    result=''
    for f in $(ls "$currentPath"); do
        fPath="$currentPath/$f"
        if [ -d "$fPath" ]; then
            result+=$(buildGraph "$fPath")
        fi
        result+="\"$currentFolder\" -> \"$f\" "
    done
    echo $result
}

result=$(buildGraph "$folderToVis")
result="digraph { $result }"
echo $result
echo $result | dot -Tsvg -o $ouputFile