class Category {
  final String id;
  final String name;

  const Category({required this.id, required this.name});
}

const categories = <Category>[
  Category(id: 'snacks', name: 'Makanan Ringan'),
  Category(id: 'drinks', name: 'Minuman'),
  Category(id: 'household', name: 'Perlengkapan'),
  Category(id: 'fresh', name: 'Segar'),
];
