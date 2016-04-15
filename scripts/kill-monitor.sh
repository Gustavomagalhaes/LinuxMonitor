#!/bin/bash
lista=`ps aux | grep monitoramento | awk '{print $2}'`
for i in $lista
do
 kill -9 $i
done
