import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/app_routes.dart';
import 'package:style_sphere/constants/products.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({super.key});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  var _currentIndex = 0;

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
          items: specialProducts.map((product) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.productsDetail,
                  arguments: product,
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  spacing: 3,
                  children: [
                    Image.asset(product.image),
                    const SizedBox(height: 2),

                    Text(product.title),

                    Text(
                      "\$${product.price}",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: specialProducts.asMap().entries.map((entry) {
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
        ),
      ],
    );
  }
}
