# 🛒 KasirKita - Sistem Kasir Modern

Aplikasi Point of Sale (POS) yang elegan dan modern untuk mengelola transaksi penjualan di toko retail. Dibangun dengan Flutter untuk pengalaman pengguna yang luar biasa.

## ✨ Fitur Utama

### 🎯 **Sistem Keranjang Belanja Pintar**
- **Manajemen Quantity Otomatis**: Jika produk sudah ada di keranjang, quantity akan bertambah otomatis
- **Tampilan Cart yang Informatif**: Menampilkan quantity, harga per item, dan total harga
- **Swipe to Delete**: Geser item ke kiri untuk menghapus dengan konfirmasi dialog
- **Reset Keranjang**: Tombol untuk mengosongkan seluruh keranjang

### 📱 **Scan Barcode Produk**
- **QR Code Scanner**: Menggunakan kamera untuk scan barcode produk
- **Validasi Real-time**: Verifikasi produk ada dalam database
- **Feedback Visual**: SnackBar konfirmasi saat produk berhasil ditambahkan

### 💳 **Sistem Pembayaran**
- **Tombol Bayar Sekarang**: Tombol besar di bagian bawah layar POS
- **Konfirmasi Pembayaran**: AlertDialog dengan detail total belanja
- **Transaksi Berhasil**: Feedback visual setelah pembayaran selesai
- **Auto Clear Cart**: Keranjang otomatis dikosongkan setelah transaksi

### 📋 **Katalog Produk**
- **QR Code Display**: Setiap produk memiliki QR code untuk scan
- **Informasi Lengkap**: Nama produk, kode, dan harga
- **Tampilan Elegan**: Card design dengan gradient dan shadow

## 🎨 **Desain UI/UX**

### **Tema Warna**
- **Primary**: Gold (#FFC107) - memberikan kesan mewah dan profesional
- **Secondary**: Light Pink (#F8BBD9) - memberikan kesan lembut dan modern
- **Background**: Gradient dari putih ke pink sangat muda

### **Material Design 3**
- Komponen modern dengan elevation dan shadow
- Rounded corners untuk tampilan halus
- Animasi smooth dan feedback visual
- Typography yang konsisten dan readable


## 📱 **Cara Penggunaan**

1. **Menu Utama**
   - Pilih "Masuk ke Mesin Kasir" untuk POS
   - Pilih "Lihat Katalog QR" untuk melihat produk

2. **Halaman POS**
   - Tap "Scan Produk" untuk scan barcode
   - Lihat keranjang terupdate otomatis
   - Geser item ke kiri untuk hapus per item
   - Tap "Bayar Sekarang" untuk proses pembayaran

3. **Halaman Katalog**
   - Lihat semua produk dengan QR code
   - Scan QR code untuk tambah ke keranjang

## 🛠️ **Teknologi yang Digunakan**

- **Flutter**: Framework UI untuk cross-platform development
- **Dart**: Programming language
- **Material Design**: Design system dari Google
- **Mobile Scanner**: Plugin untuk QR/Barcode scanning
- **Intl**: Package untuk formatting currency

## 📋 **Requirements**

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android/iOS device atau emulator
- Kamera untuk fitur scan QR



**💡 Tips**: Scan QR code dari katalog untuk menambahkan produk ke keranjang dengan cepat!
