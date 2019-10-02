#! /bin/bash

if [ -n "$1" ]; then
    file=$(basename -- "$1")
    extension="${file##*.}"
    file_name="${file%.*}"
    if [ "$extension" != "sh" ]; then
        echo "Invalid File format. Please enter the path to a shell script with format name.sh"
        exit 1
    fi
    shellcheck $1
else
    echo "Please enter the path to a script with format name.sh"
    exit 1
fi