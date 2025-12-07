# 🍴 KulinerHunt

Aplikasi mobile untuk berbagi rekomendasi tempat makan & kuliner dengan teman-teman menggunakan lokasi GPS dan peta interaktif.

## 📋 Deskripsi

**KulinerHunt** adalah aplikasi Flutter yang memungkinkan pengguna untuk:
- ✅ Membagikan rekomendasi tempat makan favorit mereka
- ✅ Memilih lokasi melalui GPS atau pemilihan manual di peta
- ✅ Melihat rekomendasi teman-teman di peta secara real-time
- ✅ Menambahkan marker custom yang menarik dan interaktif

## 🎯 Fitur Utama

### 1. **Dual Location Input**
- **Gunakan GPS**: Otomatis mendeteksi lokasi pengguna
- **Pilih di Peta**: Manual selection dengan tap-to-move marker
- Fallback ke map picker jika GPS ditolak

### 2. **Modal Bottom Sheet UI**
- Input nama tempat/menu dalam desain modern
- Tampil koordinat real-time saat menggerakkan marker
- Header informatif dengan status lokasi
- Responsive design untuk berbagai ukuran layar

### 3. **Marker Custom**
- Marker dengan circular badge orange untuk lokasi yang ada
- Marker merah dengan shadow glow untuk pemilihan lokasi baru
- Tap marker existing untuk zoom otomatis ke lokasi
- Nama tempat ditampilkan di bawah marker

### 4. **Sync Data Real-time**
- Upload lokasi baru ke MockAPI via POST request
- Download daftar lokasi terbaru via GET request
- Safe parsing data dengan `double.tryParse`
- Error handling yang robust

### 5. **Visual Polish**
- AppBar dengan emoji dan shadow elevation
- Polished button styling dengan rounded corners
- Color-coded SnackBar (green success, red error)
- Smooth transitions dan responsif UI

## 🛠️ Tech Stack

| Teknologi | Versi | Penggunaan |
|-----------|-------|-----------|
| **Flutter** | 3.9.2+ | Framework UI |
| **Dart** | 3.9.2+ | Programming Language |
| **flutter_map** | 8.2.2 | Widget Peta OpenStreetMap |
| **latlong2** | 0.9.1 | Koordinat geografis (LatLng) |
| **geolocator** | 9.0.2 | GPS & location services |
| **http** | 1.6.0 | HTTP requests ke API |

## 📡 API Integration

**Base URL**: `https://692e6ee091e00bafccd3d946.mockapi.io/locations/Kelas`

### Endpoints:
- `GET /locations/Kelas` - Ambil semua lokasi rekomendasi
- `POST /locations/Kelas` - Tambah lokasi baru


## 🚀 Cara Menjalankan

### Prerequisites:
- Flutter SDK 3.9.2+
- Dart SDK 3.9.2+
- Android Studio / VS Code dengan Flutter extension
- Chrome browser (untuk testing web) atau Android/iOS emulator

### Setup:
```bash
# Clone repository
git clone https://github.com/Affnsyhr/pemrograman_mobile.git
cd maps_2200016058

# Install dependencies
flutter pub get

# Run aplikasi
# Web
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios
```

``


## 🎨 Color Scheme

- **Primary**: Orange (`Colors.orange`)
- **Success**: Green (SnackBar)
- **Error**: Red (SnackBar)
- **Background**: White & Light Gray
- **Marker Existing**: Orange with glow
- **Marker New**: Red with arrow

## ⚠️ Catatan Penting

1. **GPS Permissions**: Di Android/iOS, pastikan app memiliki permission akses GPS
2. **Web Testing**: Di Chrome, browser akan meminta izin geolocation
3. **API Rate Limit**: MockAPI memiliki rate limit, jangan spam requests
4. **Fallback**: Jika GPS ditolak, user akan otomatis dialihkan ke map picker

## 🔮 Future Enhancements

- [ ] Drag-to-move marker (drag gesture support)
- [ ] Auto-refresh dengan polling / WebSocket
- [ ] Search & filter lokasi
- [ ] Rating & review untuk setiap lokasi
- [ ] Foto menu dari tempat makan
- [ ] Dark mode support
- [ ] Offline data caching

## 📧 Author

**NIM**: 2200016058
**Course**: Pemrograman Mobile (Semester 7)
**Instructor**: [Course Info]

## 📄 License

MIT License - Project untuk keperluan akademik

---

**Last Updated**: December 7, 2025
**Status**: ✅ Implementasi Dasar Selesai
