#!/usr/bin/env bash
# 验证指定程序是否有效 或者是否能够在PATH中找到
in_path(){
# 找给定的命令 找到 返回 0
# 没找到 返回 1
# 函数执行完成后 恢复
#IFS是internal field separator的缩写，shell的特殊环境变量。ksh根据IFS存储的值，可以是空格、tab、换行符或者其他自定义符号，来解析输入和输出的变量值。
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
