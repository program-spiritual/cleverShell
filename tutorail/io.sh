#!/usr/bin/env bash

who > users
cat users
cat << EOF
This is a simple lookup program
for good (and bad) restaurants
in Cape Town.
EOF

filename=test.txt
vi $filename <<EndOfCommands
i
This file was created automatically from
a shell script
^[
ZZ
EndOfCommands
