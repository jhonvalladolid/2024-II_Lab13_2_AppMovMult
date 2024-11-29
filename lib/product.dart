class ProductFields {
  static const List<String> values = [
    id,
    name,
    description,
    price,
    stock,
  ];

  static const String tableName = 'products';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String doubleType = 'REAL NOT NULL';
  static const String id = '_id';
  static const String name = 'name';
  static const String description = 'description';
  static const String price = 'price';
  static const String stock = 'stock';
}

class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final int stock;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
  });

  Map<String, Object?> toJson() {
    return {
      ProductFields.id: id,
      ProductFields.name: name,
      ProductFields.description: description,
      ProductFields.price: price,
      ProductFields.stock: stock,
    };
  }

  factory Product.fromJson(Map<String, Object?> json) {
    return Product(
      id: json[ProductFields.id] as int?,
      name: json[ProductFields.name] as String,
      description: json[ProductFields.description] as String,
      price: json[ProductFields.price] as double,
      stock: json[ProductFields.stock] as int,
    );
  }

  Product copy({
    int? id,
    String? name,
    String? description,
    double? price,
    int? stock,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }
}
