class CartItems {
  final String image;
  final String title;
  final String description;
  final double price;
  final int quantity;

  const CartItems({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
  });
}

final List<CartItems> cartItems = const [
  CartItems(
    image: "assets/images/cart_item1.png",
    title: "lamerei",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 120,
    quantity: 1,
  ),
  CartItems(
    image: "assets/images/cart_item2.png",
    title: "5252 by o!oi",
    description: "2021 Signature Sweatshirt [NAVY]",
    price: 79.99,
    quantity: 1,
  ),
];