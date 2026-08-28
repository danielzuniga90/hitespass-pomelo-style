#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
python3 - <<'PY'
import base64, pathlib, re

BASE = 'https://danielzuniga90.github.io/hitespass-pomelo-style/'
MIME = {'.svg': 'image/svg+xml', '.webp': 'image/webp'}

src = pathlib.Path('styles.src.css')
out = pathlib.Path('styles.css')
css = src.read_text(encoding='utf-8')

for name in sorted(set(re.findall(re.escape(BASE) + r'([\w.-]+)', css))):
    f = pathlib.Path(name)
    if not f.exists():
        raise SystemExit(f'falta el archivo {name}')
    uri = f'data:{MIME[f.suffix]};base64,' + base64.b64encode(f.read_bytes()).decode()
    css = css.replace(BASE + name, uri)
    print(f'  {name} incrustado ({f.stat().st_size} bytes)')

banner = ('/* Archivo generado por build.sh. No editar a mano.\n'
          '   Editar styles.src.css y volver a correr ./build.sh */\n')
out.write_text(banner + css, encoding='utf-8')
print(f'styles.css -> {out.stat().st_size} bytes')
PY
