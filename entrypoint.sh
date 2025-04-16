#!/bin/bash
set -e

# Fonction alternative pour vérifier la base de données (sans netcat)
wait_for_db() {
  echo "Waiting for database to be ready..."
  until php -r "try { new PDO('mysql:host=database;dbname=panel', 'pterodactyl', '${DB_PASSWORD}', [PDO::ATTR_TIMEOUT => 5]); exit(0); } catch (PDOException \$e) { exit(1); }" &>/dev/null
  do
    sleep 1
  done
}

wait_for_db

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
