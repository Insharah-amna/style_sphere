class Product {
  final String image;
  final String title;
  final String description;
  final double price;

  const Product({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}

final List<Product> products = const [
  Product(
    image: "assets/images/product1.png",
    title: "lamerei",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 120,
  ),
  Product(
    image: "assets/images/product2.png",
    title: "5252 by o!oi",
    description: "2021 Signature Sweatshirt [NAVY]",
    price: 79.99,
  ),
  Product(
    image: "assets/images/product3.png",
    title: "21WN",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 120,
  ),
  Product(
    image: "assets/images/product4.png",
    title: "lamerei",
    description: "2021 Signature Sweatshirt [NAVY]",
    price: 79.99,
  ),
  Product(
    image: "assets/images/product2.png",
    title: "5252 by o!oi",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 120,
  ),
  Product(
    image: "assets/images/product1.png",
    title: "21WN",
    description: "2021 Signature Sweatshirt [NAVY]",
    price: 79.99,
  ),
];
