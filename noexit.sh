#!/bin/bash

trap "echo Booh! You thought you cout exit me with ^C" SIGINT SIGTERM
echo "pid is $$"

while :			# This is the same as "while true".
do
        sleep 60	# This script is not really doing anything.
done