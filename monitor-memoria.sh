#!/bin/bash
# Script para monitoramento da utilização da RAM

# Escreve o cabeçalho de identificação dos dados
echo "#Mem_used Mem_free Mem_buffers Mem_cached Swap_used Swap_free Date Time Elapsed_time" >> log/log-memoria.txt

echo "#Mem_used Mem_free Mem_buffers Mem_cached Swap_used Swap_free Date Time Elapsed_time"

count=0;
while [ True ]
do
   
   # Obtem o tempo atual, no formato RFC3339: AAAA-MM-DD HH:MM:SS 
   tempo=`date --rfc-3339=seconds`
   memory=`free | grep Mem:`   
   swap=`free | grep Swap:`

   # Armazena somente os campos de interesse: Free, Used, Buffers, Cached, ...
   memfree=`echo $memory | awk '{print $4}'`
   memused=`echo $memory | awk '{print $3}'`
   membuff=`echo $memory | awk '{print $6}'`
   memcache=`echo $memory | awk '{print $7}'`
   
   swapfree=`echo $swap | awk '{print $4}'`
   swapused=`echo $swap | awk '{print $3}'`

   # Separa data e hora do tempo obtido
   data=`echo $tempo | cut -d\  -f1`
   hora=`echo $tempo | cut -d\  -f2| awk 'BEGIN{FS="-"}{print $1}'`
   
   # Mostre na tela as informações capturadas pelos script
   echo $memused  $memfree   $membuff  $memcache   $swapused  $swapfree $data $hora $count

   # Escreve no arquivo as informações da RAM
   echo $memused $memfree $membuff $memcache $swapused $swapfree $data $hora $count >> log/log-memoria.txt

   count=`expr $count + 5`
   # Executa o script a cada X unidade de tempo 
   sleep 5

done
