# HM:BtN+ — Katalog Fitur & Ide Patch Lanjutan

Dokumen kerja untuk proyek **Harvest Moon: Back to Nature+**.

| | |
|---|---|
| Basis | Back to nature+ **v1.6** (rilis 10 Nov 2026) |
| Disc target | Harvest Moon: Back to Nature USA, SLUS-01115 |
| SHA-1 disc bersih | `CB26381FA1336BDD15F07469E59F1143CCF37B03` |
| Upstream mod | https://github.com/Fragrant-radish/HM-back-to-nature-plus |
| Basis kode | https://github.com/coalslav/hmbtn-decomp (matching decompilation, CC0) |
| Status dokumen | Katalog fitur sudah final; bagian ide patch masih usulan, belum diuji |

---

## 1. Konteks teknis singkat

Mod ini bukan hex edit. Ia dibangun di atas **matching decompilation** `hmbtn-decomp`:
source C yang di-build ulang menghasilkan EXE + 13 overlay **byte-for-byte identik**
dengan disc asli, diverifikasi lewat SHA-1, dan bisa membangun ulang seluruh disc
image bila diberi disc bersih milik sendiri.

Konsekuensinya: menambah fitur berarti **menulis C lalu build ulang disc**, bukan
mencari offset. Batasnya bukan lagi "bisa atau tidak", tapi ketersediaan aset dan
anggaran VRAM/save.

Peta modul decomp yang relevan:

```
src/main/game/        event_flags.c  farm_state.c  farm_tables.c  cooking_recipes.c
                      shop_restock.c horse_names.c picture_codes.c
src/main/ui/          menu_window.c  window_frame.c  ui_icons.c  heart.c  name_entry.c
src/main/text/        tabel string & font
src/overlay/11_GF_FARM/   animals/  field/  event/  menu/  people/  world/
                          farm_data.c  farm_init.c  farm_load.c  farm_main.c  estate.c
src/overlay/15_saveload/  struktur save/load
src/overlay/17_GF_MG1 … 25_GF_MG5   data & logika per map group
```

---

## 2. Fitur baru yang tidak ada di game original

### 2.1 Alat dan tier

| Fitur | Versi | Efek |
|---|---|---|
| **Adamantite tier** | v1.0 | Tier di atas Mythril; hoe 3x6, sickle 7x7, hammer 3x3, can 36 kotak, axe 18 lumber/tunggul, hammer menambal lahan 3x3; muncul di Level page dan farm score |
| **Golden brush** | v1.6 | Saibara: gold ore + 3000G + 3 hari; efek menyikat dihitung dobel |
| **Ocarina** | v1.4 | Dari Pastor Carter setelah main di Music Festival dan full hearts; semua hewan di sekitar dianggap sudah diajak bicara dan disikat |

### 2.2 Upgrade Gotz

Semua bernilai baru, biaya lumber + gold, 3 malam, surat masuk mailbox.

- Bulk shipping (X dengan tangan kosong di shipping bin; juga dari punggung kuda)
- Reinforce hothouse (tahan badai dan blizzard)
- Hardwood fences (lumber tidak pernah lapuk)
- Automatic feeders (trough terisi otomatis tiap malam)
- **Build bridge** ke tambang pulau danau (semi–gugur, hilang saat winter)
- **Expand field**: +190 kotak di timur kandang + water trough
- **Enlarge hothouse**: +6 plot 3x3

### 2.3 Hewan

| Fitur | Versi | Efek |
|---|---|---|
| **Miracle berry** | v1.0, v1.6 | Won 10000G; hewan senang di cuaca buruk, stray dog tidak menakuti; v1.6 juga mencegah kerugian stray dog saat tidur |
| **Coloured hens** | v1.0 | White / Brown / Lavender / Grey; anak mewarisi warna induk; tampil di kandang, saat digendong, menu, daftar jual Lillia, dan kontes |
| **Tack colors** | v1.6 | 12 warna pelana, 500G sekali beli, ganti gratis; tampil di cutscene dan horse race |
| **Town horse** | v1.6 | Kuda bisa ditunggangi keluar farm, menunggu di lokasi turun, saddlebag bisa shipping dari luar farm, kembali ke kandang pagi bila ditinggal |
| Gold badge ekstra | v1.0 | Best-herd dan best-flock memberi gold badge ke empat hewan (original satu) |
| Hen cluck | v1.0 | Ayam di luar berbunyi sekali per kunjungan, tidak terus-menerus |

