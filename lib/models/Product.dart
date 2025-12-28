class Product {
  final String name;
  final String imagepath;
  final double prix;
  final String description;
  final String category;

  Product({
    required this.name,
    required this.imagepath,
    required this.prix,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      imagepath: json['imagepath'],
      prix: (json['prix']).toDouble(),
      description: json['description'],
      category: json['category'],
    );
  }
}
