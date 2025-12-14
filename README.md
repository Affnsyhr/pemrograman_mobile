# 📱 Mobile Programming Collection – Praktikum 

Repositori ini berisi kumpulan implementasi **pemrograman mobile** (Flutter) yang membahas berbagai konsep inti dan lanjutan dalam pengembangan aplikasi mobile, dengan studi kasus utama berupa **aplikasi To-Do List**.

Fokus utama proyek ini adalah integrasi **penyimpanan data lokal**, **layanan backend Firebase**, **manajemen state**, serta **fitur berbasis lokasi (Maps)**.

---

## 🚀 Fitur & Topik yang Dibahas

### 1️⃣ SQLite (Local Database)

SQLite digunakan sebagai **database lokal** untuk menyimpan data to-do secara offline.

**Implementasi utama:**

* CRUD (Create, Read, Update, Delete) data tugas
* Penyimpanan data lokal tanpa koneksi internet
* Sinkronisasi sederhana dengan UI

**Contoh data yang disimpan:**

* Judul tugas
* Deskripsi tugas
* Status (selesai / belum selesai)
* Tanggal pembuatan

📌 *SQLite cocok digunakan untuk aplikasi yang membutuhkan akses data cepat dan offline-first.*

---

### 2️⃣ Firebase Firestore (Cloud Database)

Firestore digunakan sebagai **database cloud** untuk menyimpan dan menyinkronkan data to-do secara real-time.

**Implementasi utama:**

* Penyimpanan data to-do berbasis cloud
* Sinkronisasi real-time antar perangkat
* Struktur koleksi dan dokumen

**Keunggulan:**

* Real-time update
* Skalabilitas tinggi
* Mudah diintegrasikan dengan Firebase Authentication

---

### 3️⃣ Firebase Authentication

Firebase Authentication digunakan untuk **manajemen autentikasi pengguna**.

**Fitur autentikasi:**

* Login & Register menggunakan Email dan Password
* Manajemen sesi pengguna
* Proteksi data berdasarkan user yang login

**Manfaat:**

* Setiap pengguna memiliki daftar to-do masing-masing
* Data lebih aman dan terisolasi

---

### 4️⃣ State Management

State management digunakan untuk mengelola **perubahan data dan UI** secara efisien.

**Konsep yang dibahas:**

* Pemisahan logika bisnis dan tampilan
* Pengelolaan state to-do (loading, success, error)
* Update UI secara reaktif

**Tujuan utama:**

* Kode lebih terstruktur
* Mudah dikembangkan dan dipelihara
* Menghindari rebuild UI yang tidak perlu

---

### 5️⃣ Maps (Location-Based Feature)

Fitur Maps digunakan untuk menampilkan **lokasi tertentu** yang berkaitan dengan aktivitas atau tugas pengguna.

**Implementasi utama:**

* Menampilkan peta menggunakan Google Maps
* Menentukan lokasi berdasarkan input pengguna
* Menampilkan marker pada peta

**Contoh penggunaan:**

* Menandai lokasi tugas
* Menampilkan lokasi aktivitas

---

---

## 🎯 Tujuan Pembelajaran

Repositori ini dibuat untuk:

* Memahami perbedaan **local database** dan **cloud database**
* Mengimplementasikan **autentikasi pengguna**
* Menerapkan **state management** dalam aplikasi mobile
* Mengintegrasikan **Maps & Location Service**
* Menjadi **portofolio pemrograman mobile**

---

## 🛠️ Teknologi yang Digunakan

* **Flutter / Dart**
* **SQLite**
* **Firebase Firestore**
* **Firebase Authentication**
* **Google Maps API**

---

## 📌 Catatan

Proyek ini bersifat **pembelajaran dan pengembangan**, sehingga setiap modul dapat berdiri sendiri dan dikembangkan lebih lanjut sesuai kebutuhan.

---

✨ *Dibuat sebagai bagian dari pembelajaran Pemrograman Mobile dan pengembangan portofolio.*
