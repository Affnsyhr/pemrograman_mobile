## Praktikum 4 Pemrograman Mobile 
---

## 📝 To-Do List App with Firebase Firestore & Authentication

Aplikasi **To-Do List berbasis Flutter** yang terintegrasi dengan **Firebase Authentication** dan **Cloud Firestore**.
Aplikasi ini memungkinkan pengguna untuk:

* 🔐 Login dan Logout menggunakan akun Firebase.
* 🗒️ Menambahkan, mengubah status, serta menghapus tugas secara real-time.
* ☁️ Menyimpan data di Firestore agar tetap tersinkronisasi di berbagai perangkat.
* 🎨 Memiliki tampilan bersih dan konsisten menggunakan tema Material Design.

---

## 🚀 Fitur Utama

| Fitur                               | Deskripsi                                             |
| ----------------------------------- | ----------------------------------------------------- |
| 🔐 **Firebase Authentication**      | Login/Logout pengguna dengan Firebase.                |
| ☁️ **Cloud Firestore Integration**  | Data disimpan di cloud secara real-time.              |
| ⏱️ **StreamBuilder Realtime Sync**  | Daftar tugas otomatis diperbarui saat ada perubahan.  |
| 🖋️ **Add / Update / Delete Task**  | CRUD sederhana langsung dari antarmuka aplikasi.      |
| 🎨 **Material Theme Customization** | Tema warna, ikon, dan elemen UI yang rapi dan modern. |


## 🧩 Instalasi dan Konfigurasi

### 1️⃣ Clone Repository

```bash
git clone https://github.com/Affnsyhr/pemrograman_mobile.git
cd flutter_todolist_firestore
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Setup Firebase

1. Buka [Firebase Console](https://console.firebase.google.com).
2. Buat project baru dan tambahkan aplikasi Flutter (Android/iOS/Web).
3. Unduh file konfigurasi:

   * `google-services.json` → letakkan di `android/app/`
   * `GoogleService-Info.plist` → letakkan di `ios/Runner/`
4. Jalankan perintah:

   ```bash
   flutterfire configure
   ```
5. Pastikan file `firebase_options.dart` **terabaikan di `.gitignore`** (tidak di-upload ke GitHub).

---

### 4️⃣ Jalankan Aplikasi

```bash
flutter run
```


## 📸 Tampilan Aplikasi

| Layar               | Deskripsi                                  |
| ------------------- | ------------------------------------------ |
| 🏠 **Home Page**    | Menampilkan daftar tugas secara real-time. |
| ➕ **Add Task Page** | Form input tugas baru.                     |
| 🔐 **Auth Page**    | Login/Logout pengguna.                     |



---

## 🧠 Kesimpulan

Melalui proyek ini, mahasiswa atau pengembang dapat memahami cara mengintegrasikan **Firebase Firestore** ke dalam **Flutter** serta mengelola data secara real-time dengan **StreamBuilder**.
Selain itu, penerapan **Firebase Authentication** menjadikan aplikasi lebih aman dan personal, sementara **penggunaan tema Material Design** meningkatkan pengalaman pengguna agar aplikasi tampak profesional dan konsisten.

---

## 📚 Lisensi

Proyek ini bersifat open-source dan bebas digunakan untuk keperluan pembelajaran.
Dibuat dengan ❤️ menggunakan **Flutter** & **Firebase**.

---

