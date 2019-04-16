#!/usr/bin/env bash
## 格式化给定的数字  以逗号分隔符显示
## 可接收两个参数 DD TD

nicenumber(){
integer=$(echo $1|cut -d. -f1)
decimal=$(echo $1|cut -d. -f2)
# 检查数字是否为整数
if [ "$decimal" != "$1" ]; then
    result="$DD:='.'$decimal"
fi
thousands=$integer
while [ $thousands -gt 999 ]; do
    remainder=$(($thousands % 1000))
    # 包含三维数字 是否需要添加0？
    while [ ${#remainder} -lt 3 ]; do
    # 加入前导数字0
        remainder="0$remainder"
    done
    # 从右向左构建最终结果
result="${TD:=","}${remainder}${result}"
thousands=$(($thousands / 1000))
done

nicenum=${thousands}${result}
if [ ! -z $2 ]; then
   echo $nicenum
fi
}
# 主脚本开始
# ===================

while getopts "d:t:" opt; do
    case $opt in
    d) DD="$OPTARG"
       ;;
    t) DD="$OPTARG"
       ;;
    esac
done

shift $(($OPTIND -1 ))

## 输入验证

if [[ $# -eq 0 ]]; then
  #statements
  echo "Usage :$(basename $0) [-d c ] [-t c] numbric_value"
  echo "-d 指定小数点分隔符 (默认  '.')"
  echo "-t 指定数千个分隔符 (默认 ',')"
  exit 0
fi

nicenumber $1 1  ## 第二哥参数强制

exit 0 
