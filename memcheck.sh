#!/bin/bash

VG=valgrind
TESTS=" ../grid-parser/"
SUDOKU="../../sudoku"

VERBOSE=0

FILE_OUTPUT="/dev/null"

if [ ${VERBOSE} -eq 1 ]
then
    VV="/dev/stdout"
fi


declare -a vg_args
vg_args=("${TESTS}grid-01-size_1.sku" "${TESTS}grid-05-size_25.sku"
	 "${TESTS}grid-08-size_64.sku" "${TESTS}grid-14-empty_line.sku"
	 "${TESTS}grid-16-end_with_EOF_no_endofline.sku"
	 "${TESTS}grid-25-random_number_of_spaces_tabs.sku"
	 "${TESTS}grid-03-size_9.sku ${TESTS}grid-05-size_25.sku")

ERR=0 #Failed tests counter
TOTAL=${#vg_args[@]} #total number of tests

echo "---------- ( Checking Memory Usage [Sudoku]) ----------"

for argument in "${vg_args[@]}"; do
    ${VG} ${SUDOKU} `echo ${argument}` 2>&1 >${FILE_OUTPUT} || ERR=$((ERR+1))
done

echo "---------- ( Final Result ) ----------"
echo "Passed:$( expr ${TOTAL} - ${ERR}) Failed:${ERR}"
