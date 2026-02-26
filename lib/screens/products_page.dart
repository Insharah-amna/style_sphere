import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/products.dart';
import 'package:style_sphere/widgets/app_bar.dart';
import 'package:style_sphere/widgets/cart_drawer.dart';
import 'package:style_sphere/widgets/footer.dart';
import 'package:style_sphere/widgets/menu_drawer.dart';
import 'package:style_sphere/widgets/pagination.dart';
import 'package:style_sphere/widgets/product_card.dart';

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
                              return ProductGridCard(product: product);
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
