class Product {
  final String image;
  final String title;
  final String description;
  final double price;
  final double rating;

  const Product({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
  });
}

final List<Product> products = const [
  Product(
    image: "assets/images/product1.png",
    title: "lamerei",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 120,
    rating: 4.8,
  ),
  Product(
    image: "assets/images/product2.png",
    title: "5252 by o!oi",
    description: "2021 Signature Sweatshirt [NAVY]",
    price: 79.99,
    rating: 4.9,
  ),
  Product(
    image: "assets/images/product3.png",
    title: "21WN",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 120,
    rating: 4.8,
  ),
  Product(
    image: "assets/images/product4.png",
    title: "lamerei",
    description: "2021 Signature Sweatshirt [NAVY]",
    price: 79.99,
    rating: 4.7,
  ),
  Product(
    image: "assets/images/product2.png",
    title: "5252 by o!oi",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 120,
    rating: 4.8,
  ),
  Product(
    image: "assets/images/product1.png",
    title: "21WN",
    description: "2021 Signature Sweatshirt [NAVY]",
    price: 79.99,
    rating: 4.5,
  ),
];

final List<Product> newProducts = const [
  Product(
    title: "21WN reversible angora cardigan",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 119.99,
    image: "assets/images/homepage_card1.png",
    rating: 4.0,
  ),
  Product(
    title: "Blue Jacket",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 79.99,
    image: "assets/images/homepage_card2.png",
    rating: 4.0,
  ),
  Product(
    title: "Sneakers",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 59.99,
    image: "assets/images/homepage_card3.png",
    rating: 4.0,
  ),
  Product(
    title: "Oblong bag",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 74.99,
    image: "assets/images/homepage_card4.png",
    rating: 4.0,
  ),
];

final List<Product> specialProducts = const [
  Product(
    title: "Blue Jacket",
    description: "Recycle Boucle Knit Cardigan Pink",
    rating: 4.0,
    price: 79.99,
    image: "assets/images/homepage_card2.png",
  ),
  Product(
    title: "Sneakers",
    description: "Recycle Boucle Knit Cardigan Pink",
    rating: 4.0,
    price: 59.99,
    image: "assets/images/homepage_card3.png",
  ),
  Product(
    title: "21WN reversible angora cardigan",
    description: "Recycle Boucle Knit Cardigan Pink",
    rating: 4.0,
    price: 119.99,
    image: "assets/images/homepage_card1.png",
  ),
  Product(
    title: "Oblong bag",
    description: "Recycle Boucle Knit Cardigan Pink",
    rating: 4.0,
    price: 74.99,
    image: "assets/images/homepage_card4.png",
  ),
];
