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
echo "********************************************"
echo "Testing the API Homepage..."
echo "********************************************"
echo "Expected output:"
expected="{\"info\":\"Welcome to Words RESTFUL API!\",\"name\":\"Homepage of Words RESTFUL API\",\"version\":\"1.0\"}"
echo "${expected}"
echo "Actual output: "
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
echo "********************************************"
echo "Testing the Words API Main Page..."
echo "********************************************"
echo "Expected output:"
expected="{\"info\":\"Let's enter Words Games!\"}"
echo "${expected}"
echo "Actual output: "
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
echo "Test case 3.1: No input is provided."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Input not provided!</p>'
echo "${expected}"
echo "Actual output: "
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

echo "Test case 3.2: Only one word is provided."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>At least 2 words need to be input!</p>'
echo "${expected}"
echo "Actual output: "
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

echo "Test case 3.3: Too many words were input."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Too many words! Please input 50 words or less.</p>'
echo "${expected}"
echo "Actual output: "
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

echo "Test case 3.4: One or more word in the input list is too long"
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Too long word! Please check the input!</p>'
echo "${expected}"
echo "Actual output: "
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

echo "Test case 3.5: Valid list of words are input"
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

###
#Test the finding rhyming words function
###
echo "********************************************"
echo "Testing the finding rhyming words function..."
echo "********************************************"
echo ""
echo "Test case 4.1: No input is provided."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Input not provided!</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/rhyme")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 4.1 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 4.1 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 4.2: More than one word is input."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Too many words! Please input one word.</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/rhyme?input=good,happy")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 4.2 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 4.2 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 4.3: The word string is empty."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>No word is provided!</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/rhyme?input=")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 4.3 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 4.3 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 4.4: The word is not a valid English word."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>The word is not a valid English word.</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/rhyme?input=n1gh3")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 4.4 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 4.4 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 4.5: The input word is too long."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Too long word! Check the word correctness.</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/rhyme?input=Pneumonoultramicroscopicsilicovolcanoconiosisssss")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 4.5 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 4.5 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 4.6: A valid English word (good) is input."
echo "Expected output:"
expected="[\"could\",\"fulwood\",\"goode\",\"hood\",\"misunderstood\",\"schuld\",\"should\",\"stood\",\"suhud\",\"understood\",\"withstood\",\"wood\",\"would\",\"you'd\"]"
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/rhyme?input=good")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 4.6 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 4.6 Failed${normal}"
fi
echo ""
echo ""


###
#Test the finding root word function
###
echo "********************************************"
echo "Testing the finding root words function..."
echo "********************************************"
echo ""

echo "Test case 5.1: No input is provided."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Input not provided!</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/stem")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 5.1 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 5.1 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 5.2: Too many words input."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Too many words. No more than 50 words can be processed.</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/stem?input=a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 5.2 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 5.2 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 5.3: The word string is empty."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>No word was input.</p>'
echo "${expected}"
echo "Actual output: "
#actual=$(curl -s -H "Accept:application/json" "http://localhost:${PORT}/")
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/stem?input=")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 5.3 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 5.3 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 5.4: The input word is too long."
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>Too long word! Please check!</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/stem?input=Pneumonoultramicroscopicsilicovolcanoconiosisssss")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 5.4 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 5.4 Failed${normal}"
fi
echo ""
echo ""

echo "Test case 5.5: One valid English word (friendly) is input."
echo "Expected output:"
expected="[\"friend\"]"
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/stem?input=friendly")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 5.5 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 5.5 Failed${normal}"
fi
echo ""
echo ""


echo "Test case 5.6: A list of valid English words is input."
echo "Input: generalize,generalization,generallized,general"
echo "Expected output:"
expected="[\"general\",\"general\",\"general\",\"general\"]"
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/stem?input=generalize,generalization,generallized,general")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 5.6 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 5.6 Failed${normal}"
fi
echo ""
echo ""

echo "Test case 5.7: One or more invalid word in the input list of words."
echo "Input: generalize,general123tion,generallized,general"
echo "Expected output:"
expected='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>400 Bad Request</title>
<h1>Bad Request</h1>
<p>The word general123tion is not a valid English word.</p>'
echo "${expected}"
echo "Actual output: "
actual=$(curl -s -H "Accept:application/json" "http://localhost:5000/words/stem?input=generalize,general123tion,generallized,general")
echo "${actual}"
total_test_cases=$((total_test_cases+1))

if [ "${expected}" == "${actual}" ]; then
	echo "${green} Test 5.7 Passed ${normal}"
	passed_test_cases=$((passed_test_cases+1))
else
    echo "${red} Test 5.7 Failed${normal}"
fi
echo ""
echo ""


echo "${green} ${passed_test_cases} test cases passed out of ${total_test_cases} total test cases.${normal}"
echo ""
