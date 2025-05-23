#!/bin/bash
set -e
cd "$1"
# Update kodu
git pull origin main
# Ustaw zmienne środowiskowe — najlepiej NIE commituj .env, tylko .env.example!
echo "DATABASE_URL=$DATABASE_URL" > .env.local
echo "APP_SECRET=$APP_SECRET" >> .env.local
# itd.
# Instalacje backend
composer install --no-interaction --prefer-dist --optimize-autoloader
# Migruj bazę
php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration
# Frontend build
npm install
npm run build