import 'package:flutter/material.dart';
import 'package:style_sphere/models/products.dart';
import 'package:style_sphere/widgets/products/product_card.dart';
import 'package:style_sphere/repositories/product_repository.dart';

class ProductGrid extends StatelessWidget {
  final String? category;
  final int limit;
  final bool isGrid;
  final bool isCollectionCard;
  final int crossAxisCount;
  final double aspectRatio;
  final double spacing;

  const ProductGrid({
    super.key,
    this.category,
    this.limit = 10,
    this.isGrid = true,
    this.isCollectionCard = false,
    this.crossAxisCount = 2,
    this.aspectRatio = 0.55,
    this.spacing = 14,
  });

  @override
  Widget build(BuildContext context) {
    final productRepo = ProductRepository();

    return FutureBuilder<List<Product>>(
      future: productRepo.fetchProducts(category: category, limit: limit),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final products = snapshot.data ?? [];

        if (isGrid) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              childAspectRatio: aspectRatio,
            ),
            itemBuilder: (context, index) {
              return ProductGridCard(
                product: products[index],
                isCollectionCard: isCollectionCard,
              );
            },
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: ProductListCard(product: products[index]),
              );
            },
          );
        }
      },
    );
  }
}
