#!/usr/bin/env bash
set -euo pipefail

cd /opt/ojs

quarantine_dir="/opt/ojs/quarantine/upload-executables-$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$quarantine_dir"

found=0

while IFS= read -r -d '' file; do
	found=1
	rel="${file#/opt/ojs/}"
	target="$quarantine_dir/$rel"
	mkdir -p "$(dirname "$target")"
	mv "$file" "$target"
	printf 'QUARANTINED %s -> %s\n' "$file" "$target"
done < <(find /opt/ojs/ojs-files /opt/ojs/public -type f \( \
	-iname '*.php' -o -iname '*.phtml' -o -iname '*.phar' -o \
	-iname '*.cgi' -o -iname '*.pl' -o -iname '*.py' -o -iname '*.sh' \
	\) -print0)

if [ "$found" -eq 0 ]; then
	rmdir "$quarantine_dir"
	echo "NO_UPLOAD_EXECUTABLES_FOUND"
else
	echo "QUARANTINE_DIR=$quarantine_dir"
fi
