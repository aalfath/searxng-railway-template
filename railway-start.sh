#!/bin/sh
# Writes a minimal settings.yml on first boot only (the volume at /etc/searxng
# keeps it, so later edits by the deployer are never overwritten), then hands
# over to the upstream entrypoint.
set -eu

conf_dir="${__SEARXNG_CONFIG_PATH:-/etc/searxng}"
settings="$conf_dir/settings.yml"

# Railway injects PORT; the upstream image listens on GRANIAN_PORT (8080).
if [ -n "${PORT:-}" ]; then
    export GRANIAN_PORT="$PORT"
fi

# A Railway service named "searxng" could leak a non-numeric SEARXNG_PORT.
case "${SEARXNG_PORT:-}" in
    *[!0-9]*) unset SEARXNG_PORT ;;
esac

mkdir -p "$conf_dir"
if [ ! -f "$settings" ]; then
    echo "railway-start: creating $settings (JSON output enabled)"
    cat > "$settings" <<'YAML'
# Created by the Railway template on first boot. Edit freely: it is kept on
# the volume and never overwritten. Full reference:
# https://docs.searxng.org/admin/settings/index.html
use_default_settings: true

server:
  # The secret key comes from the SEARXNG_SECRET variable.
  image_proxy: true

search:
  formats:
    - html
    - json
YAML
fi

exec /usr/local/searxng/entrypoint.sh "$@"
