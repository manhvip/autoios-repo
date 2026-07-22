# AutoIOS apt repo

## Sileo source (recommended)

```
https://raw.githubusercontent.com/manhvip/autoios-repo/main/
```

Dung **raw.githubusercontent** (it cache / it loi do khi Refresh).

**Khong dung** `https://manhvip.github.io/autoios-repo/` — Sileo hay bao:
`Hash for Packages.bz2 ... is invalid!`

Backup CDN:

```
https://cdn.jsdelivr.net/gh/manhvip/autoios-repo@main/
```

## After each push — purge jsDelivr

```
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages.gz
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Release
```

## SSH install (no Sileo)

```bash
curl -L https://raw.githubusercontent.com/manhvip/autoios-repo/main/debs/install-autoios.sh | sh
```
