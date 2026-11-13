# hm-btn-vy

Proyek personal **Harvest Moon: Back to Nature (PS1)** — mod *Back to nature+ v1.6*,
dokumentasi, dan tooling untuk memainkannya di PC maupun laptop.

Repo ini **hanya menyimpan teks dan skrip**. Disc game, BIOS, emulator, dan file patch
biner tidak masuk repo: ukurannya besar, dan image game tidak boleh didistribusikan.
Semuanya diunduh atau disediakan sendiri lewat `scripts/setup.ps1`.

---

## Mulai cepat (PC baru / laptop)

```powershell
git clone https://github.com/avvy-lavoienne/hm-btn-vy.git
cd hm-btn-vy
powershell -ExecutionPolicy Bypass -File .\scripts\setup.ps1
```

Setelah itu:

1. Taruh disc bersih milikmu di `local\disc-original\` sebagai `HARVESTMOON.bin` + `.cue`
2. Taruh BIOS USA di `bios\scph5501.bin`
3. Jalankan:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\apply-patch.ps1
```

4. Double-click `PLAY.bat`

---

## Struktur

```
hm-btn-vy\
  README.md
  PLAY.bat                 launcher, path relatif
  scripts\
    setup.ps1              unduh emulator, patcher, xdelta3, dan file patch
    apply-patch.ps1        verifikasi disc lalu terapkan patch v1.6
    verify-disc.ps1        cek SHA-1 disc tanpa mengubah apa pun
    package.ps1            bikin zip portable untuk dipindah ke laptop
  docs\
    MOD-FEATURES-AND-IDEAS.md   katalog fitur v1.0-v1.6 + 33 ide patch lanjutan
    SETUP.md                    panduan lengkap PC dan laptop
  config\
    settings.ini          template konfigurasi DuckStation, dipasang oleh setup.ps1
  emulator\                (gitignored) hasil setup.ps1
  tools\                   (gitignored) DeltaPatcher + xdelta3
  patch\                   (gitignored) file .xdelta
  bios\                    (gitignored) scph5501.bin
  local\                   (gitignored) semua file game
    disc-original\
    disc-patched\
```

## Status

| Item | Nilai |
|---|---|
| Mod | Back to nature+ v1.6 |
| Disc target | USA, SLUS-01115 |
| SHA-1 disc bersih | `CB26381FA1336BDD15F07469E59F1143CCF37B03` |
| BIOS | `scph5501.bin`, MD5 `490F666E1AFB15B7362B406ED1CEA246` |
| Emulator | DuckStation x64 (portable) |
| Uji boot | BIOS SCEA tampil, title screen "Back To Nature+" tampil, 60 FPS |

## Sumber

- Mod: https://github.com/Fragrant-radish/HM-back-to-nature-plus
- Decompilation: https://github.com/coalslav/hmbtn-decomp (CC0)
- Emulator: https://github.com/stenzek/duckstation

Kamu tetap membutuhkan salinan game sendiri. Repo ini tidak menyimpan dan tidak
mendistribusikan file game.
