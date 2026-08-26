# AutoIOS apt repo

Wiki công khai: mở `index.html` (GitHub Pages). Sileo **không** dùng Pages.

## Sileo source (recommended)

```
https://raw.githubusercontent.com/manhvip/autoios-repo/main/
```

Dùng **raw.githubusercontent** (ít cache, ít lỗi hash khi Refresh).

**Không dùng** `https://manhvip.github.io/autoios-repo/` trong Sileo. Trang đó chỉ là wiki; Sileo hay báo `Hash for Packages.bz2 ... is invalid!`

Backup CDN:

```
https://cdn.jsdelivr.net/gh/manhvip/autoios-repo@main/
```

## SSH install (no Sileo)

```bash
curl -L https://raw.githubusercontent.com/manhvip/autoios-repo/main/debs/install-autoios.sh | sh
```

## Release (giữ nguyên luồng apt)

Repo này là nguồn apt. Mỗi lần ship:

1. Đặt file versioned vào `debs/com.manhvip.autoios_<ver>_iphoneos-arm64.deb`
2. Copy cùng file thành `debs/autoios-latest.deb` (script SSH đọc file này)
3. Cập nhật `Packages`, `Packages.gz`, `Release` (LF only, xem `.gitattributes`)
4. Xóa `.deb` cũ không còn trong `Packages` để repo gọn
5. Push `main`. Wiki (`index.html` + `wiki/`) không được đụng hash apt

Sau mỗi push, purge jsDelivr nếu ai đó dùng CDN:

```
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Packages.gz
https://purge.jsdelivr.net/gh/manhvip/autoios-repo@main/Release
```

Gói hiện tại: `com.manhvip.autoios` 0.4.37.
