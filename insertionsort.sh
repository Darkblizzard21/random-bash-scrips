#!/bin/bash
# Copyright (c) 2023 Pirmin Pfeifer

# explane usage
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <number1> <number2> ..."
    exit 1
fi

array=("$@")
n=${#array[@]}

# sort with insetion sort
for i in `seq 0 $(($n-1))`; 
do 
    key=${array[i]}
    j=$(($i - 1))

    while [ $j -ge 0 ] && [ ${array[j]} -gt $key ]; 
    do
        array[j + 1]=${array[j]}
        let j-=1
    done
    array[j + 1]=$key
done

# Print the sorted numbers
count=0
for number in "${array[@]}"; do
    echo -n "$number "
    ((count++))
done
echo