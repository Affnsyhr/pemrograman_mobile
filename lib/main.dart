import 'package:flutter/material.dart';
import 'pages/map_page.dart'; // Pastikan path ini sesuai dengan folder kamu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KulinerHunt', // Judul Aplikasi
      debugShowCheckedModeBanner:
          false, // Hilangkan banner debug di pojok kanan
      theme: ThemeData(
        // Kita set warna utama jadi Orange biar nuansa makanan
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,

        // Kustomisasi AppBar default
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
      ),
      // Halaman pertama yang dibuka
      home: const MapPage(),
    );
  }
}
