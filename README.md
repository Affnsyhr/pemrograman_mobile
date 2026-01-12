# responsi_2200016058

Aplikasi Flutter untuk mengelola data mahasiswa (NIM + nama), menghasilkan kode QR,
dan memproses muatan QR. Proyek ini mendukung penyimpanan lokal dan sinkronisasi cloud opsional melalui Firebase Firestore.

## Ringkasan Proyek
- **Tujuan:** Menyimpan dan mengelola data mahasiswa, membuat QR yang berisi
	payload `nim|name`, serta memproses hasil scan/masukan QR untuk menampilkan
	atau menambahkan data ke database.
- **Platform:** Web dan mobile. Saat ini project dikonfigurasi untuk menggunakan
	Firebase Firestore (lihat `lib/firebase_options.dart`) — local helpers untuk
	SQLite (`sqflite`) dan SharedPreferences tetap tersedia untuk migrasi atau
	fallback.
- **UI:** Tema utama warna emas  dengan aksen pink  dan font Poppins.

## Fitur Utama
- Tambah, lihat, dan hapus data mahasiswa (NIM + nama).
- Generate QR untuk entri mahasiswa (payload: `nim|name`).
- Scan/Process QR: pada web tersedia input/tempel payload; pemindaian kamera
	pada mobile dapat diaktifkan kembali dengan plugin scanner.

## Struktur Penting
- Model: `lib/models/student.dart`
- Database helpers:
	- Firestore: `lib/db/db_helper_firestore.dart` (aktif saat ini)
	- Mobile local (sqflite): `lib/db/db_helper_mobile.dart`
	- Web local (shared_preferences): `lib/db/db_helper_web.dart`
	- Entry export: `lib/db/db_helper.dart`
- Halaman/UI:
	- Data Mahasiswa: `lib/pages/data_page.dart`
	- Generate QR: `lib/pages/generate_page.dart`
	- Scan (web fallback): `lib/pages/scan_web.dart`

## Dependensi Utama
- `firebase_core`, `cloud_firestore` (Firebase Firestore)
- `sqflite`, `path_provider` (mobile SQLite)
- `shared_preferences` (web fallback)
- `qr_flutter` (QR generation)
- `google_fonts` (Poppins)

> Catatan: Plugin kamera scanner (`mobile_scanner`) sebelumnya dicoba namun
> dinonaktifkan untuk menjaga kestabilan build web. Untuk mengaktifkan kamera
> pada mobile, tambahkan kembali plugin dan restore `lib/pages/scan_mobile.dart`.

## Instalasi & Menjalankan
Pastikan Flutter dan Firebase CLI (opsional) sudah terpasang.

1) Ambil dependency:

```bash
flutter pub get
```

2) Jalankan pada web (Chrome):

```bash
flutter run -d chrome
```

3) Jalankan pada Android:

```bash
flutter run -d android
```

Jika Anda menggunakan Firestore, pastikan `lib/firebase_options.dart` ada
dan file konfigurasi (`google-services.json` / `GoogleService-Info.plist`) telah
ditambahkan (FlutterFire CLI biasanya menempatkannya untuk Anda).

## Migrasi & Catatan Pengembangan
- Format payload QR: `nim|name` (contoh: `2600011111|Jeki Sighang`).
- Untuk memigrasi data lokal ke Firestore, gunakan helper Firestore dan panggil
	insert untuk setiap entry yang ada di local DB.
- Periksa Firestore rules di Firebase Console sebelum production.
