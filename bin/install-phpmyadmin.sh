#!/usr/bin/env bash
set -euo pipefail

cd /opt/ojs

auth_txt="/opt/ojs/phpmyadmin-basic-auth.txt"
htpasswd_tmp="/tmp/.htpasswd-journal-phpmyadmin"
nginx_tmp="/tmp/nginx-journal.atu.kz.conf"

if [ -f "$auth_txt" ]; then
	pma_pass="$(awk -F': ' '/Basic Auth password:/{print $2}' "$auth_txt")"
else
	pma_pass="$(openssl rand -base64 48 | tr -dc 'A-Za-z0-9' | head -c 28)"
	{
		echo 'URL: https://journal.atu.kz/phpmyadmin/'
		echo 'Basic Auth user: ojsadmin'
		echo "Basic Auth password: ${pma_pass}"
		echo 'MySQL server: db'
		echo 'MySQL user: ojs'
		echo 'MySQL password: see /opt/ojs/.env OJS_DB_PASSWORD'
	} > "$auth_txt"
	chmod 600 "$auth_txt"
fi

if [ -z "${pma_pass:-}" ]; then
	echo "missing_phpmyadmin_password" >&2
	exit 1
fi

pma_hash="$(openssl passwd -apr1 "$pma_pass")"
printf 'ojsadmin:%s\n' "$pma_hash" > "$htpasswd_tmp"
chmod 600 "$htpasswd_tmp"

docker run --rm \
	-v /:/host \
	-v "${nginx_tmp}:${nginx_tmp}:ro" \
	-v "${htpasswd_tmp}:${htpasswd_tmp}:ro" \
	alpine:3.20 \
	sh -c "cp ${nginx_tmp} /host/etc/nginx/sites-available/journal.atu.kz && cp ${htpasswd_tmp} /host/etc/nginx/.htpasswd-journal-phpmyadmin && chmod 644 /host/etc/nginx/.htpasswd-journal-phpmyadmin"

docker compose config >/dev/null
docker compose up -d phpmyadmin
docker compose ps

echo "PHPMYADMIN_READY"
echo "Credentials stored at ${auth_txt}"
