import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );

  Future<void> addProduct(
    String name,
    double price,
    String imageUrl,
    String category,
    String description,
    int discount,
    int stock,
    double rating,
  ) async {
    await products.add({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'description': description,
      'discount': discount,
      'stock': stock,
      'rating': rating,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getProducts() {
    return products.snapshots();
  }

  Future<void> updateProduct(
    String productId,
    Map<String, dynamic> data,
  ) async {
    await products.doc(productId).update(data);
  }

  Future<void> deleteProduct(String productId) async {
    await products.doc(productId).delete();
  }
}
