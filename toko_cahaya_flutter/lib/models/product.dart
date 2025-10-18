class Product {
  final String id;
  final String name;
  final String categoryId;
  final double price;
  final String? imageUrl;
  DateTime? expiryDate;
  int stock;

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    this.imageUrl,
    this.expiryDate,
    this.stock = 0,
  });

  bool get hasExpiry => expiryDate != null;

  bool get isExpiringSoon {
    if (expiryDate == null) return false;
    final now = DateTime.now();
    return expiryDate!.isAfter(now) && expiryDate!.isBefore(now.add(const Duration(days: 7)));
  }

  bool get isExpired {
    if (expiryDate == null) return false;
    return expiryDate!.isBefore(DateTime.now());
  }

  Product copyWith({
    String? name,
    String? categoryId,
    double? price,
    String? imageUrl,
    DateTime? expiryDate,
    int? stock,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      expiryDate: expiryDate ?? this.expiryDate,
      stock: stock ?? this.stock,
    );
  }
}
