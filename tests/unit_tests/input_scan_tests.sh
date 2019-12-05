#! /bin/bash
# shellcheck disable=SC2155

source ./entrypoint.sh "" "error" "--debug"


test_scan_valid_file_1(){
    local expected="Scanning example_script.sh"
    local actual=$(scan_file ./test_data/test_dir_1/example_script.sh)
    assertContains "Actual messages:$actual Did not contain the expected message.\n" "$actual" "$expected"
}

test_scan_valid_file2(){
    local expected="Scanning executable_script"
    local actual=$(scan_file ./test_data/test_dir_1/executable_script)
    assertContains "Actual messages:$actual Did not contain the expected message.\n" "$actual" "$expected" 
}

test_scan_invalid_file1(){
    local expected="Warning: './test_data/test.txt' is not a valid shell script. Make sure shebang is on the first line."
    local actual=$(scan_file ./test_data/test.txt)
    assertContains "Actual messages:$actual Did not contain the expected message.\n" "$actual" "$expected" 
}

test_scan_a_directory(){
    local message1="Scanning all the shell scripts at ./test_data/test_dir_1"
    local message2="Scanning example_script.sh"
    local message3="Scanning executable_script"
    local message4="Warning: './test_data/test_dir_1/invalid_script' is not scanned. If it is a shell script, make sure shebang is on the first line." 
    local actual_message=$(scan_all ./test_data/test_dir_1)

    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$message1"
    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$message2"
    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$message3"
    assertContains "Actual messages:$actual_message contains the expected message.\n" "$actual_message" "$message4"

}

test_scan_valid_file_error(){
    local expected_message1="Scanning valid_script_error.sh"
    local expected_message2="ERROR: ShellCheck detected issues"
    local actual_message=$(scan_all ./test_data/test_dir_1/valid_script_error.sh)

    assertContains "$actual_message" "$expected_message1"
    assertContains "$actual_message" "$expected_message2"
}

test_scan_valid_file_warning(){
    local expected_message1="Scanning valid_script_warning.sh"
    local expected_message2="Successfully scanned"
    local actual_message=$(scan_all ./test_data/test_dir_1/valid_script_warning.sh)
    
    assertContains "$actual_message" "$expected_message1"
    assertContains "$actual_message" "$expected_message2"
}

source ./tests/shunit2