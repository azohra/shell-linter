#! /bin/bash

source ./entrypoint.sh "" "" "" "--test"

test_exclude_no_error(){
    input_paths="./test_data/exclude/test_script_exclude_none.sh"
    severity_mode="style"
    exclude_code=""
    local expected_message="SC2154"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message"
}

test_exclude_one_error(){
    input_paths="./test_data/exclude/test_script_exclude_one_error.sh"
    severity_mode="style"
    exclude_code="SC2039"
    local expected_first_error="SC2034"
    local expected_second_error="SC1068"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_first_error"
    assertContains "Did not find the message." "$actual_message" "$expected_second_error"
}

test_exclude_multiple_errors(){
    input_paths="./test_data/exclude/test_script_exclude_multiple_errors.sh"
    severity_mode="style"
    exclude_code="SC2034,SC2005,SC2034,SC1066"
    local expected_message="Successfully scanned"
    local actual_message=$(process_input)

    assertContains "Did not find the message." "$actual_message" "$expected_message"
}

tearDown(){
   input_paths="" 
}

source ./tests/shunit2
