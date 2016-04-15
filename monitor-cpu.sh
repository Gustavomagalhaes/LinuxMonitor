#!/bin/bash

# Script para monitoramento da utilização da CPU

# Escreve o cabeçalho de identificação dos dados
echo "%usr %sys %iowait %idle date time elapsed_time" >> log/log-cpu.txt
echo "%usr %sys %iowait %idle date time elapsed_time"
count=0;
while [ True ]
do
   
   # Armazena somente os campos de interesse
   cpu=`mpstat 5 1| grep all | head -n1 | awk '{print $4,$6,$7,$13}'`

   # Obtem o tempo atual, no formato RFC3339: AAAA-MM-DD HH:MM:SS 
   # O tempo corresponde ao retorno do mpstat, 
   # portanto  o uso de cpu eh a media do ultimo minuto
   tempo=`date --rfc-3339=seconds`
   
   
   # Separa data e hora do tempo obtido
   data=`echo $tempo | cut -d\  -f1`
   hora=`echo $tempo | cut -d\  -f2| awk 'BEGIN{FS="-"}{print $1}'`
   
   
   # Mostre na tela as informações capturadas pelos script
   echo $cpu $data $hora $count

   # Escreve no arquivo as informações do disco
   echo $cpu $data $hora $count>> log/log-cpu.txt

   #Executa o script a cada X unidade de tempo
   #Comentado porque o mpstat ja espera os 60 segundos 
   #sleep 60
   count=`expr $count + 5`

done


