#!/bin/sh
set -eu

while true; do
	php /var/www/html/lib/pkp/tools/scheduler.php run || true
	sleep 60
done
