#!/bin/bash
set -e
cd "$1"
# Update kodu
git pull origin main
# Instalacje backend
docker exec symfony_rss_apache bash -c "composer install --no-interaction --prefer-dist --optimize-autoloader"
# Migruj bazę 
docker exec symfony_rss_apache bash -c "php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration"
# Frontend build 
docker exec symfony_rss_apache bash -c "npm install"
docker exec symfony_rss_apache bash -c "npm run build"