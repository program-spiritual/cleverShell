#!/usr/bin/env bash
echo $$
# 73633


echo "File Name: $0"
echo "First Parameter : $1"
echo "Second Parameter : $2"
echo "Quoted Values: $@"
echo "Quoted Values: $*"
echo "Total Number of Parameters : $#"

for TOKEN in $*; do
  echo  $TOKEN
done

echo $?
