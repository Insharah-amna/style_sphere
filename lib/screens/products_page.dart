import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/products.dart';
import 'package:style_sphere/widgets/app_bar.dart';
import 'package:style_sphere/widgets/cart_drawer.dart';
import 'package:style_sphere/widgets/footer.dart';
import 'package:style_sphere/widgets/menu_drawer.dart';
import 'package:style_sphere/widgets/pagination.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

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
                        padding: EdgeInsetsGeometry.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFf6f6f6),
                          borderRadius: .circular(50),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/grid.svg',
                          width: 20,
                          color: Colors.grey,
                        ),
                      ),

                      Container(
                        padding: EdgeInsetsGeometry.all(8),
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
                    child: GridView.builder(
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        // spacing: 3,
        children: [
          Image.asset(widget.product.image, fit: .cover),
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
