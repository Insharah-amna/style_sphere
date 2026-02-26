import 'package:style_sphere/constants/products.dart';

class Collection {
  final String image;
  final String collectionName;
  final int number;

  const Collection({
    required this.image,
    required this.collectionName,
    required this.number,
  });
}

final List<Collection> collections = const [
  Collection(
    image: "assets/images/collection1.png",
    collectionName: "OCTOBER COLLECTION",
    number: 01,
  ),
  Collection(
    image: "assets/images/collection2.png",
    collectionName: "BLACK COLLECTION",
    number: 02,
  ),
  Collection(
    image: "assets/images/collection3.png",
    collectionName: "HAE BY HAEKIM",
    number: 03,
  ),
];

final List<Product> collectionProducts = const [
  Product(
    title: "October Collection",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 119.99,
    image: "assets/images/c_product1.png",
    rating: 4.8,
  ),
  Product(
    title: "October Collection",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 119.99,
    image: "assets/images/c_product2.png",
    rating: 4.8,
  ),
  Product(
    title: "October Collection",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 119.99,
    image: "assets/images/c_product3.png",
    rating: 4.8,
  ),
  Product(
    title: "October Collection",
    description: "Recycle Boucle Knit Cardigan Pink",
    price: 119.99,
    image: "assets/images/c_product4.png",
    rating: 4.8,
  ),
];
