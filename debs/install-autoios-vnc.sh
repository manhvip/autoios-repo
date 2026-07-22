#!/bin/sh
# Manual AutoIOS View (TrollVNC) — NO dpkg.
JB=""
[ -d /var/jb ] && JB="/var/jb"

BIN="$JB/usr/local/bin/trollvncserver"
PLIST="$JB/Library/LaunchDaemons/com.manhvip.autoios.trollvnc.plist"
LABEL="com.manhvip.autoios.trollvnc"
TMP="/var/tmp/autoios-vnc-manual"

mkdir -p "$JB/usr/local/bin" "$JB/Library/LaunchDaemons" "$TMP" || true
cd "$TMP" || exit 1

echo "==> Download"
rm -f bundle.tar.gz
if command -v curl >/dev/null 2>&1; then
  curl -L --fail -o bundle.tar.gz \
    "https://raw.githubusercontent.com/manhvip/autoios-repo/main/debs/autoios-vnc-manual.tar.gz"
else
  wget -O bundle.tar.gz \
    "https://raw.githubusercontent.com/manhvip/autoios-repo/main/debs/autoios-vnc-manual.tar.gz"
fi

if [ ! -s bundle.tar.gz ]; then
  echo "FAIL: download empty"
  exit 1
fi

echo "==> Extract ($(wc -c < bundle.tar.gz) bytes)"
tar -xzf bundle.tar.gz
if [ ! -f trollvncserver ] || [ ! -f com.manhvip.autoios.trollvnc.plist ]; then
  echo "FAIL: tar contents missing"
  ls -la
  exit 1
fi

echo "==> Install files -> $BIN"
cp -f trollvncserver "$BIN"
cp -f com.manhvip.autoios.trollvnc.plist "$PLIST"
chmod 755 "$BIN"

echo "==> Start"
killall -9 trollvncserver 2>/dev/null || true
launchctl bootout system/$LABEL 2>/dev/null || true
launchctl unload "$PLIST" 2>/dev/null || true
launchctl bootstrap system "$PLIST" 2>/dev/null || launchctl load "$PLIST" 2>/dev/null || true
launchctl kickstart -k system/$LABEL 2>/dev/null || true
sleep 1
if ! pgrep -x trollvncserver >/dev/null 2>&1; then
  echo "launchctl miss — nohup fallback"
  nohup env DISABLE_TWEAKS=1 "$BIN" -p 5901 -s 0.5 -F 20 -i off -I off \
    >>/var/tmp/autoios-trollvnc-stdout.log 2>>/var/tmp/autoios-trollvnc-stderr.log &
  sleep 1
fi

echo "==> Status"
ls -la "$BIN"
pgrep -l trollvncserver || echo "WARN: no process"
curl -s http://127.0.0.1:2000/api/vnc/info || echo "WARN: :2000 down"
echo "tail stderr:"; tail -15 /var/tmp/autoios-trollvnc-stderr.log 2>/dev/null || true
echo "DONE"
exit 0
