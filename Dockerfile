FROM ghcr.io/pterodactyl/panel:latest

# Copier le script d'entrée
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# S'assurer que les dépendances sont installées
RUN apt-get update && apt-get install -y netcat

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
