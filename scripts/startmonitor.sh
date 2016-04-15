#!/bin/bash
# Executa todos os processos de monitoramento
nohup ./monitoramento-cpu.sh>/dev/null&
nohup ./monitoramento-memoria.sh>/dev/null&
nohup ./monitoramento-iostat.sh>/dev/null&
nohup ./monitoramento-bandwidth.sh>/dev/null&
