#! /bin/bash

source ./entrypoint.sh "" "" "--debug"

test_scan_invalid_script_with_extension(){
    local message1="Scanning test_script.js"
    local actual_message=$(scan_all ./test_data/test_dir_2)

    assertNotContains "Actual messages:$actual_message contains the expected message.\n" "$actual_message" "$message1"}
    # assertContains "Actual messages:$actual_message Did not contain the expected message.\n" "$actual_message" "$message1"
    # assertNotContains "Actual messages:$actual_message contains the expected message.\n" "$actual_message" "$message4"
}

test_scan_invalid_script_without_extension(){
    local message1="Scanning test_python"
    local actual_message=$(scan_all ./test_data/test_dir_2)

    assertNotContains "Actual messages:$actual_message contains the expected message.\n" "$actual_message" "$message1"}
}

source ./tests/shunit2
