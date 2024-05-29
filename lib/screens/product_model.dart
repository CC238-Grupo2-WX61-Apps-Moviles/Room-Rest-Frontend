class Product {
  final int id;
  final String nameCategory;
  final String name;
  final double price;
  final String color;
  final String category;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.nameCategory,
    required this.name,
    required this.price,
    required this.color,
    required this.category,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nameCategory: json['nameCategory'],
      name: json['name'],
      price: json['price'],
      color: json['color'],
      category: json['category'],
      description: json['description'],
      image: json['image'],
    );
  }
}
