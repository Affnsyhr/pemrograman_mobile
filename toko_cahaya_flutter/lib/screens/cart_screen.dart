import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: cart.items.length,
              itemBuilder: (_, i) {
                final item = cart.items[i];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text('Rp ${item.product.price.toStringAsFixed(0)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () => cart.decrease(item.product.id), icon: const Icon(Icons.remove_circle_outline)),
                      Text('${item.quantity}'),
                      IconButton(onPressed: () => cart.add(item.product), icon: const Icon(Icons.add_circle_outline)),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: Text('Total: Rp ${cart.total.toStringAsFixed(0)}', style: Theme.of(context).textTheme.titleMedium)),
                FilledButton(
                  onPressed: cart.items.isEmpty
                      ? null
                      : () async {
                          await Navigator.pushNamed(context, CheckoutScreen.routeName);
                        },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
