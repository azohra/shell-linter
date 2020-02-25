#! /bin/bash
# shellcheck disable=SC2155

source ./entrypoint.sh "" "" "--debug"

test_debug_mode(){
    local expected_path=./test_data
    process_input > /dev/null
    local actual_path=$my_dir

    assertEquals "ERROR: Values did not match." "$expected_path" "$actual_path"
}

test_valid_file_input(){
    input_paths="./test_data/test_dir_1/example_script.sh"
    local expected="Scanning example_script.sh"
    local actual=$(process_input)

    assertContains "Actual messages:$actual Did not contain the expected message.\n" "$actual" "$expected"
}

test_invalid_file1_input(){
    input_paths="./test_data/test.txt"
    local expected="Warning: './test_data/test.txt' is not a valid shell script. Make sure shebang is on the first line."
    local actual=$(process_input)

    assertContains "Actual messages:$actual Did not contain the expected message.\n" "$actual" "$expected" 
}

test_invalid_file2_input(){
    input_paths="./test_data/test_dir_1/invalid_script"
    local expected="Warning: './test_data/test_dir_1/invalid_script' is not a valid shell script. Make sure shebang is on the first line."
    local actual=$(process_input)

    assertContains "Actual messages:$actual Did not contain the expected message.\n" "$actual" "$expected" 
}

test_default_input_file(){
    input_paths="."
    local expected_message="Scanning all the shell scripts at ./test_data"
    local actual_message=$(process_input)

    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$expected_message"
}

test_input_directory(){
    input_paths="./test_data/test_dir_1"
    local message1="Scanning all the shell scripts at ./test_data/test_dir_1"
    local message2="Scanning example_script.sh"
    local message3="Scanning executable_script"
    local message4="Scanning not_executable_script"
    local actual_message=$(process_input)

    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$message1"
    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$message2"
    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$message3"
    assertNotContains "Actual messages:$actual_message contains the expected message.\n" "$actual_message" "$message4"
}

test_multiple_input_directories(){
    input_paths="./test_data/test_dir_1,./test_data/test_dir_2"
    local expected_message1="Scanning all the shell scripts at ./test_data/test_dir_1"
    local expected_message2="Scanning all the shell scripts at ./test_data/test_dir_2"
    local actual_message=$(process_input)

    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$expected_message1"
    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$expected_message2"
}

test_input_files_with_wildcard() {
    input_paths="./test_data/test_dir_2/test*.sh"
    local expected_message1="Scanning test_script_1.sh"
    local expected_message2="Scanning test_script_2.sh"
    local actual_message=$(process_input)
    
    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$expected_message1"
    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$expected_message2"
}

test_input_directories_with_wildcard() {
    input_paths="./test_data/test_dir*"
    local expected_message1="Scanning all the shell scripts at ./test_data/test_dir_1"
    local expected_message2="Scanning all the shell scripts at ./test_data/test_dir_2"
    local actual_message=$(process_input)

    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$expected_message1"
    assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$expected_message2"
}

test_severity_mode_invalid(){
    input_paths="./test_data/test_dir_3/test_script_warning.sh"
    severity_mode="verbose"
    local expected_message1="Error setting unknown severity mode. Defaulting severity mode to style."
    local expected_message2="SC2143"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message1"
    assertContains "Did not find the message." "$actual_message" "$expected_message2"
}

test_severity_mode_error(){
    input_paths="./test_data/test_dir_3/test_script_error.sh"
    severity_mode="error"
    local expected_message="SC1050"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message"
}

test_severity_mode_no_error(){
    input_paths="./test_data/test_dir_3/test_script_no_error.sh"
    severity_mode="error"
    local expected_message="Successfully scanned"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message"
}

test_severity_mode_warning(){
    input_paths="./test_data/test_dir_3/test_script_warning.sh"
    severity_mode="warning"
    local expected_message="SC2053"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message"
}

test_severity_mode_info(){
    input_paths="./test_data/test_dir_3/test_script_info.sh"
    severity_mode="info"
    local expected_message="SC2035"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message"
}

test_severity_mode_style(){
    input_paths="./test_data/test_dir_3/test_script_style.sh"
    severity_mode="style"
    local expected_message="SC2005"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message"
}

tearDown(){
   input_paths="" 
}
source ./tests/shunit2