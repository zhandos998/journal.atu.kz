#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs

docker compose ps
docker compose logs --tail=80 ojs 2>/dev/null || true
docker compose logs --tail=80 caddy 2>/dev/null || true
docker compose logs --tail=80 ojs-scheduler 2>/dev/null || true

printf 'LOCAL_HTTP\n'
curl -I --max-time 10 http://127.0.0.1 2>/dev/null || true

printf 'CONTAINER_HTTP\n'
docker compose exec -T ojs curl -I --max-time 10 http://127.0.0.1/index.php/index/index 2>/dev/null || true
