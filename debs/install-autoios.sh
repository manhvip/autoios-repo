#!/bin/sh
# Conflict-safe AutoIOS install (SSH root)
set -e
URL="https://raw.githubusercontent.com/manhvip/autoios-repo/main/debs/autoios-latest.deb"
DEB="/var/tmp/autoios.deb"

echo "==> Remove conflicting optional VNC package (if any)"
dpkg -r com.manhvip.autoios-vnc 2>/dev/null || true
dpkg --remove --force-remove-reinstreq com.manhvip.autoios-vnc 2>/dev/null || true

echo "==> Fix half-configured packages"
dpkg --configure -a 2>/dev/null || true

echo "==> Download"
curl -L --fail -o "$DEB" "$URL"
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
