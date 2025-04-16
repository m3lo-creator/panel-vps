FROM ghcr.io/pterodactyl/panel:latest

# Installation des dépendances nécessaires
RUN apk add --no-cache bash curl

# Copie et configuration du script d'entrée
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    sed -i 's/\r$//' /entrypoint.sh  # Conversion des fins de ligne

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
