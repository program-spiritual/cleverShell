#!/usr/bin/env bash
##  echo 追加内容到文件尾
echo '
 export NVM_DIR="/Users/huhongyun/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
 export PATH="/usr/local/opt/qt/bin:$PATH"
' >> test.txt

