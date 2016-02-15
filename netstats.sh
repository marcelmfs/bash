#!/usr/bin/env bash
if [ -z "$1" ]; then
        echo
        echo usage: $0 [network-interface]
        echo
        echo e.g. $0 eth0
        echo
        exit
fi

INTERVAL=1

while true;
do
  PR1=`cat /sys/class/net/$1/statistics/rx_packets`
  PT1=`cat /sys/class/net/$1/statistics/tx_packets`
  BR1=`cat /sys/class/net/$1/statistics/rx_bytes`
  BT1=`cat /sys/class/net/$1/statistics/tx_bytes`
  sleep $INTERVAL
  PR2=`cat /sys/class/net/$1/statistics/rx_packets`
  PT2=`cat /sys/class/net/$1/statistics/tx_packets`
  BR2=`cat /sys/class/net/$1/statistics/rx_bytes`
  BT2=`cat /sys/class/net/$1/statistics/tx_bytes`
  TXPPS=`expr $PT2 - $PT1`
  RXPPS=`expr $PR2 - $PR1`
  TBPS=`expr $BT2 - $BT1`
  RBPS=`expr $BR2 - $BR1`
  TKBPS=`expr $TBPS / 1024`
  RKBPS=`expr $RBPS / 1024`
  echo "TX $1: $TKBPS kB/s ($TXPPS pkts/s) RX $1: $RKBPS kB/s ($RXPPS pkts/s)"
done