import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/app_routes.dart';
import 'package:style_sphere/models/products.dart';

Future<List<Product>> fetchProducts() async {
  final Query products = FirebaseFirestore.instance
      .collection('products')
      .where('category', isEqualTo: 'Special')
      .limit(4);

  final snapshot = await products.get();

  return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    final id = data['id'] ?? doc.id;

    return Product(
      id: id,
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

class ProductSlider extends StatefulWidget {
  const ProductSlider({super.key});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  var _currentIndex = 0;
  List<Product>? _cachedProducts;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await fetchProducts();
      setState(() {
        _cachedProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    final specialProducts = _cachedProducts ?? [];

    if (specialProducts.isEmpty) {
      return const Center(child: Text('No special products available'));
    }

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 450,
            viewportFraction: 0.75,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: specialProducts.map((product) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.productsDetail,
                  arguments: product,
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  spacing: 3,
                  children: [
                    CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      height: 385,
                      width: 260,
                      fit: .cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),

                    const SizedBox(height: 2),

                    Text(product.name),

                    Text(
                      '\$${product.price}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: specialProducts.asMap().entries.map((entry) {
            return Transform.rotate(
              angle: 0.785,
              child: Container(
                width: 6.0,
                height: 6.0,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: _currentIndex != entry.key
                      ? Border.all(width: 1, color: Colors.grey)
                      : const .fromBorderSide(.none),
                  color: _currentIndex != entry.key
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
