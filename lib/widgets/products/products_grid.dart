import 'package:flutter/material.dart';
import 'package:style_sphere/models/products.dart';
import 'package:style_sphere/widgets/products/product_card.dart';
import 'package:style_sphere/repositories/product_repository.dart';

class ProductGrid extends StatefulWidget {
  final String? category;
  final int limit;
  final bool isGrid;
  final bool isCollectionCard;
  final int crossAxisCount;
  final double aspectRatio;
  final double spacing;
  final String searchQuery;

  const ProductGrid({
    super.key,
    this.category,
    this.limit = 10,
    this.isGrid = true,
    this.isCollectionCard = false,
    this.crossAxisCount = 2,
    this.aspectRatio = 0.55,
    this.spacing = 14,
    this.searchQuery = '',
  });

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final productRepo = ProductRepository();

    List<Product> filterProducts(List<Product> products, String query) {
      if (query.isEmpty) return products;

      return products.where((product) {
        final nameMatch = product.name.toLowerCase().contains(
          query.toLowerCase(),
        );

        final descriptionMatch = product.description.toLowerCase().contains(
          query.toLowerCase(),
        );

        final categoryMatch = product.category.toLowerCase().contains(
          query.toLowerCase(),
        );

        return nameMatch || descriptionMatch || categoryMatch;
      }).toList();
    }

    return FutureBuilder<List<Product>>(
      future: productRepo.fetchProducts(
        category: widget.category,
        limit: widget.limit,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // if (snapshot.hasError) {
        //   return Center(child: Text('Error: ${snapshot.error}'));
        // }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  snapshot.error.toString().contains('internet')
                      ? 'No internet connection'
                      : 'Something went wrong',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                // Retry button
                TextButton(
                  onPressed: () => setState(() {}),
                  // rebuilds widget, retries Future
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final products = snapshot.data ?? [];

        // Filter products based on search query
        final filteredProducts = filterProducts(products, widget.searchQuery);

        // Show no results message
        if (filteredProducts.isEmpty && widget.searchQuery.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'No products found for "${widget.searchQuery}"',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        if (widget.isGrid) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: widget.spacing,
              crossAxisSpacing: widget.spacing,
              childAspectRatio: widget.aspectRatio,
            ),
            itemBuilder: (context, index) {
              return ProductGridCard(
                product: filteredProducts[index],
                isCollectionCard: widget.isCollectionCard,
              );
            },
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: widget.spacing),
                child: ProductListCard(product: filteredProducts[index]),
              );
            },
          );
        }
      },
    );
  }
}
