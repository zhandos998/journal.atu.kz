#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs
set -a
source ./.env
set +a

docker compose up -d db

for i in {1..60}; do
	if docker compose exec -T db mysqladmin ping -h 127.0.0.1 -uroot -p"${MYSQL_ROOT_PASSWORD}" --silent >/dev/null 2>&1; then
		break
	fi
	sleep 2
	if [ "$i" = 60 ]; then
		echo "db_not_ready" >&2
		exit 1
	fi
done

table_count="$(docker compose exec -T db mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -N -B -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${OJS_DB_NAME}'")"

if [ "${table_count}" != "0" ]; then
	echo "db_has_tables_${table_count}_skip_import"
	exit 0
fi

docker compose exec -T db mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" "${OJS_DB_NAME}" < /opt/ojs/import/ojs_atu_kz.sql

new_count="$(docker compose exec -T db mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -N -B -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${OJS_DB_NAME}'")"
echo "db_imported_tables_${new_count}"
