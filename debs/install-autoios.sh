#!/bin/sh
# Conflict-safe AutoIOS install (SSH root)
set -e
DEB="/var/tmp/autoios.deb"
# Prefer GitHub raw by commit-less github.com/raw (less CDN lag than raw.githubusercontent.com)
URL1="https://github.com/manhvip/autoios-repo/raw/main/debs/autoios-latest.deb"
URL2="https://cdn.jsdelivr.net/gh/manhvip/autoios-repo@main/debs/autoios-latest.deb"

echo "==> Remove conflicting optional VNC package (if any)"
dpkg -r com.manhvip.autoios-vnc 2>/dev/null || true
dpkg --remove --force-remove-reinstreq com.manhvip.autoios-vnc 2>/dev/null || true

echo "==> Fix half-configured packages"
dpkg --configure -a 2>/dev/null || true

echo "==> Download"
rm -f "$DEB"
if ! curl -L --fail -o "$DEB" "$URL1"; then
  echo "fallback jsDelivr..."
  curl -L --fail -o "$DEB" "$URL2"
fi
ls -la "$DEB"

echo "==> Install"
dpkg -i "$DEB" || dpkg -i --force-overwrite --force-conflicts --force-depends "$DEB"
dpkg --configure -a || true

echo "==> Verify"
dpkg -l com.manhvip.autoios | tail -1
ls -l /var/jb/usr/local/bin/trollvncserver \
      /var/jb/Library/LaunchDaemons/com.manhvip.autoios.trollvnc.plist 2>/dev/null || true
pgrep -l trollvncserver || echo "(trollvnc not running yet)"
curl -s http://127.0.0.1:2000/api/status || true
curl -s http://127.0.0.1:2000/api/vnc/info || true
echo "DONE"
