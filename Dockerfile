FROM ghcr.io/pterodactyl/panel:latest

# Copier le script avec conversion des fins de ligne
COPY entrypoint.sh /entrypoint.sh
RUN apk add --no-cache bash && \
    sed -i 's/\r$//' /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