### 2.4 Rucksack dan shipping

- **Rucksack stacks** (v1.1): mode Classic / Stacks (9) / Stacks 99
- **Rucksack+** 33333G, menaikkan kapasitas stack ke 99
- R2 dengan tangan kosong mengambil satu item dari stack pertama; Select membuang satu stack (dengan konfirmasi)
- Jumlah item tampil di menu, kulkas, cabinet, dan kitchen
- Bulk shipping mengirim seluruh stack; event yang meminta barang mengambil dari stack
- **Shipping bin: Ship all** (v1.3): kirim seluruh rucksack tanpa upgrade Gotz

### 2.5 Toko, outfit, ekonomi

- **12 outfit baru** (Red, Green, Purple, Black, Aqua, Pink, Yellow, Emerald, Teal, Dark blue, Orange, Dark green) + yarn ball senada, 2000G masing-masing
- **Running boots** 7000G
- Bulk food dari supermarket langsung masuk kulkas
- Cabinet tersedia lebih awal
- **All seeds** (v1.6): Jeff menjual strawberry, pumpkin, spinach sejak hari pertama
- Harga telur per kualitas: 50 / 60 / 80 / 150G (v1.3)
- Supermarket mengirim surat saat Rucksack+ tersedia

### 2.6 UI dan kualitas hidup

| Fitur | Versi | Efek |
|---|---|---|
| Options berhalaman | v1.4 | L1/R1 pindah halaman, panah oranye gaya asli |
| Menu **Back to nature+** | v1.3 | Semua pengaturan mod di satu tempat |
| Text speed | v1.1 | Normal / Fast (±6x saat menahan X, tiap kotak tetap menunggu input) |
| Stamina & fatigue | v1.2 | Bars / Numbers / Off, di bawah jam; disembunyikan saat menu atau uang terbuka |
| Crop walk | v1.2 | Bisa berjalan menembus tanaman |
| Shipping report | v1.3 | Saat tidur: gambar, jumlah, gold, total; sampai 8 halaman |
| Villagers page | v1.4, v1.5 | Semua warga A–Z dengan kepala dan hearts, 5 per layar, wrap atas–bawah |
| Clock settings | v1.6 | Kecepatan Normal / Half / Quarter; tampilan menit on/off |
| Shuffle field | v1.6 | Acak ulang rumput, kerikil, ranting, tunggul, batu di lahan |
| Title screen | v1.5 | Logo jadi "Back to Nature+" |
| Debug menu | v1.0 | Menu debug developer dimatikan tapi diterjemahkan ke Inggris |

### 2.7 Aturan permainan dan mode

| Fitur | Versi | Efek |
|---|---|---|
| **Hard seasons** | v1.3 | Tools in order, Expensive town (uang jadi 0, harga +50%), Doctor's bill 2000/4000/8000, Breeding livestock |
| **Marry all** | v1.5 | Menikahi semua gadis; tiap pernikahan punya tanggal dan heart di kalender; istri membuka rumah/toko kapan saja |
| **Wild weather** | v1.6 | Rainy Mineral Town: peluang hari cerah dibalik jadi hujan (kecuali winter) |
| **Easy seasons** | v1.6 | Tanpa hurricane/blizzard; turun sebagai hujan/salju |
| **Classic game** | v1.6 | Saklar untuk mematikan seluruh konten baru, menyisakan fix dan opsi |

### 2.8 Perbaikan bug original (bukan konten baru)

- Brush menaikkan hearts sapi/domba (+2 per malam menyikat)
- Golden egg dijual lebih mahal dari telur biasa
- Farm score bisa mencapai 100% (power berry dan mystic berry ikut dihitung)
- Memancing di arah kuda tidak lagi memasukkan lure ke saddlebag
- Rival berhenti merindukan gadis yang menikah dengan pemain
- Fireworks Festival: kehadiran Kai dan dialog Popuri diperbaiki
- Lamaran seminggu sebelum pernikahan rival tidak lagi membatalkan pasangan yang salah
- Warna eggplant hothouse saat digendong
- Rucksack+ menagih 33333G, bukan memberi 32000G
- Tombol Up berfungsi di Options
- Item tak terlihat di rucksack (kombinasi yarn ball + rucksack penuh)
- Nama istri di halaman summary (v1.1.1), fanfare Cooking Festival (v1.6)

