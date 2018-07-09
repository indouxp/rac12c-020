#!/bin/sh
###############################################################################
#
# kvm上のvmから、外に行けない。yumの実行で止まってしまう。
# http://aaabbb-200904.hatenablog.jp/entry/20090505/1241514183
#
###############################################################################
NAME=${0##*/}
LOG=./${NAME:?}.log

set -eu

main() {

  sudo systemctl status iptables

  sudo iptables -L

  sudo iptables -I FORWARD -i br0 -j ACCEPT
  sudo iptables -I FORWARD -o br0 -j ACCEPT

  sudo systemctl restart iptables

  sudo iptables -L

}

main > ${LOG:?} 2>&1
exit 0
