#! /bin/bash
# shellcheck disable=SC2155

input_paths="$1"
severity_mode="${2-style}"
execution_mode="$3"
my_dir=$(pwd)
status_code="0"

process_input(){      

    if [ -n "$execution_mode" ]; then
        my_dir="./test_data"
    fi

    severity_mode="$(echo $severity_mode | tr '[:upper:]' '[:lower:]')"

    if [[ "$severity_mode" != "style" && "$severity_mode" != "info" && "$severity_mode" != "warning" && "$severity_mode" != "error" ]]; then
        echo "Error setting unknown severity mode. Defaulting severity mode to style."
        severity_mode="style"
    fi

    if [ "$input_paths" != "." ]; then
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
        [ -z "$execution_mode" ] && exit $status_code
    fi
}

scan_file(){
    local file_path=$1
    local file=$(basename -- "$file_path")
    local first_line=$(head -n 1 "$file_path")
    if [[ "$first_line" == "#!"* ]]; then
        echo
        echo "###############################################"
        echo "         Scanning $file"
        echo "###############################################"
        shellcheck "$file_path" --severity="$severity_mode"
        local exit_code=$?
        if [ $exit_code -eq 0 ] ; then
            printf "%b" "Successfully scanned ${file_path} 🙌\n"
        else
            status_code=$exit_code
            printf "\e[31m ERROR: ShellCheck detected issues in %s.\e[0m\n" "${file_path} 🐛"
        fi
    else
        printf "\n\e[33m ⚠️  Warning: '%s' is not a valid shell script. Make sure shebang is on the first line.\e[0m\n" "$file_path"
    fi
}

scan_all(){
    echo "Scanning all the shell scripts at $1 🔎"
    while IFS= read -r script 
    do
        local first_line=$(head -n 1 "$script")
        if [[ "$first_line" == "#!"* ]]; then
            scan_file "$script"
        else
            printf "\n\e[33m ⚠️  Warning: '%s' is not scanned. If it is a shell script, make sure shebang is on the first line.\e[0m\n" "$script"
        fi
    done < <(find "$1" -name '*.sh' -o ! -name '*.*' -type f ! -path "$1/.git/*")
}

# To avoid execution when sourcing this script for testing
[ "$0" = "${BASH_SOURCE[0]}" ] && process_input "$@"