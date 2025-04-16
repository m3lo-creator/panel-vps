FROM ghcr.io/pterodactyl/panel:latest

# Copier le script d'entrée modifié (sans dépendance à netcat)
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
