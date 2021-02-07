# log_training
シェルスクリプトの練習がてら、ログ調査の練習をしてもらうための道具

# 環境構築
git clone https://github.com/supikid/log_training.git
cd log_training

# ファイル一覧
    - execute.sh
        本プロジェクトの実行ファイル。このファイルを修正して実行しましょう。
    
    - logs/ssl_access_log
    - logs/ssl_access_log-YYYYMMDD.tar.gz
        本プロジェクト用に用意したログ・ファイル。
    
    - sample
        シェルスクリプトを組む上で参考になりそうなサンプルを用意しました。
 
# 実行
    cd log_training
    sh execute.sh

# サンプルシェルの実行
    cd log_training
    sh sample.sh


