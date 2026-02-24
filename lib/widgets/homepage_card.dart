import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/screens/home_page.dart';

class HomepageCard extends StatefulWidget {
  const HomepageCard({super.key, required this.product});

  final Product product;

  @override
  State<HomepageCard> createState() => _HomepageCardState();
}

class _HomepageCardState extends State<HomepageCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        spacing: 4,
        children: [
          Image.asset(widget.product.image, height: 220, fit: .cover,),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
            child: Column(
              spacing: 2,
              children: [

                Text(widget.product.name,
                  textAlign: .center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  textAlign: .center,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.secondary
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
