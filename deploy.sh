#!/bin/bash
set -e
cd "$1"
# Update kodu
git pull origin main
# Restart kontenera, aby poszła aktualizacja
docker container restart symfony_rss_apache