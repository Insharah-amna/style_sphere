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

final List<Product> specialProducts = const [
  Product(
    title: 'Blue Jacket',
    description: 'Recycle Boucle Knit Cardigan Pink',
    rating: 4.0,
    price: 79.99,
    image: 'assets/images/homepage_card2.png',
  ),
  Product(
    title: 'Sneakers',
    description: 'Recycle Boucle Knit Cardigan Pink',
    rating: 4.0,
    price: 59.99,
    image: 'assets/images/homepage_card3.png',
  ),
  Product(
    title: '21WN reversible angora cardigan',
    description: 'Recycle Boucle Knit Cardigan Pink',
    rating: 4.0,
    price: 119.99,
    image: 'assets/images/homepage_card1.png',
  ),
  Product(
    title: 'Oblong bag',
    description: 'Recycle Boucle Knit Cardigan Pink',
    rating: 4.0,
    price: 74.99,
    image: 'assets/images/homepage_card4.png',
  ),
];
