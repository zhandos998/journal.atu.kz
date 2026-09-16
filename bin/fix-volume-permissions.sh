#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs

docker run --rm \
	-v /opt/ojs:/host \
	local/ojs-atu:3.5.0.5 \
	sh -c '
		chown -R 33:1000 /host/cache /host/ojs-files /host/public
		chmod 775 /host/cache /host/ojs-files /host/public
		find /host/cache /host/ojs-files /host/public -type d -exec chmod 775 {} +
		find /host/cache /host/ojs-files /host/public -type f -exec chmod 664 {} +
		chown 33:1000 /host/config/config.inc.php
		chmod 640 /host/config/config.inc.php
	'
