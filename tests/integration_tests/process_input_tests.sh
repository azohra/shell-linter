#! /bin/bash

source ./entrypoint.sh "" "" "--debug"

test_debug_mode(){
    local expected_path=./test_data
    process_input > /dev/null
    local actual_path=$my_dir

    assertEquals "ERROR: Values did not match." "$expected_path" "$actual_path"
}

test_valid_file_input(){
    input_paths="./test_data/test_dir_1/valid_script.sh"
    local expected="Scanning valid_script.sh"
    local actual=$(process_input)

    assertContains "Did not find the message." "$actual" "$expected"
}

test_invalid_file1_input(){
    input_paths="./test_data/test.txt"
    local expected="Warning: invalid file extension. Make sure the input file 'test.txt' is a valid shell script."
    local actual=$(process_input)

    assertContains "Did not find the message." "$actual" "$expected" 
}

test_invalid_file2_input(){
    input_paths="./test_data/my_script"
    local expected="Warning: invalid file extension. Make sure the input file 'my_script' is a valid shell script."
    local actual=$(process_input)

    assertContains "Did not find the message." "$actual" "$expected" 
}

test_no_input_file(){
    input_paths="."
    local expected_message="Scanning all the scripts with format name.sh at ./test_data"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message"
}

test_input_directory(){
    input_paths="./test_data/test_dir_1"
    local expected_message1="Scanning all the scripts with format name.sh at ./test_data/test_dir_1"
    local expected_message2="Scanning valid_script.sh"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message1"
    assertContains "Did not find the message." "$actual_message" "$expected_message2"
}

test_multiple_input_directories(){
    input_paths="./test_data/test_dir_1,./test_data/test_dir_2"
    local expected_message1="Scanning all the scripts with format name.sh at ./test_data/test_dir_1"
    local expected_message2="Scanning all the scripts with format name.sh at ./test_data/test_dir_2"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message1"
    assertContains "Did not find the message." "$actual_message" "$expected_message2"
}

test_input_files_with_wildcard() {
    input_paths="./test_data/*.sh"
    local expected_message1="Scanning test_script_1.sh"
    local expected_message2="Scanning test_script_2.sh"
    local actual_message=$(process_input)
    
    assertContains "Did not find the message." "$actual_message" "$expected_message1"
    assertContains "Did not find the message." "$actual_message" "$expected_message2"
}

test_input_directories_with_wildcard() {
    input_paths="./test_data/test_dir*"
    local expected_message1="Scanning all the scripts with format name.sh at ./test_data/test_dir_1"
    local expected_message2="Scanning all the scripts with format name.sh at ./test_data/test_dir_2"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message1"
    assertContains "Did not find the message." "$actual_message" "$expected_message2"
}

test_severity_invalid_mode(){
    input_paths="./test_data/test_dir_1/valid_script_error.sh"
    severity_mode="verbose"
    local expected_message1="Error setting unknown severity mode. Defaulting severity mode to style."
    local expected_message2="ERROR: ShellCheck detected issues"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message1"
    assertContains "Did not find the message." "$actual_message" "$expected_message2"
}

tearDown(){
   input_paths="" 
}
source ./tests/shunit2