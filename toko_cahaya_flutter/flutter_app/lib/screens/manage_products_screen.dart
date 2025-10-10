import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/manage';
  const ManageProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final expiring = provider.expiringSoon();
    final expired = provider.expired();

    return Scaffold(
      appBar: AppBar(title: const Text('Manajemen Barang')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          if (expiring.isNotEmpty) ...[
            const Text('Akan Kedaluwarsa (<7 hari)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...expiring.map((p) => _ExpiryTile(product: p)),
            const SizedBox(height: 16),
          ],
          if (expired.isNotEmpty) ...[
            const Text('Sudah Kedaluwarsa', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...expired.map((p) => _ExpiryTile(product: p, expired: true)),
          ],
          if (expiring.isEmpty && expired.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Center(child: Text('Tidak ada barang kedaluwarsa')),
            ),
        ],
      ),
    );
  }
}

class _ExpiryTile extends StatelessWidget {
  final Product product;
  final bool expired;
  const _ExpiryTile({required this.product, this.expired = false});

  @override
  Widget build(BuildContext context) {
    final dateStr = product.expiryDate?.toLocal().toString().split(' ').first ?? '-';
    return Card(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('Kedaluwarsa: $dateStr'),
        trailing: TextButton(
          onPressed: () async {
            final newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 30)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
              helpText: 'Pilih tanggal penggantian',
            );
            if (newDate != null && context.mounted) {
              final updated = product.copyWith(expiryDate: newDate);
              context.read<ProductProvider>().updateProduct(updated);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tanggal kedaluwarsa diperbarui')),
              );
            }
          },
          child: Text(expired ? 'Ganti Barang' : 'Perbarui Tanggal'),
        ),
      ),
    );
  }
}
