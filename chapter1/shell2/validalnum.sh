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