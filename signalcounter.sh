#!/bin/bash

hangups=0 
quits=0 
display_signal_count() {
        echo hangups: $hangups
        echo quits: $quits
}

# count hangups 
trap 'let hangups+=1' SIGHUP   
# count quits 
trap 'let quits+=1' SIGQUIT   

trap 'display_signal_count' EXIT

while :			# This is the same as "while true".
do
        sleep 60	# This script is not really doing anything.
done