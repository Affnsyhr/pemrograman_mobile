import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/product_provider.dart';
import '../screens/product_list_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/manage_products_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final user = context.watch<AuthProvider>().current;
    final expiring = context.watch<ProductProvider>().expiringSoon();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Cart',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Halo, ${user?.email ?? 'Pengguna'}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          if (expiring.isNotEmpty)
            Card(
              color: cs.errorContainer,
              child: ListTile(
                leading: const Icon(Icons.warning_amber_rounded),
                title: Text('Ada ${expiring.length} produk akan kedaluwarsa < 7 hari'),
                subtitle: const Text('Cek dan ganti di halaman Manajemen Barang'),
                trailing: TextButton(
                  onPressed: () => Navigator.pushNamed(context, ManageProductsScreen.routeName),
                  child: const Text('Kelola'),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _QuickCard(
                icon: Icons.storefront,
                label: 'Lihat Produk',
                onTap: () => Navigator.pushNamed(context, ProductListScreen.routeName),
              ),
              _QuickCard(
                icon: Icons.category,
                label: 'Kategori',
                onTap: () => Navigator.pushNamed(context, ProductListScreen.routeName),
              ),
              _QuickCard(
                icon: Icons.inventory_2_outlined,
                label: 'Manajemen Barang',
                onTap: () => Navigator.pushNamed(context, ManageProductsScreen.routeName),
              ),
              _QuickCard(
                icon: Icons.shopping_cart_checkout,
                label: 'Cart/Checkout',
                onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: cs.onPrimaryContainer),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: cs.onPrimaryContainer)),
          ],
        ),
      ),
    );
  }
}
