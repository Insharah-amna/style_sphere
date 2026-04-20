import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/models/products.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/navigation/cart_drawer.dart';
import 'package:style_sphere/widgets/navigation/menu_drawer.dart';
import 'package:style_sphere/widgets/products/product_card.dart';

final Query products = FirebaseFirestore.instance
    .collection('products')
    .where('category', whereNotIn: ['October'])
    .limit(4);

// Fetch products once (not live updates)
Future<List<Product>> fetchProducts() async {
  final snapshot = await products.get();

  return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Product(
      name: data['name'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      discount: data['discount'] ?? 0,
      stock: data['stock'] ?? 0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }).toList();
}

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late Product product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product = ModalRoute.of(context)!.settings.arguments as Product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Product Detail Page'),
      backgroundColor: AppColors.offWhite,

      drawer: const MenuDrawer(),

      endDrawer: const CartDrawer(),

      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final newProducts = snapshot.data ?? [];
          return SafeArea(
            child: ListView(
              children: [
                const SizedBox(height: 10),

                // Slider images
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Image.network(
                    product.imageUrl,
                    width: 340,
                    fit: .cover,
                  ),
                ),

                const SizedBox(height: 20),

                // Name and description
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 2,
                    children: [
                      Text(
                        product.name.toUpperCase(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(letterSpacing: 4),
                      ),

                      Text(
                        product.description,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(color: AppColors.label),
                      ),

                      Text(
                        '\$${product.price}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                // Add To Basket button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const BeveledRectangleBorder(),
                    backgroundColor: Colors.black,
                    padding: const EdgeInsetsGeometry.only(
                      left: 16,
                      bottom: 16,
                      right: 24,
                      top: 18,
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Image.asset('assets/icons/add_white.png', width: 22),

                          Text(
                            'ADD TO BASKET',
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: AppColors.offWhite),
                          ),
                        ],
                      ),

                      const IsFavourite(isDarkMode: true),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Materials & Care
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 18),
                  child: Expanded(
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'Materials',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(letterSpacing: 3),
                        ),
                        Text(
                          'We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products. ',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppColors.label),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'CARE',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(letterSpacing: 3),
                        ),
                        Text(
                          'We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products. ',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppColors.label),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                Text(
                  'YOU MAY ALSO LIKE',
                  textAlign: .center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    letterSpacing: 4,
                    fontWeight: .w400,
                  ),
                ),

                const SizedBox(height: 8),

                Image.asset('assets/images/decoration_line.png', height: 11),

                const SizedBox(height: 22),

                // Products
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.55,
                          ),
                      itemBuilder: (context, index) {
                        final product = newProducts[index];
                        return ProductGridCard(product: product);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}
