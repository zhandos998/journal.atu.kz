#!/usr/bin/env bash
set -euo pipefail

cd /opt/ojs

echo "DATE_UTC"
date -u

echo
echo "OJS_VERSION_CHECK"
docker compose exec -T -u www-data ojs php tools/upgrade.php check

echo
echo "CONTAINERS"
docker compose ps

echo
echo "SCHEDULER_USER"
docker inspect --format '{{.Config.User}}' "$(docker compose ps -q ojs-scheduler)"

echo
echo "INTERNAL_APP_HTTP"
docker compose exec -T ojs sh -lc '
	curl -fsSI \
		-H "Host: journal.atu.kz" \
		-H "X-Forwarded-Proto: https" \
		http://127.0.0.1/index.php/index/index \
		| sed -n "1,10p"
'

echo
echo "SENSITIVE_PATH_STATUS"
docker compose exec -T ojs sh -lc '
	for path in /config.inc.php /dbscripts/xml/version.xml /tools/upgrade.php /cache/does-not-exist; do
		code=$(curl -sS -o /dev/null -w "%{http_code}" \
			-H "Host: journal.atu.kz" \
			-H "X-Forwarded-Proto: https" \
			"http://127.0.0.1${path}" || true)
		printf "%s %s\n" "$code" "$path"
	done
'

echo
echo "UPLOAD_EXECUTABLE_FILES"
if find /opt/ojs/ojs-files /opt/ojs/public -type f \( \
	-iname '*.php' -o -iname '*.phtml' -o -iname '*.phar' -o \
	-iname '*.cgi' -o -iname '*.pl' -o -iname '*.py' -o -iname '*.sh' \
	\) -print -quit | grep -q .; then
	find /opt/ojs/ojs-files /opt/ojs/public -type f \( \
		-iname '*.php' -o -iname '*.phtml' -o -iname '*.phar' -o \
		-iname '*.cgi' -o -iname '*.pl' -o -iname '*.py' -o -iname '*.sh' \
		\) -print | head -100
else
	echo "none"
fi

echo
echo "UPLOAD_SUSPICIOUS_PATTERNS"
if grep -RInE 'eval\s*\(|base64_decode\s*\(|shell_exec\s*\(|passthru\s*\(|system\s*\(|proc_open\s*\(|popen\s*\(|assert\s*\(|gzinflate\s*\(|str_rot13\s*\(|FilesMan|c99|r57|WSO|b374k' /opt/ojs/public /opt/ojs/ojs-files 2>/dev/null | head -50 | grep -q .; then
	grep -RInE 'eval\s*\(|base64_decode\s*\(|shell_exec\s*\(|passthru\s*\(|system\s*\(|proc_open\s*\(|popen\s*\(|assert\s*\(|gzinflate\s*\(|str_rot13\s*\(|FilesMan|c99|r57|WSO|b374k' /opt/ojs/public /opt/ojs/ojs-files 2>/dev/null | head -50
else
	echo "none"
fi

echo
echo "TOP_LEVEL_PERMISSIONS"
ls -ld /opt/ojs /opt/ojs/config /opt/ojs/config/config.inc.php /opt/ojs/ojs-files /opt/ojs/public /opt/ojs/cache /opt/ojs/cache/opcache 2>/dev/null || true

echo
echo "HOST_LISTENING_PORTS"
ss -tulpn 2>/dev/null | grep -E ':(22|80|443|3306)\b' || true

echo
echo "SSH_HARDENING"
sed -n '1,80p' /etc/ssh/sshd_config.d/99-ojs-hardening.conf 2>/dev/null || true

echo
echo "RECENT_APP_WARNINGS"
docker compose logs --since=90s ojs 2>/dev/null | grep -E 'PHP Warning|PHP Fatal|error|Error' | tail -80 || true

echo
echo "RECENT_CADDY_CERT"
docker compose logs --since=10m caddy 2>/dev/null | grep -E 'challenge failed|Connection refused|obtaining certificate|will retry|certificate obtained|done waiting' | tail -80 || true
