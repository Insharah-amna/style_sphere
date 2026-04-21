import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style_sphere/models/products.dart';

class ProductRepository {
  final CollectionReference _products = FirebaseFirestore.instance.collection(
    'products',
  );

  Future<String> addProduct(Product product) async {
    try {
      final docRef = await _products.add(product.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  // Fetch products with optional category filter and limit
  Future<List<Product>> fetchProducts({
    String? category,
    int limit = 10,
  }) async {
    Query query = _products;

    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }

    query = query.limit(limit);

    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final id = data['id'] ?? doc.id;

      return Product(
        id: id,
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
