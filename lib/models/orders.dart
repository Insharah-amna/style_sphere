import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersModel {
  final String? orderId;
  final String userId;
  final Map<String, dynamic> items;
  final double totalPrice;
  final String status;
  final DateTime? createdAt;

  OrdersModel({
    this.orderId,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.status,
    this.createdAt,
  });

  factory OrdersModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrdersModel(
      orderId: doc.id,
      userId: data['userId'] ?? '',
      items: data['items'] ?? {},
      totalPrice: data['totalPrice'] ?? 0.0,
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
