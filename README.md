# Releaf

Marketplace buku bekas berbasis Flutter dengan backend Supabase.

## Fitur

- Browse & cari buku bekas
- Scan ISBN untuk cari buku
- Jual buku bekas
- Wishlist & keranjang belanja
- Checkout dengan alamat pengiriman
- Riwayat transaksi
- Dashboard statistik penjualan
- Dark mode

## Tech Stack

- Flutter 3.x
- Supabase (Auth, Database, Storage)
- fl_chart (visualisasi data)
- mobile_scanner (barcode scanner)

## Setup

1. Clone repo
```bash
git clone https://github.com/Llunatics/Releaf.git
cd Releaf
```

2. Install dependencies
```bash
flutter pub get
```

3. Setup Supabase credentials di `lib/core/config/supabase_config.dart`

4. Run
```bash
flutter run
```

## Build APK

```bash
flutter build apk --release
```

APK output: `build/app/outputs/flutter-apk/app-release.apk`

## Download

APK tersedia di [Releases](https://github.com/Llunatics/Releaf/releases)

## Tim Pengembang

| Nama | NIM |
|------|-----|
| Andiko Ramadani | 3337230003 |
| Ismet Maulana Azhari | 3337230014 |
| Muhamad Anggara Ramadhan | 3337230031 |

## License

MIT
