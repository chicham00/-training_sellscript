#!/bin/sh

#出力ファイル
output="./work/result"

# カレントディレクトリに、workディレクトリが存在したら、削除する
if [ -e ./work ]
then
  # 存在する場合
  rm -r ./work
fi

# カレントディレクトリに、workディレクトリを新規作成する
mkdir ./work

echo "200 404" >> ${output} 
# logsディレクトリをlsして、結果を1個ずつfor文でループする
for filename in `ls ./logs/`
do
  # (if文)ファイル名が"ssl_access_log"の場合、HTTPステータス200の行数を表示する
  # (if文)それ以外の場合、
  #   対象ログファイルをworkディレクトリにコピーし、
  #   コピーしたファイルを解凍し、解凍後のファイルを用いて、HTTPステータス200の行数を表示する
  #   表示後は、workディレクトリにあるコピーしたファイル、解凍後ファイルともに削除したい

  # みやすさのためにファイル名を表示
  echo ${filename}

  # (if文)ファイル名が"ssl_access_log"の場合、HTTPステータス200の行数を表示する
  if [ ${filename} = "ssl_access_log" ]
  then

    # ssl_access_logのHTTP200の集計結果をcount変数に代入すると定める
    count_200=`cat ./logs/${filename} | grep "\" 200 "  | wc -l`
    count_404=`cat ./logs/${filename} | grep "\" 404 "  | wc -l`

    #カウントした結果をoutputファイルに出力
    echo "${count_200} ${count_404}" >> ${output} 
  
  else 

    # 対象ログファイルをworkディレクトリにコピーし、
    cp -i ./logs/${filename} ./work/

    # コピーしたファイルを解凍し、
    tar -xzvf ./work/${filename}

    # 解凍後のファイルを用いて、
    filename2=`echo ${filename} | awk -F'.' '{print $1}'`
    #   HTTPステータス200の行数を表示する
    count_200=`cat ./work/${filename2} | grep "\" 200 "  | wc -l`
    count_404=`cat ./work/${filename2} | grep "\" 404 "  | wc -l`
    #カウントした結果をoutputファイルに出力
    echo "${count_200} ${count_404}" >> ${output} 

    # 表示後は、workディレクトリにあるコピーしたファイル、解凍後ファイルともに削除したい
    rm ./work/${filename}
    rm ./work/${filename2}
  
  fi
done

# 終了
echo "スクリプト終了"
exit


  

