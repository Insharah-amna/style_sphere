import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final CollectionReference orders = FirebaseFirestore.instance.collection(
    'orders',
  );

  Future<void> createOrder(
    String userId,
    List<Map<String, dynamic>> items,
    double totalPrice,
  ) async {
    await orders.add({
      'userId': userId,
      'items': items, // each item: {productId, quantity}
      'totalPrice': totalPrice,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserOrders(String userId) {
    return orders.where('userId', isEqualTo: userId).snapshots();
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await orders.doc(orderId).update({'status': status});
  }
}
