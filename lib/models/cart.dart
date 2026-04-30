import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    this.addedAt,
  });

  final String id; // Firestore document ID
  final String productId; // FK → products collection
  final int quantity;
  final DateTime? addedAt;

  // Convert Firestore document → CartItem
  factory CartItem.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartItem(
      id: doc.id,
      productId: data['productId'],
      quantity: data['quantity'] ?? 1,
      addedAt: (data['addedAt'] as Timestamp?)?.toDate(),
    );
  }

  // Convert CartItem → Map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'addedAt': addedAt != null
          ? Timestamp.fromDate(addedAt!)
          : FieldValue.serverTimestamp(),
    };
  }
}
