#!/bin/bash
set -e
cd "$1"
# Update kodu
git pull origin main
# Instalacje backend
composer install --no-interaction --prefer-dist --optimize-autoloader
# Migruj bazę 
php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration
# Frontend build
npm install
npm run build