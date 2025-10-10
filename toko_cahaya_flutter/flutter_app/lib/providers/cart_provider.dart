import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {}; // productId -> item

  List<CartItem> get items => _items.values.toList();

  double get total => _items.values.fold(0, (sum, item) => sum + item.subtotal);

  void add(Product product) {
    final existing = _items[product.id];
    if (existing != null) {
      existing.quantity += 1;
    } else {
      _items[product.id] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void remove(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void decrease(String productId) {
    final item = _items[productId];
    if (item == null) return;
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  Future<void> checkout() async {
    // Simulasi proses checkout
    await Future.delayed(const Duration(milliseconds: 500));
    clear();
  }
}
