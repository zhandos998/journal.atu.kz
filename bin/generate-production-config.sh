#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/ojs
set -a
source ./.env
set +a

template="/opt/ojs/src/config.TEMPLATE.inc.php"
target="/opt/ojs/config/config.inc.php"

cp "${template}" "${target}"

python3 - <<'PY'
from pathlib import Path
import os
import re

path = Path("/opt/ojs/config/config.inc.php")
text = path.read_text(encoding="utf-8")

salt = os.environ["OJS_SALT"]
app_key = os.environ["OJS_APP_KEY"]
api_secret = os.environ["OJS_API_KEY_SECRET"]
db_name = os.environ["OJS_DB_NAME"]
db_user = os.environ["OJS_DB_USER"]
db_pass = os.environ["OJS_DB_PASSWORD"]

replacements = {
    r'^installed\s*=.*$': 'installed = On',
    r'^app_key\s*=.*$': f'app_key = "{app_key}"',
    r'^base_url\s*=.*$': 'base_url = "https://journal.atu.kz"',
    r"^allowed_hosts\s*=.*$": "allowed_hosts = '[\"journal.atu.kz\"]'",
    r'^host\s*=.*$': 'host = db',
    r'^username\s*=.*$': f'username = {db_user}',
    r'^password\s*=.*$': f'password = "{db_pass}"',
    r'^name\s*=.*$': f'name = {db_name}',
    r'^files_dir\s*=.*$': 'files_dir = "/var/www/files"',
    r'^public_files_dir\s*=.*$': 'public_files_dir = public',
    r'^force_ssl\s*=.*$': 'force_ssl = On',
    r'^force_login_ssl\s*=.*$': 'force_login_ssl = On',
    r'^session_check_ip\s*=.*$': 'session_check_ip = On',
    r'^salt\s*=.*$': f'salt = "{salt}"',
    r'^api_key_secret\s*=.*$': f'api_key_secret = "{api_secret}"',
    r'^require_validation\s*=.*$': 'require_validation = On',
    r'^recaptcha\s*=.*$': 'recaptcha = off',
    r'^captcha_on_register\s*=.*$': 'captcha_on_register = on',
    r'^captcha_on_login\s*=.*$': 'captcha_on_login = on',
    r'^task_runner\s*=.*$': 'task_runner = Off',
}

for pattern, repl in replacements.items():
    text, count = re.subn(pattern, repl, text, flags=re.MULTILINE)
    if count == 0:
        raise SystemExit(f"Missing config key for pattern: {pattern}")

path.write_text(text, encoding="utf-8")
PY

chmod 600 "${target}"
