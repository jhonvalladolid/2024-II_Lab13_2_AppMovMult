class ProductFields {
  static const List<String> values = [
    id,
    name,
    description,
    price,
    stock,
    image, // Añadimos 'image' a los campos
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
  static const String image = 'image'; // Campo para la imagen
}

class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image; // Añadimos el campo image

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image, // Lo pasamos en el constructor
  });

  Map<String, Object?> toJson() {
    return {
      ProductFields.id: id,
      ProductFields.name: name,
      ProductFields.description: description,
      ProductFields.price: price,
      ProductFields.stock: stock,
      ProductFields.image: image, // Guardamos la imagen
    };
  }

  factory Product.fromJson(Map<String, Object?> json) {
    return Product(
      id: json[ProductFields.id] as int?,
      name: json[ProductFields.name] as String,
      description: json[ProductFields.description] as String,
      price: json[ProductFields.price] as double,
      stock: json[ProductFields.stock] as int,
      image: json[ProductFields.image] as String, // Cargamos la imagen
    );
  }

  Product copy({
    int? id,
    String? name,
    String? description,
    double? price,
    int? stock,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      image: image ?? this.image, // Se pasa la imagen en la copia
    );
  }
}
