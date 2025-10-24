#!/bin/bash
#/usr/local/bin/
set -euo pipefail
LOGFILE="/var/log/monitoring.log"
PROCESS_NAME="test"

# URL="http://158.160.70.229:9090" # у меня запущен прометеус на сервере
URL="https://test.com/monitoring/test/api"  # использовать для задания 
LAST_START_FILE="/var/run/process_last_start"
current_start=$(systemctl show -p ExecMainStartTimestampMonotonic $PROCESS_NAME | cut -d'=' -f2)

if systemctl is-active --quiet $PROCESS_NAME; then
    if [ -f "$LAST_START_FILE" ]; then
        previous_start=$(cat "$LAST_START_FILE")
    else
        previous_start=0
    fi

    if [ "$current_start" != "$previous_start" ]; then
        echo "$(date): Процесс $PROCESS_NAME был перезапущен" >> $LOGFILE
        echo "$current_start" > "$LAST_START_FILE"
    fi

    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -L -I "$URL")
    if [[ "$HTTP_CODE" == "200"  ]]; then
        echo "$(date): Сервис мониторинга на $URL доступен, HTTP код: $HTTP_CODE" >> $LOGFILE
    else
        echo "$(date): Сервис мониторинга на $URL недоступен, HTTP код: $HTTP_CODE" >> $LOGFILE
    fi

fi