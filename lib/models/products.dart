import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;
  final int stock;
  final int discount;

  const Product({
    this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.stock,
    required this.discount,
  });

  // Create Product from Firestore document
  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      category: data['category'] ?? '',
      stock: data['stock'] ?? 0,
      discount: data['discount'] ?? 0,
    );
  }

  // Convert Product to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'description': description,
      'discount': discount,
      'stock': stock,
      'rating': rating,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
