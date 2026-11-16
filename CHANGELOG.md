# Changelog

Each entry is one version of this Railway template. Breaking changes come first.

## 2026.11.15-2d500cb6b (2026-11-16)

- First repo-based release of the SearXNG template (`searxng-3`), replacing the image-only version.
- SearXNG `2026.11.15-2d500cb6b`, pinned by digest `sha256:932f69dca010db9880bddebb2171f05d8e1a25d04a59149ff65409993d680024`.
- On first boot, writes `/etc/searxng/settings.yml` with `use_default_settings: true` and the `html` and `json` output formats, so `/search?format=json` works. An existing `settings.yml` on the volume is left untouched.
- Listens on Railway's `PORT`; health check `/healthz`.
- New variables `SEARXNG_BASE_URL` and `SEARXNG_CONTACT_URL` (both default to the Railway domain). Without a contact URL, current SearXNG skips the Wikipedia, Wikidata and OpenStreetMap engines.
