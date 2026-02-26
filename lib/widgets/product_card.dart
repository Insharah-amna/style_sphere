import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/products.dart';
import 'package:style_sphere/screens/product_detail.dart';

// Product Grid Card
class ProductGridCard extends StatefulWidget {
  const ProductGridCard({
    super.key,
    required this.product,
    this.isCollectionCard = false,
  });

  final Product product;
  final bool isCollectionCard;

  @override
  State<ProductGridCard> createState() => _ProductGridCardState();
}

class _ProductGridCardState extends State<ProductGridCard> {
  var isFavourite = false;

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
        children: [
          Container(
            height: 240,
            alignment: .bottomRight,
            padding: EdgeInsetsGeometry.only(bottom: 7, right: 9),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.product.image),
                fit: .cover,
              ),
            ),
            child: IsFavourite(),
          ),
          const SizedBox(height: 3),

          Align(
            alignment: .centerLeft,
            child: Text(
              widget.product.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: widget.isCollectionCard ? AppColors.offWhite : null,
              ),
            ),
          ),

          Align(
            alignment: .centerLeft,
            child: Text(
              widget.product.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),

          const SizedBox(height: 2),
          Align(
            alignment: .centerLeft,
            child: Text(
              "\$${widget.product.price}",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}

// Favourite Button
class IsFavourite extends StatefulWidget {
  const IsFavourite({super.key, this.isDarkMode = false});

  final bool isDarkMode;

  @override
  State<IsFavourite> createState() => _IsFavouriteState();
}

class _IsFavouriteState extends State<IsFavourite> {
  var isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavourite = !isFavourite;
        });
      },
      child: isFavourite
          ? Icon(Icons.favorite, color: AppColors.secondary, size: 20)
          : widget.isDarkMode
          ? Image.asset("assets/icons/heart_white_outlined.png", width: 20)
          : Icon(Icons.favorite_border, color: AppColors.secondary, size: 20),
    );
  }
}

// Product List Card
class ProductListCard extends StatefulWidget {
  const ProductListCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  var isFavourite = false;

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Image.asset(
            widget.product.image,
            fit: BoxFit.cover,
            height: 140,
            width: 110,
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),

                // Title
                Text(
                  widget.product.title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.7,
                  ),
                ),

                const SizedBox(height: 4),

                // Description
                Text(
                  widget.product.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                const SizedBox(height: 4),

                // Price
                Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),

                const SizedBox(height: 10),

                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.secondary,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.product.rating} Ratings",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Sizes and Favorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text("Size ", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 4),
                        _SizeCircle(label: "S"),
                        SizedBox(width: 4),
                        _SizeCircle(label: "M"),
                        SizedBox(width: 4),
                        _SizeCircle(label: "L"),
                      ],
                    ),

                    IsFavourite(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for size circles
class _SizeCircle extends StatelessWidget {
  final String label;

  const _SizeCircle({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10)),
    );
  }
}
