import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style_sphere/models/cart.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final Address? address;
  final String? roles;
  final Map<String, CartItem> cart; // productId -> CartItem

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.roles,
    required this.cart,
  });

  // Convert Firestore document → UserModel
  factory UserModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    Address? address;
    if (data['address'] != null) {
      final addressData = data['address'];
      if (addressData is Map<String, dynamic>) {
        address = Address.fromMap(addressData);
      }
    }

    Map<String, CartItem> cartMap = {};
    if (data['cart'] != null) {
      final cartData = data['cart'] as Map<String, dynamic>;
      cartData.forEach((productId, value) {
        final itemData = value as Map<String, dynamic>;
        cartMap[productId] = CartItem(
          id: productId, // Use productId as document ID
          productId: productId,
          quantity: itemData['quantity'] ?? 1,
          addedAt: (itemData['addedAt'] as Timestamp?)?.toDate(),
        );
      });
    }

    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      address: address,
      roles: data['roles'] ?? 'customer',
      cart: cartMap,
    );
  }

  // Convert UserModel → Map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    final cartMap = {};
    cart.forEach((productId, item) {
      cartMap[productId] = {
        'productId': item.productId,
        'quantity': item.quantity,
        'addedAt': item.addedAt != null
            ? Timestamp.fromDate(item.addedAt!)
            : FieldValue.serverTimestamp(),
      };
    });

    return {
      'name': name,
      'email': email,
      'phone': phone,
      'roles': roles,
      'address': address,
      'cart': cartMap,
    };
  }
}

// models/address.dart
class Address {
  final String street;
  final String city;
  final String country;

  Address({required this.street, required this.city, required this.country});

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {'street': street, 'city': city, 'country': country};
  }

  // Create from Firestore
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
    );
  }

  // Format address for display
  String get formattedAddress {
    String address = street;
    address += ', $city, $country';
    return address;
  }
}
