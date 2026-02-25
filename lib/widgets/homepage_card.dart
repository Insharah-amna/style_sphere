import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/products.dart';
import 'package:style_sphere/screens/product_detail.dart';

class HomepageCard extends StatefulWidget {
  const HomepageCard({super.key, required this.product});

  final Product product;

  @override
  State<HomepageCard> createState() => _HomepageCardState();
}

class _HomepageCardState extends State<HomepageCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product: widget.product),
          ),
        );
      },
      child: Column(
        spacing: 4,
        children: [
          Image.asset(widget.product.image, height: 220, fit: .cover),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
            child: Column(
              spacing: 2,
              children: [
                Text(
                  widget.product.title,
                  textAlign: .center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  textAlign: .center,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: AppColors.secondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
