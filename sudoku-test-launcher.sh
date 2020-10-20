#!/bin/bash
#source the config file
export ERR=0
. config-sudoku

./option_parser.sh
./memcheck.sh
