
---

# 📱 Tugas Praktikum 3 Pemrograman Mobile

## 📝 Deskripsi Tugas

Pada praktikum ini, mahasiswa akan mempelajari dan mengimplementasikan **penyimpanan data lokal menggunakan SQLite** di Flutter.
SQLite merupakan **sistem database relasional (RDBMS)** yang ringan, cepat, dan tidak memerlukan server terpisah. Data disimpan langsung di perangkat dalam bentuk file `.db`, sehingga cocok digunakan untuk **aplikasi offline-first**.

---


## 🧠 Konsep Utama

### 🔹 Apa itu SQLite?

SQLite adalah sistem manajemen basis data relasional yang bersifat **embedded**, artinya semua data disimpan dalam satu file database di perangkat lokal.
Ciri khasnya:

* Tidak memerlukan instalasi server.
* Mendukung query SQL seperti `SELECT`, `INSERT`, `UPDATE`, dan `DELETE`.
* Ringan dan efisien untuk jumlah data kecil hingga menengah.
* Ideal untuk aplikasi **offline-first** atau **cache lokal**.

### 📦 Kapan Menggunakan SQLite?

SQLite cocok digunakan jika:

1. Aplikasi tidak membutuhkan koneksi internet.
2. Jumlah data relatif kecil (ratusan–ribuan baris).
3. Tidak perlu sinkronisasi real-time antar pengguna.
4. Ingin menyimpan cache lokal dari API.

### 💡 Contoh Kasus Nyata

* Aplikasi **catatan harian / to-do list**.
* Aplikasi **manajemen tugas kuliah**.
* Aplikasi **belanja offline** (data produk tersimpan lokal).
* Aplikasi untuk menyimpan **riwayat login atau preferensi pengguna**.

---

## ⚙️ Integrasi SQLite pada Flutter

Karena Flutter tidak memiliki sistem database bawaan, digunakan package eksternal **`sqflite`** yang berfungsi sebagai penghubung antara Flutter dan SQLite.

Package `sqflite` memungkinkan pengembang menjalankan perintah SQL seperti:

```sql
CREATE TABLE notes (...);
INSERT INTO notes (...);
SELECT * FROM notes;
UPDATE notes SET ...;
DELETE FROM notes WHERE ...;
```

Selain itu, biasanya digunakan juga package **`path_provider`** untuk menentukan lokasi penyimpanan file database di perangkat.


## 📚 Referensi

* [Flutter Documentation — Persistence with SQLite](https://docs.flutter.dev/cookbook/persistence/sqlite)
* [Pub.dev — sqflite package](https://pub.dev/packages/sqflite)
* [MDC-104 Flutter: Building Beautiful Apps with Material Theming](https://codelabs.developers.google.com/codelabs/mdc-104-flutter)

---
