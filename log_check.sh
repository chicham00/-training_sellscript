#!/bin/sh


# カレントディレクトリに、workディレクトリが存在したら、削除する
if [ -e ./work ]
then
  # 存在する場合
  rm -r ./work
fi

# カレントディレクトリに、workディレクトリを新規作成する
mkdir ./work

# logsディレクトリをlsして、結果を1個ずつfor文でループする
for filename in `ls ./logs/`
do
  # みやすさのためにファイル名を表示
  echo ${filename}

  # (if文)ファイル名が"ssl_access_log"の場合、HTTPステータス200の行数を表示する
  if [ ${filename} = "ssl_access_log" ]
  then
    cat ./logs/${filename} | grep "\" 200 " | wc -l
  # 結果を表示
    echo "ログのHTTPステータス200の行数は${count}行でした。"
     
  # (if文)それ以外の場合、
  else [ ${filename} != "ssl_access_log" ]

  #   対象ログファイルをworkディレクトリにコピーし、
    cp -i ./logs/${filename} ./work/

  #   コピーしたファイルを解凍し、
    tar -xzvf ./work/${filename}

  #   解凍後のファイルを用いて、
    filename2=`echo ${filename} | awk -F'.' '{print $1}'`
  #   HTTPステータス200の行数を表示する
    wc -l ./work/${filename2}

  #   表示後は、workディレクトリにあるコピーしたファイル、解凍後ファイルともに削除したい
    rm ./work/${filename}
    rm ./work/${filename2}
 echo "Chise"
 fi
done

# 終了
echo "スクリプト終了"
exit


  

