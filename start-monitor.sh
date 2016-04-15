#!/bin/bash
# Executa todos os processos de monitoramento
nohup ./monitor-cpu.sh>/dev/null&
nohup ./monitor-memoria.sh>/dev/null&
nohup ./monitor-iostat.sh>/dev/null&
nohup ./monitor-bandwidth.sh>/dev/null&
