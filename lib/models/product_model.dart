class Product {
  final String code; // ID unik (isi QR Code)
  final String name;
  final double price;
  Product({required this.code, required this.name, required this.price});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

// Database Barang Toko (Hardcoded)
final List<Product> storeProducts = [
  Product(code: 'BRG-001', name: 'Air Mineral 600ml', price: 5000),
  Product(code: 'BRG-002', name: 'Roti Coklat', price: 12000),
  Product(code: 'BRG-003', name: 'Keripik Pedas', price: 15000),
  Product(code: 'BRG-004', name: 'Kopi Botol', price: 8500),
];
