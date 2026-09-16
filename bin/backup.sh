#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs
set -a
source ./.env
set +a

stamp="$(date -u +%Y%m%dT%H%M%SZ)"
target="/opt/ojs/backups/${stamp}"
mkdir -p "${target}"

docker compose exec -T db mysqldump \
	-uroot \
	-p"${MYSQL_ROOT_PASSWORD}" \
	--single-transaction \
	--routines \
	--triggers \
	"${OJS_DB_NAME}" | gzip -9 > "${target}/db.sql.gz"

tar -C /opt/ojs -czf "${target}/ojs-files-public-config.tar.gz" ojs-files public config

find /opt/ojs/backups -mindepth 1 -maxdepth 1 -type d -mtime +21 -exec rm -rf {} +
