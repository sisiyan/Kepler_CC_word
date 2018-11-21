#!/bin/bash
# This script will run automated tests on the API.

green=`tput setaf 2`
red=`tput setaf 1`
normal=`tput sgr0`

total_test_cases=0
passed_test_cases=0

###
#Test the home page
###
echo "Testing the API Homepage..."
echo "Expected output:"
expected="{\"name\":\"Welcome to Words RESTFUL API\",\"version\":\"1.0\"}"
echo "{\"name\":\"Welcome to Words RESTFUL API\",\"version\":\"1.0\"}"
echo "Actual output: "
#actual=$(curl -s -H "Accept:application/json" "http://localhost:${PORT}/")
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 1 Passed${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 1 Failed${normal}"
fi
echo ""
echo ""

###
#Test the Words API main page
###
echo "Testing the Words API Main Page..."
echo "Expected output:"
expected="{\"name\":\"Let's enter Words Games!\"}"
echo "{\"name\":\"Let's enter Words Games!\"}"
echo "Actual output: "
#actual=$(curl -s -H "Accept:application/json" "http://localhost:${PORT}/")
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 2 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 2 Failed${normal}"
fi
echo ""
echo ""


###
#Test the word randomly picking function
###
echo "********************************************"
echo "Testing the random word picking function..."
echo "********************************************"
echo ""
echo "Test case 1: No input is provided."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Input not provided!</p>'
echo "${expected}"
echo "Actual output: "
#actual=$(curl -s -H "Accept:application/json" "http://localhost:${PORT}/")
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/randomword")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 3.1 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 3.1 Failed${normal}"
fi
echo ""
echo ""

echo "Test case 2: Only one word is provided."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>At least 2 words need to be input!</p>'
echo "${expected}"
echo "Actual output: "
#actual=$(curl -s -H "Accept:application/json" "http://localhost:${PORT}/")
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/randomword?input=good")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 3.2 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 3.2 Failed${normal}"
fi
echo ""
echo ""

echo "Test case 3: Too many words were input."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Too many words! Please input 50 words or less.</p>'
echo "${expected}"
echo "Actual output: "
#actual=$(curl -s -H "Accept:application/json" "http://localhost:${PORT}/")
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/randomword?input=a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 3.3 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 3.3 Failed${normal}"
fi
echo ""
echo ""

echo "Test case 4: One or more word in the input list is too long"
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Too long word! Please check the input!</p>'
echo "${expected}"
echo "Actual output: "
#actual=$(curl -s -H "Accept:application/json" "http://localhost:${PORT}/")
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/randomword?input=good,Pneumonoultramicroscopicsilicovolcanoconiosisssss")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 3.4 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 3.4 Failed${normal}"
fi
echo ""
echo ""

echo "Test case 5: Valid list of words are input"
echo "Expected output:"
expected_1="{\"randomly picked word\":\"good\"}"
expected_2="{\"randomly picked word\":\"better\"}"
expected_3="{\"randomly picked word\":\"best\"}"
echo ${expected_1}
echo "OR "${expected_2}
echo "OR "${expected_3}
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/randomword?input=good,better,best")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected_1}" == "${actual}" ] || [ "${expected_2}" == "${actual}" ] || [ "${expected_3}" == "${actual}" ]; then
	echo "${green} Test 3.5 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 3.5 Failed${normal}"
fi
echo ""
echo ""
