#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs

python3 - <<'PY'
from pathlib import Path

data = {}
for line in Path(".env").read_text().splitlines():
    if "=" in line:
        key, value = line.split("=", 1)
        data[key] = value

required = ["OJS_DB_PASSWORD", "MYSQL_ROOT_PASSWORD", "OJS_SALT", "OJS_API_KEY_SECRET"]
for key in required:
    if len(data.get(key, "")) < 64:
        raise SystemExit(f"{key} is missing or too short")

if not data.get("OJS_APP_KEY", "").startswith("base64:"):
    raise SystemExit("OJS_APP_KEY is missing or invalid")

print("env_ok")
PY

ls -l .env config/config.inc.php
grep -E '^(installed|app_key|base_url|allowed_hosts|host|username|name|files_dir|force_ssl|force_login_ssl|require_validation|task_runner)' config/config.inc.php | sed -E 's/(app_key = ).*/\\1*** masked ***/'
