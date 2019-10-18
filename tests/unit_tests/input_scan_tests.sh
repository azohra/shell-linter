#! /bin/bash

source ./entrypoint.sh "" "" "--debug"


test_scan_valid_file(){
    local expected="Scanning valid_script.sh"
    local actual=$(scan_file ./test_data/test_dir_1/valid_script.sh)
    assertContains "Messages did not match" "$actual" "$expected"
}

test_scan_invalid_file1(){
    local expected="Warning: invalid file extension. Make sure the input file 'test.txt' is a valid shell script."
    local actual=$(scan_file ./test_data/test.txt)
    assertContains "Messages did not match" "$actual" "$expected" 
}

test_scan_invalid_file2(){
    local expected="Warning: invalid file extension. Make sure the input file 'my_script' is a valid shell script."
    local actual=$(scan_file ./test_data/my_script)
    assertContains "Messages did not match" "$actual" "$expected" 
}

test_scan_a_directory(){
    local expected_message1="Scanning all the scripts with format name.sh at ./test_data/test_dir_1"
    local expected_message2="Scanning valid_script.sh"
    local expected_message3="Scanning invalid script.sh"
    local actual_message=$(scan_all ./test_data/test_dir_1)

    assertContains "$actual_message" "$expected_message1"
    assertContains "$actual_message" "$expected_message2"
}

source ./tests/shunit2