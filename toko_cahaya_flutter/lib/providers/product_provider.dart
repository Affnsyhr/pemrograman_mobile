import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  List<Product> byCategory(String? categoryId) {
    if (categoryId == null) return products;
    return _products.where((p) => p.categoryId == categoryId).toList();
  }

  Product? getById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void updateProduct(Product updated) {
    final idx = _products.indexWhere((p) => p.id == updated.id);
    if (idx != -1) {
      _products[idx] = updated;
      notifyListeners();
    }
  }

  void seedMock() {
    if (_products.isNotEmpty) return;
    final now = DateTime.now();
    _products.addAll([
      Product(
        id: 'p1',
        name: 'Keripik Kentang 80g',
        categoryId: categories[0].id,
        price: 12000,
        stock: 50,
        expiryDate: now.add(const Duration(days: 5)), // soon
      ),
      Product(
        id: 'p2',
        name: 'Minuman Teh Botol 350ml',
        categoryId: categories[1].id,
        price: 6000,
        stock: 100,
        expiryDate: now.add(const Duration(days: 20)),
      ),
      Product(
        id: 'p3',
        name: 'Susu UHT 1L',
        categoryId: categories[1].id,
        price: 23000,
        stock: 30,
        expiryDate: now.add(const Duration(days: 3)), // soon
      ),
      Product(
        id: 'p4',
        name: 'Tisu Dapur',
        categoryId: categories[2].id,
        price: 15000,
        stock: 40,
        // no expiry
      ),
      Product(
        id: 'p5',
        name: 'Apel Fuji (1kg)',
        categoryId: categories[3].id,
        price: 38000,
        stock: 20,
        expiryDate: now.add(const Duration(days: 2)), // very soon
      ),
    ]);
    notifyListeners();
  }

  List<Product> expiringSoon() {
    final soon = _products.where((p) => p.isExpiringSoon && !p.isExpired).toList();
    soon.sort((a, b) => (a.expiryDate ?? DateTime.now()).compareTo(b.expiryDate ?? DateTime.now()));
    return soon;
  }

  List<Product> expired() {
    return _products.where((p) => p.isExpired).toList();
  }
}
