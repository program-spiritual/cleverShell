#!/usr/bin/env bash

# 月份 三个字母
monthNumToName() {
  case $1 in
    1) month="Jan"
    ;;
    2) month="Feb"
    ;;
    3) month="Mar"
    ;;
    4) month="Apr"
    ;;
    5) month="May"
    ;;
    6) month="Jun"
    ;;
    7) month="Jul"
    ;;
    8) month="Aug"
    ;;
    9) month="Jan"
    ;;
    10) month="Oct"
    ;;
    11) month="Nov"
    ;;
    12) month="Dec"
    ;;
    *) echo "$0 未知的月数数字 $1" >&2
    exit 1
  esac
}
## 主脚本开始
if [ $# -eq 1 ]; then
  set -- $(echo $1|sed 's/[\/\/]/ /g')
fi
if [ $# -ne 3 ]; then
  echo "格式是 August 3 1962 和  8 3 1962" >&2
  exit 1
fi
if [ $3 -le 99 ]; then
  echo "$0 预测是四位数的年份"
  exit 1

fi
if [ -z $(echo $1 | sed 's/[[:digit:]]//g') ]; then
  monthNumToName $1
else
  # 规范前三个字母 首字母大写 其余小写
  month="$(echo $1|cut -c1|tr ':[lower]:' ':[upper]:')"
  month="$month$(echo $1|cut -c2-3 | tr '[:upper:]' '[:lower:]')"
fi

echo $month $2 $3

exit 0