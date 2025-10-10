import 'package:flutter/material.dart';
import 'auth/sign_in_screen.dart';
import 'auth/sign_up_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Cahaya Lkz'),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              'Selamat datang di Toko Cahaya Lkz',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Belanja kebutuhan harian dengan mudah.\nMasuk atau daftar untuk mulai belanja.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => Navigator.pushNamed(context, SignInScreen.routeName),
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, SignUpScreen.routeName),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
