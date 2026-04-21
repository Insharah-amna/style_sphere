import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style_sphere/models/orders.dart';

class OrderRepository {
  final CollectionReference orders = FirebaseFirestore.instance.collection(
    'orders',
  );

  Future<String> createOrder(OrdersModel order) async {
    try {
      final docRef = await orders.add(order.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<OrdersModel?> getOrder(String orderId) async {
    try {
      final doc = await orders.doc(orderId).get();
      if (doc.exists) {
        return OrdersModel.fromDoc(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  Stream<QuerySnapshot> getUserOrders(String userId) {
    return orders
        .where('userId', isEqualTo: userId)
        // .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await orders.doc(orderId).update({'status': newStatus});
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      await orders.doc(orderId).update({'status': 'cancelled'});
      // await orders.doc(orderId).delete();
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }
}
