#!/bin/bash
# Copyright (c) 2023 Pirmin Pfeifer

declare -A foundUrls

level=0
domain=www.uni-wuerzburg.de/
foundUrls[$domain]=$level

frontier=($domain)
nextFrontier=()
mkdir -p "data"


while [ "${#frontier[@]}" -gt 0 ]; do
    ((level++))
    # Setup LevelFile
    file_name="data/level$level"
    touch $file_name
    echo "" > "$file_name"
    
    for url in "${frontier[@]}"; do

        echo "$level : $url"
        v=$(echo $(bash ./fetchAllHttpLinks.sh "$url" | grep -Eo "(http|https)://$domain[a-zA-Z0-9#~.*,/!?=+&_%:-]*" | grep -Eo "$domain[a-zA-Z0-9#~.*,/!?=+&_%:-]*" | grep -v '?'))
        read -r -a urls <<< "$v"

        declare -A neighbours

        for nextUrl in "${urls[@]}"; do
            if [[ ! ${foundUrls[${nextUrl}]+exists} ]]; then
                # next url not there -> add it  
                foundUrls["$nextUrl"]=$level
                nextFrontier+=($nextUrl)
            fi
            nextLevel="${foundUrls[${nextUrl}]}"
            if [ "$nextLevel" -eq "$level" ]; then
                # add connection in next level
                neighbours["$nextUrl"]=$nextUrl 
            fi
        done
        
        for nextUrl in "${neighbours[@]}"; do
        
                echo "\"$url\" -> \"$nextUrl\" " >> "$file_name"
        done
    done
    frontier=("${nextFrontier[@]}")  
    nextFrontier=()
done
exit 1