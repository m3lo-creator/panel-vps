#!/bin/bash
set -e

# Fonction de vérification de la base de données
wait_for_db() {
    echo "Vérification de la base de données..."
    while ! php -r "try {
        new PDO('mysql:host=database;dbname=panel', 'pterodactyl', '${DB_PASSWORD}', [PDO::ATTR_TIMEOUT => 5]);
        exit(0);
    } catch (PDOException \$e) {
        exit(1);
    }" &> /dev/null
    do
        sleep 1
    done
}

# Exécution des étapes
wait_for_db

if [ ! -f /app/var/INSTALLED ]; then
    echo "Installation initiale en cours..."
    php artisan migrate --force
    php artisan db:seed --force
    touch /app/var/INSTALLED
    
    echo "Création de l'administrateur..."
    php artisan p:user:make \
        --email=lamelo2410@gmail.com \
        --username=toge \
        --name-first=melo \
        --name-last=night \
        --password=melo12345@ \
        --admin=1
fi

echo "Démarrage du serveur web..."
exec apache2-foreground
