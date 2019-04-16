#!/usr/bin/env bash

Hello(){
  echo $1 $2
  return 10
}
Hello hi  james
VAR=$?

echo "last variable is $VAR"

# Calling one function from another
number_one () {
   echo "This is the first function speaking..."
   number_two
}

number_two () {
   echo "This is now the second function speaking..."
}

# Calling function one.
number_one
