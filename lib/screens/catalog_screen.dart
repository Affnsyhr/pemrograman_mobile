import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/cart_provider.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> catalog = [
      Item(id: '1', title: 'Laptop', price: 10000000),
      Item(id: '2', title: 'Mouse', price: 200000),
      Item(id: '3', title: 'Keyboard', price: 500000),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Barang'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                label: Text(cart.itemCount.toString()),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: catalog.length,
        itemBuilder: (context, index) {
          final item = catalog[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text('Rp ${item.price}'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Mengakses Provider untuk memanggil fungsi addItem
                // listen: false karena kita tidak butuh rebuild UI di sini
                context.read<CartProvider>().addItem(item);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.title} ditambahkan!')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
