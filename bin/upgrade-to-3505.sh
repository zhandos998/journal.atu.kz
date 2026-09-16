#!/usr/bin/env bash
set -euo pipefail

cd /opt/ojs

test -f /opt/ojs/import/ojs-3.5.0-5.tar.gz

if [ ! -f /opt/ojs/src-3.5.0.5/index.php ]; then
	rm -rf /opt/ojs/src-3.5.0.5
	mkdir -p /opt/ojs/src-3.5.0.5
	tar -xzf /opt/ojs/import/ojs-3.5.0-5.tar.gz -C /opt/ojs/src-3.5.0.5 --strip-components=1
fi

test -f /opt/ojs/src-3.5.0.5/index.php

# Keep local Russian invitation translation if it was added manually and the release does not include it.
if [ -f /opt/ojs/src/lib/pkp/locale/ru/invitation.po ] && [ ! -f /opt/ojs/src-3.5.0.5/lib/pkp/locale/ru/invitation.po ]; then
	cp /opt/ojs/src/lib/pkp/locale/ru/invitation.po /opt/ojs/src-3.5.0.5/lib/pkp/locale/ru/invitation.po
fi

if [ -f /opt/ojs/src/locale/ru/invitation.po ] && [ ! -f /opt/ojs/src-3.5.0.5/locale/ru/invitation.po ]; then
	cp /opt/ojs/src/locale/ru/invitation.po /opt/ojs/src-3.5.0.5/locale/ru/invitation.po
fi

if [ -d /opt/ojs/src-3.5.0.5/plugins ]; then
	backup_dir="/opt/ojs/src-3.5.0.4-backup-$(date -u +%Y%m%dT%H%M%SZ)"
	mv /opt/ojs/src "$backup_dir"
	mv /opt/ojs/src-3.5.0.5 /opt/ojs/src
	printf 'SOURCE_SWITCHED_TO_3.5.0.5\nOLD_SOURCE=%s\n' "$backup_dir"
else
	echo "Extracted source does not look like OJS" >&2
	exit 1
fi
