#!/bin/bash

# Attendre que la base de données soit prête
until nc -z database 3306; do
  echo "En attente de la base de données..."
  sleep 1
done

# Exécuter les migrations et seeds si c'est le premier démarrage
if [ ! -f /app/var/INSTALLED ]; then
  php artisan migrate --force
  php artisan db:seed --force
  touch /app/var/INSTALLED
  
  # Créer l'utilisateur admin
  php artisan p:user:make \
    --email=lamelo2410@gmail.com \
    --username=toge \
    --name-first=melo \
    --name-last=night \
    --password=melo12345@ \
    --admin=1
fi

# Démarrer le serveur web
exec apache2-foreground
