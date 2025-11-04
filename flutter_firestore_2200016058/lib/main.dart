import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'firebase_options.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => AuthService(),

      child: MaterialApp(
        title: 'To-Do List with Auth',

        debugShowCheckedModeBanner: false,

        theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),

        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<UserModel?>(
      stream: authService.user,

      builder: (context, snapshot) {
        // Loading state

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        // Jika belum login, tampilkan LoginPage

        if (user == null) {
          return const LoginPage();
        }

        // Jika sudah login, tampilkan HomePage dengan FirestoreService

        return Provider<FirestoreService>(
          create: (_) => FirestoreService(),

          child: HomePage(),
        );
      },
    );
  }
}
