#!/bin/bash
set -e
cd "$1"
# Update kodu
git pull origin main
# Restart kontenera, aby poszła aktualizacja
docker container stop "$2"
docker container start "$2"

URL="https://$3"
TIMEOUT_MIN=10
SLEEP_SEC=5
end=$((SECONDS+TIMEOUT_MIN*60))
while [ $SECONDS -lt $end ]; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    if [ "$status" -eq 200 ]; then
        echo "Serwer odpowiada 200 OK."
        exit 0
    else
        echo "$(date): Serwer jeszcze nie odpowiada 200, status: $status"
    fi
    sleep $SLEEP_SEC
done
echo "Przekroczono czas oczekiwania ($TIMEOUT_MIN min): Serwer nie odpowiada 200."
exit 1