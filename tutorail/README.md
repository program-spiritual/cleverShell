## 基础

### 1.  特殊变量
```shell
#!/usr/bin/env bash
echo $$
# 73633


echo "文件名称: $0"
echo "第一个参数 : $1"
echo "第二个参数 : $2"
echo "引用值: $@"
echo "引用值: $*"
echo "参数总数 : $#"

for TOKEN in $*; do
  echo  $TOKEN
done

echo $?
```
### 2.  定义数组
```shell 
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

echo "First Index: ${NAME[ 0 ]}"
echo "Second Index: ${NAME[ 1 ]}"
# 访问数组中的所有项目
echo "First Method: ${NAME[ * ]}"
echo "Second Method: ${NAME[ @ ]}"

```
### 3.  操作符
```shell
#!/usr/bin/env bash
val=`expr 3 + 3 `
echo "total value: $val"

```
### 4.  嵌套循环
```shell 
#!/usr/bin/env bash

a=0
while [[ "$a" -lt 10 ]]; do
  b=$a
  while [[ "$b" -ge 0 ]]; do
    echo -n "$b"
    b=`expr $b - 1 `
  done
  echo
  a=`expr $a + 1`
done

```
### 5.  变量替换
```shell
#!/usr/bin/env bash

DATE=`date`
echo "Date is $DATE"

USERS=`who | wc -l`
echo "Logged in user are $USERS"

UP=`date ; uptime`
echo "Uptime is $UP"

echo ${var:-"Variable is not set"}
echo "1 - Value of var is ${var}"
echo ${var:="Variable is not set"}
echo "2 - Value of var is ${var}"

unset var
echo ${var:+"This is default value"}
echo "3 - Value of var is $var"
var="Prefix"
echo ${var:+"This is default value"}
echo "4 - Value of var is $var"

echo ${var:?"Print this message"}
echo "5 - Value of var is ${var}"

```
### 6.  引用机制

```shell
#!/usr/bin/env bash

echo Hello \; world
echo "I have \$1200"
echo '<-$1500.**>; (update?) [y|n]'
VAR=ZARA
echo '$VAR owes <-$1500.**>; [ as of (`date +%m/%d`) ]'
echo "$VAR owes <-\$1500.**>; [ as of (`date +%m/%d`) ]"


```

### 7.  读写

```shell
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

```

### 8.函数

```shell
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

```
9 . sed 

```shell
#!/usr/bin/env bash

cat /etc/passwd | sed

```
