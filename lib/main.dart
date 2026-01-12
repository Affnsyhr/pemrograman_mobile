import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/data_page.dart';
import 'pages/generate_page.dart';
import 'pages/scan_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFFD700); // gold
    const accentColor = Color(0xFFE91E63); // pink

    final base = ThemeData.light();

    final theme = base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: primaryColor,
        secondary: accentColor,
      ),
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 1,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: primaryColor,
          foregroundColor: Colors.black,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
    );

    return MaterialApp(
      title: 'Data Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final pages = [const DataPage(), const GeneratePage(), const ScanPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (v) => setState(() => _index = v),
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Data Mahasiswa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Generate QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan QR',
          ),
        ],
      ),
    );
  }
}
