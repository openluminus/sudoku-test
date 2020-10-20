#!/bin/bash
. config-sudoku

test_exit_sucess(){
	((EXIT_SUCCESS == $1)) && echo -e "*Passed*\n"  && return
	echo -e "***Failed!***\n"
	ERR=$((ERR+1))
	return 
}

test_exit_failure(){
	echo -n "Result: "
	((EXIT_FAILURE == $1)) && test_stderr && echo -e "*Passed*\n"  && return
	echo -e "***Failed!***\n"
	ERR=$((ERR+1))
	return 
}

test_stderr(){
	if(test -f $ERROR_FILE_TEST); then
		return  `cat $ERROR_FILE_TEST | (($(wc -l) >= 1))`
	else 
		echo '$ERROR_FILE_TEST'
	fi
}

test_file(){
	if(test -f $1); then 
		echo "file $1 exist !"
	fi
}

echo "moving to ${PROJECT_PATH}"
cd $PROJECT_PATH
echo -e '---------- ( Build System ) ----------\n'

echo "* Check 'make clean'"
echo "Expected result: EXIT_SUCCESS"
make clean > /dev/null
test_exit_sucess $?

echo "* Check 'make'"
echo "Expected result: EXIT_SUCCESS"
make &> /dev/null
test_exit_sucess $?

#Check requested files
#Check gcc call

echo "* Check 'make clean'"
echo "Expected result: clean target must remove all built files"
make clean > /dev/null 
#check all built files was remove
test_exit_sucess $?

echo "* Check 'make help'"
echo "Expected result: EXIT_SUCCESS"
make help > /dev/null
test_exit_sucess $?

echo -e '---------- ( Option Parser ) ----------\n'

make &> /dev/null

echo "* Check './sudoku'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?


echo "* Check './sudoku -x'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku -x 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku --xenophon'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku --xenophon 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku -v'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku -v 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku --verbose'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku --verbose 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?


echo "* Check './sudoku -V'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -V 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --version'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --version 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -h'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -h 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --help'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --help 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --he'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --he 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku grid-01-size_1.sku'"
echo "Expected result: EXIT_SUCCESS"
./sudoku $TEST_PATH/grid-01-size_1.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku grid-01-size_1.sku grid-02-size_4.sku grid-03-size_9.sku grid-04-size_16.sku'"
echo "Expected result: EXIT_SUCCESS"
./sudoku $TEST_PATH/grid-01-size_1.sku $TEST_PATH/grid-02-size_4.sku $TEST_PATH/grid-03-size_9.sku $TEST_PATH/grid-04-size_16.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -v grid-01-size_1.sku grid-02-size_4.sku grid-03-size_9.sku grid-04-size_16.sku'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -v $TEST_PATH/grid-01-size_1.sku $TEST_PATH/grid-02-size_4.sku $TEST_PATH/grid-03-size_9.sku $TEST_PATH/grid-04-size_16.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -x grid-01-size_1.sku'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku -x $TEST_PATH/grid-01-size_1.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku -v grid-01-size_1.sku'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -v $TEST_PATH/grid-01-size_1.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --verbose grid-01-size_1.sku'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --verbose $TEST_PATH/grid-01-size_1.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -o'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku -o 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku --output'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku --output 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku -o test.sku'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku -o $PREVIOUS_PWD/test.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku --output test.sku'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku --output $PREVIOUS_PWD/test.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku -o test.sku grid-01-size_1.sku'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -o $PREVIOUS_PWD/test.sku $TEST_PATH/grid-01-size_1.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --output test.sku grid-01-size_1.sku'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --output $PREVIOUS_PWD/test.sku $TEST_PATH/grid-01-size_1.sku 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?


echo "* Check './sudoku -o /test.sku grid-01-size_1.sku'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku -o /test.sku $TEST_PATH/grid-01-size_1.sku 1> /dev/null 2> $ERROR_FILE_TEST
#test if file was create ?
test_exit_failure $?

echo "* Check './sudoku --output /test.sku grid-01-size_1.sku'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku --output /test.sku $TEST_PATH/grid-01-size_1.sku 1> /dev/null 2> $ERROR_FILE_TEST
#test if file was create ?
test_exit_failure $?


echo "* Check './sudoku -g'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --generate'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --generate 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g1'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g1 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --generate=1'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --generate=1 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g4'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g4 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --generate=4'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --generate=4 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g9'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g9 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g16'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g16 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --generate=16'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --generate=16 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g25'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g25 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --generate=25'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --generate=25 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g36'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g36 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --generate=36'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --generate=36 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g49'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g49 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --generate=49'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --generate=49 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g64'"
echo "Expected result: EXIT_SUCCESS"
./sudoku -g49 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku --generate=64'"
echo "Expected result: EXIT_SUCCESS"
./sudoku --generate=64 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_sucess $?

echo "* Check './sudoku -g10'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku -g10 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?

echo "* Check './sudoku --generate=10'"
echo "Expected result: EXIT_FAILURE and stderr is written"
./sudoku --generate=10 1> /dev/null 2> $ERROR_FILE_TEST
test_exit_failure $?


echo "------- ( Final result ) --------"
echo "Passed: ;Failed: $ERR"
cd $PREVIOUS_PWD
