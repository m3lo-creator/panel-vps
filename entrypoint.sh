#!/bin/bash
set -e

echo "Waiting for database to be ready..."
while ! nc -z database 3306; do
  sleep 1
done

# Vérifier si c'est le premier démarrage
if [ ! -f /app/var/INSTALLED ]; then
  echo "Running initial setup..."
  php artisan migrate --force
  php artisan db:seed --force
  touch /app/var/INSTALLED
  
  echo "Creating admin user..."
  php artisan p:user:make \
    --email=lamelo2410@gmail.com \
    --username=toge \
    --name-first=melo \
    --name-last=night \
    --password=melo12345@ \
    --admin=1
fi

echo "Starting web server..."
exec apache2-foreground
