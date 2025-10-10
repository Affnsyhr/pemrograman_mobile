import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product';
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final product = context.watch<ProductProvider>().getById(productId);
    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Produk')),
        body: const Center(child: Text('Produk tidak ditemukan')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: Container(
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, size: 72),
            ),
          ),
          const SizedBox(height: 16),
          Text(product.name, style: Theme.of(context).textTheme.titleLarge),
          Text('Rp ${product.price.toStringAsFixed(0)}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: cs.primary)),
          const SizedBox(height: 8),
          if (product.expiryDate != null)
            Text('Kedaluwarsa: ${product.expiryDate!.toLocal().toString().split(" ").first}'),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              context.read<CartProvider>().add(product);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ditambahkan ke cart')));
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Tambah ke Cart'),
          ),
        ],
      ),
    );
  }
}
