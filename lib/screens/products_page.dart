import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/navigation/cart_drawer.dart';
import 'package:style_sphere/widgets/navigation/menu_drawer.dart';
import 'package:style_sphere/widgets/pagination.dart';
import 'package:style_sphere/widgets/products/products_grid.dart';

final Query products = FirebaseFirestore.instance
    .collection('products')
    .where('category', whereNotIn: ['October'])
    .limit(10);

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
      appBar: const MyAppBar(title: 'Products Page'),
      backgroundColor: AppColors.offWhite,

      drawer: const MenuDrawer(),
      endDrawer: const CartDrawer(),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 4),

            // Search Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products',
                  focusColor: AppColors.primary,
                  hintStyle: const TextStyle(
                    color: AppColors.label,
                    fontSize: 14,
                  ),
                  suffixIcon: IconButton(
                    icon: Image.asset('assets/icons/search.png', width: 24),
                    onPressed: () {},
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Search result & Filter option
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    '4500 APPAREL',
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
                          color: const Color(0xFFf6f6f6),
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
                                  'assets/icons/grid.svg',
                                  width: 20,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFF999999),
                                    BlendMode.srcIn,
                                  ),
                                )
                              : const Icon(
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
                          color: const Color(0xFFf6f6f6),
                          borderRadius: .circular(50),
                        ),
                        child: const Icon(
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
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                    child: productViewTypeGrid
                        ? const ProductGrid(isGrid: true)
                        : const ProductGrid(isGrid: false),
                  ),

                  const SizedBox(height: 50),

                  const Pagination(),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
