# AutoIOS apt repo

## Sileo source (recommended)

```
https://cdn.jsdelivr.net/gh/manhvip/autoios-repo@main/
```

Use **jsDelivr** — GitHub Pages (`manhvip.github.io`) often lags or 404s the `.deb`.

## After each push

Purge CDN cache if Sileo still shows an old version:

```
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages.gz
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Release
```

## SSH install (no Sileo)

```bash
curl -L -o /var/tmp/autoios.deb \
  "https://github.com/manhvip/autoios-repo/raw/main/debs/com.manhvip.autoios_0.3.19-1%2Bdebug_iphoneos-arm64.deb"
dpkg -i /var/tmp/autoios.deb
# remove Safe Mode dylibs if any
rm -f /var/jb/Library/MobileSubstrate/DynamicLibraries/AutoiosScreen.*
rm -f /var/jb/Library/MobileSubstrate/DynamicLibraries/AutoiosOverlay.*
killall -9 SpringBoard
```