---

## 3. Ide patch lanjutan

Semua ide di bawah memakai aset yang **sudah ada di disc**, kecuali disebut lain.
Kolom "Target" menunjuk modul decomp yang paling relevan, bukan lokasi final.

### 3.1 QoL — risiko rendah, murni kode

| # | Ide | Efek gameplay | Target | Effort | Risiko save |
|---|---|---|---|---|---|
| 1 | **Ranch ledger** | Halaman menu berisi semua hewan: nama, heart, umur, produktivitas, siap dipanen atau tidak | `ui/menu_window.c`, `11_GF_FARM/animals/` | Sedang | Rendah |
| 2 | **Bulk plant** | Tahan tombol saat menanam untuk menanam deretan benih sekaligus | `11_GF_FARM/field/` | Sedang | Rendah |
| 3 | **Harvest radius** | Sabit/panen area 3x3 untuk tanaman matang, seperti pola hoe Adamantite | `11_GF_FARM/field/` | Sedang | Rendah |
| 4 | **Sort rucksack** | Urutkan isi tas per kategori atau kualitas dengan satu tombol | `ui/menu_window.c` | Rendah | Rendah |
| 5 | **Sort kulkas & cabinet** | Sama seperti di atas, plus filter per kategori | `ui/menu_window.c` | Rendah | Rendah |
| 6 | **Gift & birthday journal** | Daftar ulang tahun warga dan hadiah yang sudah terbukti disukai | `src/main/text/`, `11_GF_FARM/people/` | Rendah | Rendah |
| 7 | **Panen siap-petik** | Penanda kecil di tanaman yang sudah bisa dipanen (sprite yang ada) | `11_GF_FARM/field/` | Sedang | Rendah |
| 8 | **Jam berhenti di dalam ruangan** | Opsi: waktu hanya berjalan saat berada di luar | `src/main/system.c` | Rendah | Rendah |
| 9 | **Riwayat dialog** | Tombol untuk membuka kembali beberapa kotak dialog terakhir | `src/main/ui/window_frame.c` | Sedang | Rendah |
| 10 | **Pratinjau isi shipping bin** | Lihat daftar barang di bin sebelum tidur, tanpa menunggu laporan | `11_GF_FARM/menu/` | Rendah | Rendah |
| 11 | **Auto-advance dialog** | Opsi kecepatan teks "Auto" selain Normal/Fast | `src/main/ui/window_frame.c` | Rendah | Rendah |
| 12 | **Nama area saat masuk** | Label kecil "Mineral Town", "Beach", dan seterusnya saat pindah map | `17_GF_MG1 … 25_GF_MG5` | Rendah | Rendah |

### 3.2 Konten baru dari aset lama

| # | Ide | Efek gameplay | Target | Effort | Risiko save |
|---|---|---|---|---|---|
| 13 | **Anak ikut bekerja** | Setelah anak besar, ia memberi pakan atau mengambil telur otomatis | `11_GF_FARM/people/`, `event_flags.c` | Tinggi | Sedang |
| 14 | **Pedagang keliling** | Won berjualan dengan stok berotasi tiap hari, bukan daftar tetap | `shop_restock.c` | Sedang | Rendah |
| 15 | **Festival kedua dari logika lama** | Pakai ulang mesin horse race untuk "farm derby" antar hewan ternak | `11_GF_FARM/event/` | Tinggi | Rendah |
| 16 | **Heart event tambahan** | Event baru per NPC memakai sistem event dan flag yang sudah ada | `event_flags.c`, `11_GF_FARM/event/` | Sedang | Sedang |
| 17 | **Kepribadian hewan** | Nama + reaksi berbeda per hewan, pola sama seperti `horse_names.c` | `11_GF_FARM/animals/` | Sedang | Sedang |
| 18 | **Ensiklopedia ikan** | Halaman menu daftar ikan yang pernah ditangkap | `ui/menu_window.c` | Sedang | Rendah |
| 19 | **Buku resep pintar** | Tandai resep yang sudah pernah dimasak, urutkan berdasarkan bahan | `cooking_recipes.c` | Rendah | Rendah |
| 20 | **Papan permintaan warga** | Daftar request aktif dan sisa waktu, tanpa harus bicara satu per satu | `11_GF_FARM/people/` | Rendah | Rendah |
| 21 | **Cuaca besok di kalender** | Ramalan 1 hari ke depan tampil di kalender, bukan hanya TV | `src/main/game/` | Rendah | Rendah |
| 22 | **Kandang otomatis parsial** | Gotz upgrade: pintu kandang buka/tutup sendiri sesuai cuaca | `11_GF_FARM/animals/`, `estate.c` | Sedang | Sedang |

