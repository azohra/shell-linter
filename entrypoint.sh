#! /bin/bash
# shellcheck disable=SC2155

input_paths="$1"
severity_mode="${2}"
execution_mode="$3"
my_dir=$(pwd)
status_code="0"
invalid_files=()

process_input(){      
    [ -n "$execution_mode" ] && my_dir="./test_data"

    severity_mode="$(echo $severity_mode | tr '[:upper:]' '[:lower:]')"

    if [[ "$severity_mode" != "style" && "$severity_mode" != "info" && "$severity_mode" != "warning" && "$severity_mode" != "error" ]]; then
        echo "Warning: unknown severity mode. Defaulting severity mode to style."
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
        [[ ${#invalid_files[@]} -gt 0 ]] && log_invalid_files 
        [ -z "$execution_mode" ] && exit $status_code
    else 
        scan_all "$my_dir"
        [[ ${#invalid_files[@]} -gt 0 ]] && log_invalid_files
        [ -z "$execution_mode" ] && exit $status_code
    fi
}

scan_file(){
    local file_path=$1
    local file=$(basename -- "$file_path")
    local first_line=$(head -n 1 "$file_path")
    local regex="\#\!.*\b(sh|bash|dash|ksh)\b"
    if [[ "$first_line" =~ $regex ]]; then
        echo
        echo "###############################################"
        # TODO change to ---
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
        invalid_files+=( $file_path )
        # printf "\n\e[33m ⚠️  Warning: '%s' is not a valid shell script.\e[0m\n" "$file_path"
    fi
}

scan_all(){
    echo "Scanning all the shell scripts at $1 🔎"
    local regex="\#\!.*\b(sh|bash|dash|ksh)\b"
    while IFS= read -r script 
    do
        local first_line=$(head -n 1 "$script")
        if [[ "$first_line" =~ $regex ]]; then
            scan_file "$script"
        else
            invalid_files+=( $script )
            # printf "\n\e[33m ⚠️  Warning: '%s' is not scanned. ShellCheck only supports sh/bash/dash/ksh scripts. If '%s' is a shell script, make sure there is a proper shebang on the first line.\e[0m\n" "$script" "$script"
        fi
    done < <(find "$1" -iname '*.sh' -o -iname '*.bash' -o -iname '*.ksh' -o ! -iname '*.*' -type f ! -path "$1/.git/*")
}

log_invalid_files(){
    printf "\n\e[33m ⚠️  Found %d unscanned files that could potentially be supported: \e[0m\n" "${#invalid_files[@]}"
    for file in ${invalid_files[@]}; do
        printf "\n\t\e[33m %s \e[0m\n" "$file"
    done
    printf "\n\e[33m ShellCheck only supports sh/bash/dash/ksh scripts. For supported scripts to be scanned, make sure to add a proper shebang on the first line of the script.\e[0m\n"

}

# To avoid execution when sourcing this script for testing
[ "$0" = "${BASH_SOURCE[0]}" ] && process_input "$@"
