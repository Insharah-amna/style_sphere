import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/models/products.dart';
import 'package:style_sphere/repositories/user_repository.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/navigation/cart_drawer.dart';
import 'package:style_sphere/widgets/navigation/menu_drawer.dart';
import 'package:style_sphere/widgets/products/product_card.dart';
import 'package:style_sphere/widgets/products/products_grid.dart';

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

  Future<void> _addToCart(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      // Show login dialog or navigate to login
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please login first')));
      return;
    }

    final userRepo = UserRepository();

    try {
      await userRepo.addToCart(userId, product.id, 1);

      // ✅ Always check if widget is still mounted before using context
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.name} added to cart')),
        );
      }
    } catch (e) {
      // ✅ Check mounted before showing error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Product Detail Page'),
      backgroundColor: AppColors.offWhite,

      drawer: const MenuDrawer(),

      endDrawer: const CartDrawer(),

      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // Slider images
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Image.network(product.imageUrl, width: 340, fit: .cover),
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
              onPressed: () => _addToCart(context),
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.offWhite,
                        ),
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
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.label),
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
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.label),
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

            // Products Grid View
            const Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: ProductGrid(limit: 4, aspectRatio: 0.53, spacing: 18),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
