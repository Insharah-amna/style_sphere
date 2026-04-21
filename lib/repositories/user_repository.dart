import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style_sphere/models/cart.dart';
import 'package:style_sphere/models/users.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user by ID
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromDoc(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  // Update specific user fields
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('users').doc(userId).update(updates);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Save or update user (full replace)
  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }

  // ============ CART OPERATIONS ============

  // Add item to cart
  Future<void> addToCart(String userId, String productId, int quantity) async {
    final userRef = _firestore.collection('users').doc(userId);

    // Get current cart
    final doc = await userRef.get();
    final data = doc.data();
    Map<String, dynamic> currentCart = {};

    if (data != null && data['cart'] != null) {
      currentCart = Map<String, dynamic>.from(data['cart']);
    }

    // Check if product already in cart
    if (currentCart.containsKey(productId)) {
      // Update quantity
      final existingQuantity = currentCart[productId]['quantity'] as int;
      currentCart[productId]['quantity'] = existingQuantity + quantity;
    } else {
      // Add new item
      currentCart[productId] = {
        'productId': productId,
        'quantity': quantity,
        'addedAt': FieldValue.serverTimestamp(),
      };
    }

    // Update Firestore
    await userRef.update({'cart': currentCart});
  }

  // Remove item from cart
  Future<void> removeFromCart(String userId, String productId) async {
    final userRef = _firestore.collection('users').doc(userId);

    final doc = await userRef.get();
    final data = doc.data();
    if (data == null || data['cart'] == null) return;

    Map<String, dynamic> currentCart = Map<String, dynamic>.from(data['cart']);
    currentCart.remove(productId);

    await userRef.update({'cart': currentCart});
  }

  Future<void> clearCart(String userId) async {
    final userRef = _firestore.collection('users').doc(userId);

    await userRef.update({'cart': FieldValue.delete()});
  }

  // Update quantity
  Future<void> updateQuantity(
    String userId,
    String productId,
    int newQuantity,
  ) async {
    if (newQuantity <= 0) {
      await removeFromCart(userId, productId);
      return;
    }

    final userRef = _firestore.collection('users').doc(userId);

    final doc = await userRef.get();
    final data = doc.data();
    if (data == null || data['cart'] == null) return;

    Map<String, dynamic> currentCart = Map<String, dynamic>.from(data['cart']);

    if (currentCart.containsKey(productId)) {
      currentCart[productId]['quantity'] = newQuantity;
      await userRef.update({'cart': currentCart});
    }
  }

  // Get cart items with product details
  Stream<List<CartItemWithProduct>> watchCart(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().asyncMap((
      doc,
    ) async {
      if (!doc.exists) return [];

      final data = doc.data();
      if (data == null || data['cart'] == null) return [];

      final cartMap = Map<String, dynamic>.from(data['cart']);
      final List<CartItemWithProduct> itemsWithProducts = [];

      // Fetch each product's details
      for (var entry in cartMap.entries) {
        final productId = entry.key;
        final cartData = Map<String, dynamic>.from(entry.value);

        // Fetch product details from products collection
        final productDoc = await _firestore
            .collection('products')
            .doc(productId)
            .get();

        if (productDoc.exists) {
          final productData = productDoc.data()!;
          itemsWithProducts.add(
            CartItemWithProduct(
              productId: productId,
              quantity: cartData['quantity'] as int,
              addedAt: (cartData['addedAt'] as Timestamp?)?.toDate(),
              productName: productData['name'] ?? 'Unknown',
              productDesc: productData['description'] ?? '',
              productPrice: (productData['price'] as num).toDouble(),
              productImage: productData['imageUrl'] ?? '',
            ),
          );
        }
      }

      return itemsWithProducts;
    });
  }

  // Simpler: Get just cart items (without product details)
  Future<Map<String, CartItem>> getCart(String userId) async {
    final user = await getUser(userId);
    if (user == null) return {};
    return user.cart;
  }
}

// Helper model for cart items with product details
class CartItemWithProduct {
  final String productId;
  final int quantity;
  final DateTime? addedAt;
  final String productName;
  final String productDesc;
  final double productPrice;
  final String productImage;

  CartItemWithProduct({
    required this.productId,
    required this.quantity,
    this.addedAt,
    required this.productName,
    required this.productDesc,
    required this.productPrice,
    required this.productImage,
  });

  double get subtotal => productPrice * quantity;

  // Add this method to convert to Map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'productName': productName,
      'productDesc': productDesc,
      'productPrice': productPrice,
      'productImage': productImage,
      'subtotal': subtotal,
      'addedAt': addedAt != null ? Timestamp.fromDate(addedAt!) : null,
    };
  }
}
