import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/item.dart';

class CartProvider extends ChangeNotifier {
  /// Menyimpan daftar item dalam keranjang (private)
  final List<Item> _items = [];

  /// Mengembalikan daftar item sebagai view yang tidak dapat diubah.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// Menghitung total harga semua item dalam keranjang.
  int get totalPrice => _items.fold<int>(0, (sum, item) => sum + item.price);

  /// Menambahkan item ke keranjang dan memberi tahu pendengar.
  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  // Menghapus item dari keranjang
  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  /// Mengosongkan keranjang dan memberi tahu pendengar.
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// Mengembalikan jumlah item di keranjang.
  int get itemCount => _items.length;

  /// Menghapus item berdasarkan id. Berguna jika Anda tidak mempunyai referensi Item.
  void removeItemById(String id) {
    _items.removeWhere((i) => i.id == id);
    notifyListeners();
  }
}
