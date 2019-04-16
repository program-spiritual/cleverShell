#!/usr/bin/env bash

NAME01="Zara"
NAME02="Qadir"
NAME03="Mahnaz"
NAME04="Ayan"
NAME05="Daisy"


NAME[0]="Zara"
NAME[1]="Qadir"
NAME[2]="Mahnaz"
NAME[3]="Ayan"
NAME[4]="Daisy"

echo "First Index: ${NAME[0]}"
echo "Second Index: ${NAME[1]}"
# 访问数组中的所有项目
echo "First Method: ${NAME[*]}"
echo "Second Method: ${NAME[@]}"
