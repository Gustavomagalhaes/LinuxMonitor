#!/bin/bash
# Script para monitoramento da banda da rede

#    /sys/class/net/eth0/statistics/rx_packets: number of packets received
#    /sys/class/net/eth0/statistics/tx_packets: number of packets transmitted
#    /sys/class/net/eth0/statistics/rx_bytes: number of bytes received
#    /sys/class/net/eth0/statistics/tx_bytes: number of bytes transmitted
#    /sys/class/net/eth0/statistics/rx_dropped: number of packets dropped while received
#    /sys/class/net/eth0/statistics/tx_dropped: number of packets dropped while transmitted 

# Escreve o cabeçalho de identificação dos dados
echo "Transmitted kB/s Received kB/s Date Time Seconds" >> log/log-bandwidth.txt

interface="eth0";
count=0;
while [ True ]
do
   # Obtem a banda usando sysfs sem a necessidade de libcap
        R1=`cat /sys/class/net/$interface/statistics/rx_bytes`
        T1=`cat /sys/class/net/$interface/statistics/tx_bytes`
        sleep 5
        R2=`cat /sys/class/net/$interface/statistics/rx_bytes`
        T2=`cat /sys/class/net/$interface/statistics/tx_bytes`
        TBPS=`expr $T2 - $T1`
        RBPS=`expr $R2 - $R1`
        TKBPS=`expr $TBPS / 1024`
        RKBPS=`expr $RBPS / 1024`
        #banda=`echo TX $interface: $TKBPS kB/s RX $interface: $RKBPS kB/s`
        banda=`echo $TKBPS kB/s $RKBPS kB/s`

   # Obtem o tempo atual, no formato RFC3339: AAAA-MM-DD HH:MM:SS 
   tempo=`date --rfc-3339=seconds`
   
   # Separa data e hora do tempo obtido
   data=`echo $tempo | cut -d\  -f1`
   hora=`echo $tempo | cut -d\  -f2| awk 'BEGIN{FS="-"}{print $1}'`
   
   # Mostre na tela as informações capturadas pelos script
   echo $banda $data $hora $count

   # Escreve no arquivo as informações 
   echo $banda $data $hora $count >> log/log-bandwidth.txt
   count=`expr $count + 5`
   # Executa o script a cada X unidade de tempo 
   sleep 5

done
