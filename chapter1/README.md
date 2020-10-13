## 目录

### 1.在PATH中查找程序
```shell
#!/usr/bin/env bash
# 验证指定程序是否有效 或者是否能够在PATH中找到
in_path(){
# 找给定的命令 找到 返回 0
# 没找到 返回 1
# 函数执行完成后 恢复
#IFS是internal field separator 的缩写，shell的特殊环境变量。ksh根据IFS存储的值，可以是空格、tab、换行符或者其他自定义符号，来解析输入和输出的变量值。
# 具体请查看  http://xstarcd.github.io/wiki/shell/IFS.html
  cmd=$1  ourpath=$2 result=1
  oldIFS=$IFS   IFS=":"
  for directory in $ourpath ; do
      if [-x $directory/$cmd]; then
          reuslt=0 # 找到命令 😊
      fi
  done
  IFS = $oldIFS
  return $reuslt
}

# -x 检查是否存在
checkForCmdInPath()
{
  var=$1

  if [ "$var" != "" ] ; then
  # 也可以使用  $(echo $var | cut -c1)
  # 殊途同归
      if [ "${var%${var#?}}" = "/" ]; then
          if [ ! -x $var ]; then
              return 1
          fi
      elif ! in_path $var "$PATH" ; then
        return 2
      fi
  fi
}

if [ $# -ne 1 ]; then
    echo "使用: $0 command" >&2
  exit 0
fi
if [ "$BASH_SOURCE" = $0 ] ; then

checkForCmdInPath "$1"
case $? in
0)
  echo "$1 found in path" ;;
1)
  echo "$1 not found in path or not excutable" ;;
2)
  echo "$1 found in PATH" ;;
esac
fi
exit 0

```
### 2.验证输入 仅限字母数字
```shell 
#!/usr/bin/env bash

# 确保输入内容只是字母和数字

validAlphaNum(){
  ## 如果输入的数据全是字母和数字 返回 0  否则 返回 1
  # [:alnum:] -- POSIX 正则表达式简写 -- 代表字母数字字符
  validchars="$( echo $1 | sed -e 's/[^[:alnum:]]//g' )"
  echo $validchars
  echo $1
  if [ "$validchars" = "$1" ]; then
   return 0
  else
   return 1
  fi
}

## 主脚本开始 引用次脚本 直接 注释以下内容

/bin/echo -n "Enter input："

read input

## 输入验证

if ! validAlphaNum "$input"; then
    echo "您输入的内容不是字母和者数字" >&2
    exit 1
else
  echo "正确输入 "
fi

exit 0
```
### 3.输出多行文本
```shell 
#!/usr/bin/env bash
##  echo 追加内容到文件尾
echo '
 export NVM_DIR="/Users/huhongyun/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
 export PATH="/usr/local/opt/qt/bin:$PATH"
' >> test.txt


```
### 4.规范日期格式
```shell 
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
```
### 5.美化多位数字
```shell 
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

```
### 6.验证整数输入

```shell 
#!/bin/bash
# validint--验证整数输入，也允许使用负整数。

validint()
{
  # 验证第一个字段并针对最小值$2和/或测试该值
  # 最大值 $3 ,如果他们已经被提供了: 如果该值不在范围内或
  # 它不是仅由数字组成，失败。

  number="$1";      min="$2";      max="$3"

  if [ -z $number ] ; then
    echo "You didn't enter anything. Please enter a number." >&2 ; return 1
  fi

  # 第一个字符是“-”符号吗？
  if [ "${number%${number#?}}" = "-" ] ; then
    testvalue="${number#?}" # 捕获除第一个字符以外的所有字符进行测试。
  else
    testvalue="$number"
  fi

  # 创建没有数字的数字版本，以进行测试。
  nodigits="$(echo $testvalue | sed 's/[[:digit:]]//g')"

  # 检查非数字字符。
  if [ ! -z $nodigits ] ; then
    echo "无效的数字格式！仅数字，无逗号，空格等" >&2
    return 1
  fi

  if [ ! -z $min ] ; then
    # 输入是否小于最小值？
    if [ "$number" -lt "$min" ] ; then
      echo "$number 太小了: 最小可接受值为 $min" >&2
      return 1
    fi
  fi
  if [ ! -z $max ] ; then
    # 输入是否大于最大值？
    if [ "$number" -gt "$max" ] ; then
      echo "您输入的值太大：可接受的最大价值是：$max" >&2
      return 1
    fi
  fi
  return 0
}

# 输入验证
if validint "$1" "$2" "$3" ; then
  echo "输入是您约束内的有效整数"
fi
```
### 7. 字符串拆分

```shell 
#!/usr/bin/env bash

var="something wocked this way comes "
echo ${var:10}
echo ${var:0:1}
echo ${var:10:6}

```