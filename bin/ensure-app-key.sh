#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs
umask 077

python3 - <<'PY'
from pathlib import Path
import base64
import secrets

path = Path(".env")
lines = path.read_text().splitlines()

has_key = any(line.startswith("OJS_APP_KEY=") and len(line.split("=", 1)[1]) > 10 for line in lines)
if not has_key:
    app_key = "base64:" + base64.b64encode(secrets.token_bytes(32)).decode()
    lines.insert(2, f"OJS_APP_KEY={app_key}")
    path.write_text("\n".join(lines) + "\n")

path.chmod(0o600)
PY
