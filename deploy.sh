#!/bin/bash
set -e
cd "$1"
# Update kodu
git pull origin main
# Restart kontenera, aby poszła aktualizacja
docker container stop symfony_rss_apache
docker container start symfony_rss_apache