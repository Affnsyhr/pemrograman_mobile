import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Dashboard Penjualan';

    return MaterialApp(
      title: appName,

      // 🌈 LANGKAH 1: Buat Tema
      theme: ThemeData(
        // Tema untuk FloatingActionButton
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
        ),

        // Tema untuk AppBar (judul & warna icon)
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white, // warna teks AppBar
        ),

        // Brightness (mode terang atau gelap)
        brightness: Brightness.light,

        // Warna utama
        primaryColor: Colors.green,

        // ColorScheme (kombinasi warna utama dan sekunder)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          secondary: Colors.deepOrangeAccent,
        ),

        // Font default
        fontFamily: 'Georgia',

        // TextTheme (mengatur ukuran dan gaya teks)
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌿 AppBar dengan warna dari tema
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      // 🌿 Body pakai warna sekunder dari tema
      body: Center(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.all(16),
          child: Text(
            'Hello Dunnya!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),

      // 🌿 Floating Action Button pakai tema
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Tombol ditekan!');
        },
        child: const Icon(Icons.arrow_circle_up),
      ),
    );
  }
}
