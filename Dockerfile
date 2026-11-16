# SearXNG for Railway: the official image, pinned by version and digest,
# plus a small start script that enables JSON output on first boot.
FROM ghcr.io/searxng/searxng:2026.11.15-2d500cb6b@sha256:932f69dca010db9880bddebb2171f05d8e1a25d04a59149ff65409993d680024

COPY railway-start.sh /usr/local/searxng/railway-start.sh
RUN chmod 0755 /usr/local/searxng/railway-start.sh

ENTRYPOINT ["/usr/local/searxng/railway-start.sh"]
