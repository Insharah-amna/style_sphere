import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style_sphere/models/products.dart';

class ProductRepository {
  final CollectionReference _products = FirebaseFirestore.instance.collection(
    'products',
  );

  // Fetch products with optional category filter and limit
  Future<List<Product>> fetchProducts({
    String? category,
    int limit = 10,
  }) async {
    Query query = _products;

    // Apply category filter if provided
    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }

    // Apply limit
    query = query.limit(limit);

    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      return Product(
        name: data['name'] ?? '',
        price: (data['price'] as num?)?.toDouble() ?? 0.0,
        imageUrl: data['imageUrl'] ?? '',
        category: data['category'] ?? '',
        description: data['description'] ?? '',
        discount: data['discount'] ?? 0,
        stock: data['stock'] ?? 0,
        rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();
  }
}
