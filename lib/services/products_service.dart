import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );

  Future<void> addProduct(String name, double price, String imageUrl) async {
    await products.add({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
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
