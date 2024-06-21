class CartItem {
  final int id;
  int quantity;
  final int userId;
  final String nameCategory;
  final String name;
  final double price;
  final String color;
  final String category;
  final String description;
  final String image;
  final int productId;

  CartItem({
    required this.id,
    required this.quantity,
    required this.userId,
    required this.nameCategory,
    required this.name,
    required this.price,
    required this.color,
    required this.category,
    required this.description,
    required this.image,
    required this.productId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      userId: json['userId'],
      nameCategory: json['nameCategory'],
      name: json['name'],
      price: json['price'].toDouble(),
      color: json['color'],
      category: json['category'],
      description: json['description'],
      image: json['image'],
      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'userId': userId,
      'nameCategory': nameCategory,
      'name': name,
      'price': price,
      'color': color,
      'category': category,
      'description': description,
      'image': image,
      'productId': productId,
    };
  }
}