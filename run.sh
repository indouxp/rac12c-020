#!/bin/sh
###############################################################################
#
# t3600からc7-1にRACインストール
#
###############################################################################
export ANSIBLE_NOCOWS=1

TERM() {
  # ssh-agent の停止
  eval `ssh-agent -k`
}

# u:未設定の変数使用はエラーとする
# v:シェルの入力行を表示する
set -uv
# e:パイプやサブシェルで実行したコマンドが1つでもエラーになったら直ちにシェルを終了する
set -e

# ssh-agent の起動(公開鍵による認証の準備)
eval `ssh-agent`
trap 'TERM' 0 1 2 3 15 

set +e
ssh-add -l
set -e
# 秘密鍵を登録
ssh-add ~/.ssh/id_rsa
# 登録済みの鍵をリスト
ssh-add -l

# ansible.cfgに従い、ansible-playbook実行
ansible-playbook -i hosts --ask-become-pass site.yml 

# 登録済みのカギをすべて削除
ssh-add -d ~/.ssh/id_rsa


exit 0
