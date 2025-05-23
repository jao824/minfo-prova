#!/bin/bash

# minfo.sh - Exibe informações do sistema baseadas em um argumento
# Uso: ./minfo.sh {hostname|uptime|disk|all}

if [ "$#" -ne 1 ]; then
    echo "Uso: ./minfo.sh {hostname|uptime|disk|all}"
    exit 1
fi

# Função para mostrar uptime compatível com Git Bash
mostrar_uptime() {
    powershell.exe -Command "(Get-CimInstance Win32_OperatingSystem).LastBootUpTime" 2>/dev/null | \
    sed 's/\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\).*/\1-\2-\3 \4:\5:\6/' || \
    echo "Comando de uptime não disponível neste ambiente"
}


case $1 in
    hostname)
        hostname
        ;;
    uptime)
        mostrar_uptime
        ;;
    disk)
        df -h /
        ;;
    all)
        echo "Hostname: $(hostname)"
        echo -n "Uptime: "; mostrar_uptime
        echo "Disk usage:"
        df -h /
        ;;
    *)
        echo "Uso: ./minfo.sh {hostname|uptime|disk|all}"
        exit 1
        ;;
esac
