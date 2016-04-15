#!/bin/bash
# Script para monitoramento do disco

# Escreve o cabecalho de identificacao dos dados
echo "read(MB/s) write(MB/s) Queue_Length Utilization date time elapsed_time" > monitoramento-iostat.txt

echo "read(MB/s) write(MB/s) Queue_Length Utilization date time elapsed_time"

count=0;
while [ True ]
do

   # Obtem os campos de interesse ( read(kB/s),write(kB/s), e cancelled(kB/s) )
   disk=`iostat -m -x -d sda 5 1 | sed -n '4p' | awk '{print $6,$7,$9,$12}'`

   # Obtem o tempo atual, no formato RFC3339: AAAA-MM-DD HH:MM:SS 
   tempo=`date --rfc-3339=seconds`

   # Separa data e hora do tempo obtido
   data=`echo $tempo | cut -d\  -f1`
   hora=`echo $tempo | cut -d\  -f2| awk 'BEGIN{FS="-"}{print $1}'`

   # Mostre na tela as informacoes capturadas pelo script
   echo $disk $data $hora $count

   # Escreve no arquivo as informacoes capturadas
   echo $disk $data $hora $count >> monitoramento-iostat.txt

   # Incrementa o contador de tempo
   count=`expr $count + 5`
done
