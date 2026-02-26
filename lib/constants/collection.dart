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
