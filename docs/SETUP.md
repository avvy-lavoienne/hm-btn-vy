# Panduan Setup

Panduan lengkap untuk PC ini dan untuk laptop. Semua perintah dijalankan dari
root repo (folder yang berisi `PLAY.bat`).

---

## 1. Prasyarat

| Kebutuhan | Keterangan |
|---|---|
| Windows 10/11 x64 | Diuji di Windows dengan PowerShell 5.1 |
| Git | https://git-scm.com/download/win |
| Salinan game sendiri | Harvest Moon: Back to Nature USA, SLUS-01115, bersih |
| BIOS PS1 USA | `scph5501.bin`, MD5 `490F666E1AFB15B7362B406ED1CEA246` |
| Visual C++ Redistributable 2015-2022 x64 | Kalau DuckStation gagal start karena `VCRUNTIME140.dll` |

Repo tidak menyimpan disc, BIOS, emulator, atau file patch. Semua diunduh lewat
`scripts/setup.ps1`, dan file game tetap milikmu sendiri.

---

## 2. Di PC ini (sudah berjalan)

1. Repo: `C:\Users\MyPC PRO\Games\hm-btn-vy`
2. Disc bersih: `local\disc-original\HARVESTMOON.bin` + `.cue`
3. BIOS: `bios\scph5501.bin`
4. Patch sudah diterapkan ke `local\disc-patched\`
5. Jalankan `PLAY.bat`

Kalau perlu mengulang dari nol:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify-disc.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\apply-patch.ps1
```

---

## 3. Di laptop

### 3.1 Clone repo

```powershell
cd D:\Games
git clone https://github.com/avvy-lavoienne/hm-btn-vy.git
cd hm-btn-vy
```

### 3.2 Unduh emulator dan patch

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\setup.ps1
```

Skrip ini membuat folder kerja, mengunduh DuckStation, DeltaPatcher, xdelta3, dan
file patch v1.6, lalu memverifikasi hash masing-masing. Skrip juga memasang
`config\settings.ini` ke folder emulator sehingga Setup Wizard DuckStation tidak
muncul saat pertama dijalankan.

### 3.3 Pindahkan disc dan BIOS

Salin dari PC (lewat flashdisk atau jaringan):

| Dari PC | Ke laptop |
|---|---|
| `local\disc-original\HARVESTMOON.bin` | `local\disc-original\HARVESTMOON.bin` |
| `local\disc-original\HARVESTMOON.cue` | `local\disc-original\HARVESTMOON.cue` |
| `bios\scph5501.bin` | `bios\scph5501.bin` |

Keduanya sengaja tidak masuk git. Alternatifnya, ekstrak ulang dari disc milikmu
sendiri dengan `chdman extractcd` bila disc tersimpan sebagai `.chd`.

### 3.4 Patch dan mainkan

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify-disc.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\apply-patch.ps1
.\PLAY.bat
```

### 3.5 Pindahkan save

Save ada di `emulator\memcards\`. Folder itu diabaikan git, jadi salin manual:

```powershell
# dari PC
Copy-Item .\emulator\memcards\* \\LAPTOP\share\memcards\ -Recurse
# di laptop
Copy-Item \\LAPTOP\share\memcards\* .\emulator\memcards\ -Recurse
```

---

## 4. Alur kerja git

```powershell
git status
git add docs scripts README.md PLAY.bat .gitignore .gitattributes
git commit -m "deskripsi perubahan"
git push
```

Branch default repo adalah **dev**. Untuk pekerjaan besar, buat branch sendiri:

```powershell
git switch -c fitur/ranch-ledger
```

Yang tidak boleh masuk commit: `local\`, `emulator\`, `tools\`, `patch\`, `bios\`,
dan semua `*.bin`, `*.cue`, `*.chd`, `*.zip`, `*.xdelta`. Semuanya sudah ada di
`.gitignore`.

---

## 5. Membuat paket portable

Kalau laptop tidak memakai git, buat zip siap pakai:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\package.ps1
```

Hasilnya `dist\hm-btn-vy-portable.zip`, berisi emulator, BIOS, game yang sudah
dipatch, dokumentasi, dan `PLAY.bat`. Ekstrak di laptop, lalu double-click
`PLAY.bat`.

---

## 6. Masalah umum

| Gejala | Sebab dan solusi |
|---|---|
| `VCRUNTIME140.dll not found` | Install VC++ Redistributable 2015-2022 x64 |
| Layar hitam lalu kembali ke menu | Membuka `.bin`, bukan `.cue` |
| Emulator bilang BIOS tidak ada | Arahkan Settings > BIOS ke folder `bios\`, pilih `scph5501.bin` |
| `xdelta3: source file too short` | Disc bukan versi USA bersih, atau sudah pernah dipatch |
| Hash patch tidak cocok | Unduhan rusak, ulangi `setup.ps1 -Force` |
| Performa berat | Turunkan resolusi internal ke 2x, atau ganti renderer |

---

## 7. Catatan hukum

Repo ini hanya berisi dokumentasi dan skrip. Tidak ada file game, BIOS, atau patch
biner yang didistribusikan. Semua pengguna wajib memiliki salinan game sendiri.
