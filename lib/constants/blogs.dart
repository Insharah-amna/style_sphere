class Blog {
  final id;
  final String image;
  final String title;
  final String description;
  final String timeStamp;

  const Blog({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.timeStamp,
  });
}

final List<Blog> blogs = const [
  Blog(
    id: 1,
    image: "assets/images/blog1.png",
    title: "2021 Style Guide: The Biggest Fall Trends",
    description:
      "You guys know how much I love mixing high and low-end – it’s "
      "the best way to get the most bang for your buck while still elevating your wardrobe. "
      "The same goes for handbags! And honestly they are probably the best pieces to mix and match. "
      "I truly think the key to completing a look is with a great bag and I found so many this "
      "year that I wanted to share a round-up of my most worn handbags. ",
    timeStamp: "4 days ago",
  ),
  Blog(
    id: 1,
    image: "assets/images/blog2.png",
    title: "3 Pairs of Denim You Won’t Believe",
    description:
      "The excitement of fall fashion is here and I’m already loving some of the trend forecasts "
      "I truly think the key to completing a look is with a great bag and I found so many this "
      "year that I wanted to share a round-up of my most worn handbags. ",
    timeStamp: "5 days ago",
  ),
  Blog(
    id: 1,
    image: "assets/images/blog3.png",
    title: "5 Fall Looks I’m Loving",
    description:
      "The excitement of fall fashion is here and I’m already loving some of the trend forecasts "
      "I truly think the key to completing a look is with a great bag and I found so many this "
      "year that I wanted to share a round-up of my most worn handbags. ",
    timeStamp: "01//11/2025",
  ),
  Blog(
    id: 1,
    image: "assets/images/blog4.png",
    title: "5 Fall Boot Trends You Need to Try",
    description: "The excitement of fall fashion is here and I’m already loving some of the trend forecasts ",
    timeStamp: "25/10/2025",
  ),
  Blog(
    id: 1,
    image: "assets/images/blog5.png",
    title: "2021 Style Guide:\nThe Biggest Fall Trends",
    description: "The excitement of fall fashion is here and I’m already loving some of the trend forecasts ",
    timeStamp: "16/10/2025",
  ),
  Blog(
    id: 1,
    image: "assets/images/blog6.png",
    title: "3 Pairs of Denim You Won’t Believe",
    description:
      "You guys know how much I love mixing high and low-end – it’s "
      "the best way to get the most bang for your buck while still elevating your wardrobe. "
      "The same goes for handbags! And honestly they are probably the best pieces to mix and match. "
      "I truly think the key to completing a look is with a great bag and I found so many this "
      "year that I wanted to share a round-up of my most worn handbags. ",
    timeStamp: "10/10/2025",
  ),
];