### 3.3 Mode dan tantangan

| # | Ide | Efek gameplay | Target | Effort | Risiko save |
|---|---|---|---|---|---|
| 23 | **No TV shopping** | Item TV shopping dimatikan; semua harus didapat di dunia | `shop_restock.c` | Rendah | Rendah |
| 24 | **Debt mode** | Mulai dengan utang ke kota, jatuh tempo di akhir tahun kedua | `src/main/game/farm_state.c` | Sedang | Rendah |
| 25 | **Randomizer** | Harga benih dan hadiah festival diacak per save | `farm_tables.c`, `shop_restock.c` | Sedang | Sedang |
| 26 | **Speedrun timer** | Overlay waktu real-time di luar jam game | `src/main/ui/` | Sedang | Rendah |
| 27 | **Season lock challenge** | Tahun dipotong, target tercapai sebelum winter | `farm_state.c` | Sedang | Rendah |
| 28 | **Hardcore hadiah** | Hadiah festival dikurangi, poin farm dihitung lebih ketat | `farm_tables.c` | Rendah | Rendah |

### 3.4 Butuh aset baru atau berisiko tinggi

| # | Ide | Kenapa sulit |
|---|---|---|
| 29 | **NPC dengan slot baru** | Perlu entri tabel NPC, pointer jadwal, ID dialog, dan slot save. Save lama bisa rusak |
| 30 | **Area/map baru** | Perlu tilemap, collision, tabel warp, dan tileset; VRAM 1 MB jadi batas keras |
| 31 | **Cuaca visual baru** | Partikel salju lebat atau kabut butuh aset dan anggaran VRAM |
| 32 | **Musim atau hari tambahan** | Seluruh tabel tanaman, jadwal NPC, dan event terikat ke 4 musim × 28 hari |
| 33 | **Multi-save slot** | Struktur save berukuran tetap; menambah slot berarti mengubah layout memory card |

### 3.5 Prioritas yang saya sarankan

1. **Ranch ledger** — nilai tertinggi, risikonya paling kecil. Villagers page di v1.4 sudah membuktikan pola ini jalan.
2. **Bulk plant + harvest radius** — langsung menghilangkan bagian paling membosankan dari farming.
3. **Gift & birthday journal** — memakai data yang sudah ada, tidak menambah state baru.
4. **Pedagang keliling** — menambah variasi harian tanpa satu pun aset baru.
5. **Anak ikut bekerja** — dampak emosional besar, tapi tunda sampai struktur save dipahami.

---

## 4. Batasan yang wajib dicek sebelum menulis kode

- **VRAM 1 MB.** Sprite dan portrait baru harus menggantikan, bukan menambah. Ide 29–31 mentok di sini.
- **Ukuran save tetap.** Flag baru harus memakai bit kosong di `event_flags.c`, bukan menambah field.
- **Ruang disc masih longgar.** Patch v1.6 menambah sekitar 629 sector (±1,4 MB); disc PS1 punya ruang lebih.
- **Kompatibilitas save.** Setiap perubahan struktur state berisiko seperti peringatan resmi mod: save "Marry all" di versi lama bisa merusak game.
- **Urutan patch.** Selalu terapkan pada disc bersih, bukan pada hasil patch sebelumnya.
- **Distribusi.** Hanya file `.xdelta`, tidak pernah ISO penuh.

## 5. Cara memverifikasi ide sebelum dianggap layak

1. Baca modul target di `hmbtn-decomp`, pastikan matching dan bisa di-build (`check` lolos).
2. Tentukan apakah ide butuh state persisten. Kalau ya, cari bit kosong di `event_flags.c`.
3. Cek apakah butuh sprite di luar yang sudah ada. Kalau ya, hitung anggaran VRAM lebih dulu.
4. Build, jalankan lewat DuckStation, bandingkan dengan save lama dan save baru.
5. Uji tiga skenario minimum: new game, save lama yang dimuat, dan pergantian musim.
