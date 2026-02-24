import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/screens/home_page.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({super.key});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  var _currentIndex = 0;

  final List<Product> products = const [
    Product(
      name: "Blue Jacket",
      price: 79.99,
      image: "assets/images/homepage_card2.png",
    ),
    Product(
      name: "Sneakers",
      price: 59.99,
      image: "assets/images/homepage_card3.png",
    ),
    Product(
      name: "21WN reversible angora cardigan",
      price: 119.99,
      image: "assets/images/homepage_card1.png",
    ),
    Product(
      name: "Oblong bag",
      price: 74.99,
      image: "assets/images/homepage_card4.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 440,
            viewportFraction: 0.8,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: products.map((product) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                spacing: 3,
                children: [
                  Image.asset(product.image),
                  const SizedBox(height: 2),

                  Text(product.name),

                  Text("\$${product.price}",
                    style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.secondary
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: products.asMap().entries.map((entry) {
            return Transform.rotate(
              angle: 0.785,
              child: Container(
                width: 6.0,
                height: 6.0,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: _currentIndex != entry.key
                      ? Border.all(width: 1, color: Colors.grey)
                      : .fromBorderSide(.none),
                  color: _currentIndex != entry.key
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
