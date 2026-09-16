#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs
umask 077

python3 - <<'PY' > .env
import base64
import secrets

values = {
    "OJS_DB_NAME": "ojs",
    "OJS_DB_USER": "ojs",
    "OJS_APP_KEY": "base64:" + base64.b64encode(secrets.token_bytes(32)).decode(),
    "OJS_DB_PASSWORD": secrets.token_hex(32),
    "MYSQL_ROOT_PASSWORD": secrets.token_hex(32),
    "OJS_SALT": secrets.token_hex(32),
    "OJS_API_KEY_SECRET": secrets.token_hex(32),
}

for key, value in values.items():
    print(f"{key}={value}")
PY

chmod 600 .env
