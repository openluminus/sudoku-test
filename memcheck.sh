#!/bin/bash
. config-sudoku
VERBOSE=0
VV="--quiet"
if [ ${VERBOSE} -eq 1 ]
then
    VV=""
fi


declare -a vg_args
vg_args=("${TEST_PATH}grid-01-size_1.sku" "${TEST_PATH}grid-05-size_25.sku"
	 "${TEST_PATH}grid-08-size_64.sku" "${TEST_PATH}grid-14-empty_line.sku"
	 "${TEST_PATH}grid-16-end_with_EOF_no_endofline.sku"
	 "${TEST_PATH}grid-25-random_number_of_spaces_tabs.sku"
	 "${TEST_PATH}grid-03-size_9.sku ${TEST_PATH}grid-05-size_25.sku")

TOTAL=${#vg_args[@]} #total number of tests

echo "---------- ( Checking Memory Usage [Sudoku]) ----------"

for argument in "${vg_args[@]}"; do
    #    valgrind ${PROJECT_PATH} `echo ${argument}` 2>&1 > ${FILE_OUTPUT} || ERR=$((ERR+1))
    echo ${argument}
#    valgrind ${VV} ${PROJECT_PATH}"sudoku" `echo ${argument}` || ERR=$((ERR+1))
done

echo "---------- ( Final Result ) ----------"
echo "Passed:$( expr ${TOTAL} - ${ERR}) Failed:${ERR}"
