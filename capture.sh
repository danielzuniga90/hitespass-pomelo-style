#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -x "$CHROME" ] || { echo "No se encontro Google Chrome en $CHROME"; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
cp styles.css "$TMP/styles.css"

cat > "$TMP/shot.html" <<'HTML'
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="styles.css">
<style>
  html, body { margin: 0; padding: 0; background: #ffffff;
    font-family: poppins, nunito, -apple-system, BlinkMacSystemFont, sans-serif; }
  #wrap { width: 816px; height: 471px; display: flex; align-items: center; justify-content: center; }
  #inner { transform: scale(2); transform-origin: center; }
  .list .pan, .list .pan .wrapper { display: flex; }
</style>
</head>
<body><div id="wrap"><div id="inner"><div id="list" class="list"><div class="pan" id="pan"><span class="label">Numero de tarjeta</span><div class="wrapper"><span data-testid="pan-value">1234 5678 9876 5432</span><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" class="copy-icon"><path stroke-linecap="round" stroke-linejoin="round" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path></svg></div></div><div class="expiration-date" id="expiration-date"><span class="label">Fecha de expiracion</span><span>12/28</span></div><div class="security-code" id="security-code"><span class="label">Codigo de seguridad</span><span>99</span></div></div></div></div></body>
</html>
HTML

"$CHROME" --headless --disable-gpu --hide-scrollbars \
  --force-device-scale-factor=1.25 --window-size=816,471 \
  --virtual-time-budget=8000 \
  --screenshot="$PWD/preview.png" "file://$TMP/shot.html" >/dev/null 2>&1

echo "preview.png -> $(wc -c < preview.png | tr -d ' ') bytes"
