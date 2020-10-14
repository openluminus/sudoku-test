#!/bin/bash

VG=valgrind
TESTS="./grid-parser/"

ERR=0 #Failed tests counter
TOTAL=100 #total number of tests

echo "---------- ( Checking Memory Usage [Sudoku]) ----------"

${VG} ./sudoku -h || ERR=$((ERR+1))
${VG} ./sudoku ${TESTS}grid-01-size_1.sku || ERR=$((ERR+1))
${VG} ./sudoku ${TESTS}grid-05-size_25.sku || ERR=$((ERR+1))
${VG} ./sudoku ${TESTS}grid-08-size_64.sku || ERR=$((ERR+1))
${VG} ./sudoku ${TESTS}grid-14-empty_line.sku || ERR=$((ERR+1))
${VG} ./sudoku ${TESTS}grid-16-end_with_EOF_no_endofline.sku || ERR=$((ERR+1))
${VG} ./sudoku ${TESTS}grid-25-random_number_of_spaces_tabs.sku || ERR=$((ERR+1))
${VG} ./sudoku ${TESTS}grid-03-size_9.sku ${TESTS}grid-05-size_25.sku || ERR=$((ERR+1))


echo "---------- ( Final Result ) ----------"
echo "Passed: Failed:${ERR}"

