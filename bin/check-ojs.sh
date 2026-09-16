#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs

printf 'COMPOSE_PS\n'
docker compose ps

printf 'APP_WITH_HOST_HEADER\n'
docker compose exec -T ojs curl -i -s --max-time 10 \
	-H "Host: journal.atu.kz" \
	-H "X-Forwarded-Proto: https" \
	http://127.0.0.1/index.php/index/index | sed -n '1,80p' || true

printf 'APP_LOGS\n'
docker compose logs --tail=160 ojs || true

printf 'SCHEDULER_LOGS\n'
docker compose logs --tail=80 ojs-scheduler || true

printf 'CADDY_RECENT_ERRORS\n'
docker compose logs --tail=120 caddy | grep -Ei 'error|challenge|certificate|refused|failed' || true
