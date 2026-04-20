class Product {
  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;
  final int stock;
  final int discount;

  const Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.stock,
    required this.discount,
  });
}
