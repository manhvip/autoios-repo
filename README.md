# AutoIOS apt repo

## Sileo source (recommended)

```
https://raw.githubusercontent.com/manhvip/autoios-repo/main/
```

Dùng **raw.githubusercontent** (ít cache / ít lỗi đỏ khi Refresh).

Backup CDN (nếu dùng jsDelivr mà Refresh đỏ → purge rồi thử lại):

```
https://cdn.jsdelivr.net/gh/manhvip/autoios-repo@main/
```

## After each push — purge jsDelivr

```
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages.gz
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages.bz2
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Release
```

## SSH install (no Sileo)

```bash
curl -L https://raw.githubusercontent.com/manhvip/autoios-repo/main/debs/install-autoios.sh | sh
```
