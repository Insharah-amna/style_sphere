import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/products.dart';
import 'package:style_sphere/widgets/app_bar.dart';
import 'package:style_sphere/widgets/cart_drawer.dart';
import 'package:style_sphere/widgets/footer.dart';
import 'package:style_sphere/widgets/menu_drawer.dart';
import 'package:style_sphere/widgets/pagination.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  var productViewTypeGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Products Page"),
      backgroundColor: AppColors.offWhite,

      drawer: MenuDrawer(),
      endDrawer: CartDrawer(),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 14),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "4500 APPAREL",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  Row(
                    spacing: 10,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        alignment: .center,
                        decoration: BoxDecoration(
                          color: Color(0xFFf6f6f6),
                          borderRadius: .circular(50),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              productViewTypeGrid = !productViewTypeGrid;
                            });
                          },
                          child: productViewTypeGrid
                              ? SvgPicture.asset(
                                  "assets/icons/grid.svg",
                                  width: 20,
                                  color: Color(0xFF999999),
                                )
                              : Icon(
                                  Icons.format_list_bulleted_sharp,
                                  size: 20,
                                  color: Color(0xFF999999),
                                ),
                        ),
                      ),

                      Container(
                        width: 38,
                        height: 38,
                        alignment: .center,
                        decoration: BoxDecoration(
                          color: Color(0xFFf6f6f6),
                          borderRadius: .circular(50),
                        ),
                        child: Icon(
                          Icons.filter_list_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                    child: productViewTypeGrid
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 14,
                                  crossAxisSpacing: 14,
                                  childAspectRatio: 0.55,
                                ),
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ProductCard(product: product);
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Padding(
                                padding: EdgeInsetsGeometry.only(bottom: 14),
                                child: ProductListCard(product: product),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 50),

                  Pagination(),

                  const SizedBox(height: 40),

                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
              style: Theme.of(context).textTheme.bodyMedium,
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
        // handle tap
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

class IsFavourite extends StatefulWidget {
  const IsFavourite({super.key});

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
          : Icon(Icons.favorite_border, color: AppColors.secondary, size: 20),
    );
  }
}
