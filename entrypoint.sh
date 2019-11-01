#! /bin/bash
input_paths="$1"
logging_mode="$2"
execution_mode="$3"
my_dir=$(pwd)
VERSION="0.1.0"
status_code="0"

process_input(){      
    if [ -n "$execution_mode" ]; then
        my_dir="./test_data"
    fi

    if [ -n "$input_paths" ]; then
        # status_code=0
        for path in $(echo "$input_paths" | tr "," "\n"); do
            if [ -d "$path" ]; then
                scan_all "$path"
            else
                scan_file "$path"
            fi
        done
        if [ -z "$execution_mode" ]; then exit $status_code; fi
    else
        scan_all "$my_dir"
        if [ -z "$execution_mode" ]; then exit $status_code; fi
    fi
}

scan_file(){
    local file_path=$1
    local file=$(basename -- "$file_path")
    local extension="${file##*.}"

    if [ "$extension" == "sh" ]; then
        echo
        echo "###############################################"
        echo "         Scanning $file"
        echo "###############################################"
        shellcheck "$file_path"
        local exit_code=$?
        if [ $exit_code -eq 0 ] ; then
            echo "Successfully scanned ${file_path} 🙌"
        else
            status_code=$exit_code
            printf "\e[31m \n ERROR: ShellCheck detected issues in %s.\e[0m \n" "${file_path} 🐛"
        fi
    else
        printf "\e[33m ⚠️  Warning: invalid file extension. Make sure the input file '%s' is a valid shell script.\e[0m\n" "$file"
    fi
}

scan_all(){
    echo "Scanning all the scripts with format name.sh at $1 🔎"
    while IFS= read -r -d $'\0' script 
    do
        scan_file "$script"
    done < <(find "$1" -name '*.sh' -print0)
}


# To avoid execution when sourcing this script for unit testing
if [ "$0" = "${BASH_SOURCE[0]}" ]; then
    process_input "$@"
fi