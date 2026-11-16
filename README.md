[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/searxng-3?utm_medium=integration&utm_source=button&utm_campaign=searxng)

# SearXNG on Railway

A Railway template for [SearXNG](https://github.com/searxng/searxng), the privacy-respecting metasearch engine. It runs the official image, pinned by version and digest, with a small start script for Railway.

**Version:** SearXNG `2026.11.15-2d500cb6b` (`ghcr.io/searxng/searxng@sha256:932f69dca010db9880bddebb2171f05d8e1a25d04a59149ff65409993d680024`).

## What it deploys

One service, `SearXNG`, built from this repo's `Dockerfile`:

- a public Railway domain, health check `/healthz`;
- a volume at `/etc/searxng` that keeps `settings.yml`;
- on first boot, `railway-start.sh` writes a minimal `settings.yml` (`use_default_settings: true`, image proxy on, `html` and `json` output formats). It never overwrites an existing file, so your own edits survive redeploys and updates.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `SEARXNG_SECRET` | `${{secret(64,"abcdef0123456789")}}` | Secret key for SearXNG, generated at deploy time |
| `SEARXNG_BASE_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}/` | Public URL, used in links and the OpenSearch description |
| `SEARXNG_CONTACT_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}/` | Contact address SearXNG sends to Wikipedia, Wikidata and OpenStreetMap, which those engines now require. Replace it with your own contact page or a `mailto:` address |
| `SEARXNG_LIMITER` | `false` | Bot limiter. It needs a Valkey or Redis server (`SEARXNG_VALKEY_URL`); turn it on for a public instance |
| `PORT` | `8080` | Port the app listens on and Railway's health check probes |

## Using it

- Web search: open the Railway domain.
- JSON API: `https://YOUR-DOMAIN/search?q=railway&format=json`.
- Change engines or other settings: edit `/etc/searxng/settings.yml` on the volume (for example with `railway ssh`), then restart the service. See the [settings reference](https://docs.searxng.org/admin/settings/index.html).

## Updates

SearXNG ships rolling releases. When this repo's `main` moves to a newer pin, Railway shows deployers an "update available" notice, and each deployer chooses when to apply it. `CHANGELOG.md` lists every version, breaking changes first. Your `settings.yml` stays as it is on the volume.

This is a community template and isn't affiliated with or endorsed by the SearXNG project.
