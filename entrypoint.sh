#! /bin/bash

file_params=$1
if [ -n "$1" ]; then
    for each_file in $(echo $file_params | tr "," "\n")
    do
        file=$(basename -- "$each_file")
        extension="${file##*.}"
        file_name="${file%.*}"
        if [ "$extension" != "sh" ]; then
            echo "Invalid File format. Please enter the path to a shell script with format name.sh"
            continue
        fi
        shellcheck $each_file
        exit_code=$?
        if [ $exit_code -eq 0 ] ; then
            echo "Successfully scanned ${each_file}"
        else
            echo "ShellCheck detected issues in ${each_file}"
        fi
        echo
    done
else
    echo "Please enter the path to a script with format name.sh"
    exit 1
fi