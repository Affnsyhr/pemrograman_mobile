import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<CartProvider>().checkout(),
      builder: (_, snapshot) {
        return Scaffold(
          appBar: AppBar(title: const Text('Checkout')),
          body: Center(
            child: snapshot.connectionState == ConnectionState.done
                ? const _Success()
                : const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class _Success extends StatelessWidget {
  const _Success();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 64),
        const SizedBox(height: 12),
        const Text('Pembayaran berhasil!'),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
      ],
    );
  }
}
