import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/app_routes.dart';
import 'package:style_sphere/models/products.dart';

final Query products = FirebaseFirestore.instance
    .collection('products')
    .where('category', isEqualTo: 'Special')
    .limit(4);

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

class ProductGridScreen extends StatelessWidget {
  const ProductGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 580,
      child: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final newProducts = snapshot.data ?? [];

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: newProducts.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 4,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              final product = newProducts[index];
              return HomepageCard(product: product);
            },
          );
        },
      ),
    );
  }
}

// Card widget for each product
class HomepageCard extends StatelessWidget {
  const HomepageCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.productsDetail,
          arguments: product,
        );
      },
      child: Column(
        spacing: 4,
        children: [
          Image.network(product.imageUrl, height: 230, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              spacing: 2,
              children: [
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
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
