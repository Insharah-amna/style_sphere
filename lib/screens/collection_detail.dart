import 'package:flutter/material.dart';
import 'package:style_sphere/widgets/app_bar.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/widgets/cart_drawer.dart';
import 'package:style_sphere/widgets/menu_drawer.dart';
import 'package:style_sphere/constants/collection.dart';
import 'package:style_sphere/widgets/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:style_sphere/widgets/footer.dart';

class CollectionDetail extends StatelessWidget {
  const CollectionDetail({super.key, required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Collection Detail Page', lightMode: false),
      backgroundColor: AppColors.darkMode,

      drawer: const MenuDrawer(),
      endDrawer: const CartDrawer(),

      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 22),

            // 10 - October Collection
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "10",
                  style: TextStyle(
                    fontSize: 140,
                    color: Color(0x66343434),
                    height: 1,
                    fontStyle: .italic,
                    fontFamily: 'BodoniModa',
                    letterSpacing: -20,
                  ),
                ),

                Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "October",
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 42,
                        fontWeight: .bold,
                        fontFamily: 'BodoniModa',
                        color: AppColors.offWhite,
                        letterSpacing: 2,
                      ),
                    ),

                    Text(
                      "COLLECTION",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.offWhite,
                        letterSpacing: 6,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Collection Image
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Image.asset(collection.image, fit: .cover),

                  const SizedBox(height: 38),

                  // Collection Products
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: collectionProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.55,
                        ),
                    itemBuilder: (context, index) {
                      final collectionProduct = collectionProducts[index];
                      return ProductGridCard(
                        product: collectionProduct,
                        isCollectionCard: true,
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // You may also like
                  Text(
                    "YOU MAY ALSO LIKE",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 4,
                      color: AppColors.offWhite,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Image.asset(
                    "assets/images/decoration_line_light.png",
                    height: 11,
                  ),

                  const SizedBox(height: 24),

                  CollectionSlider(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class CollectionSlider extends StatefulWidget {
  const CollectionSlider({super.key});

  @override
  State<CollectionSlider> createState() => _CollectionSliderState();
}

class _CollectionSliderState extends State<CollectionSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 440,
        viewportFraction: 0.8,
        enableInfiniteScroll: false,
      ),
      items: collections.map((collection) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CollectionDetail(collection: collection),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              spacing: 3,
              children: [
                Image.asset(collection.image),
                const SizedBox(height: 2),

                Align(
                  alignment: .bottomLeft,
                  child: Text(
                    collection.collectionName,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontFamily: 'TenorSans',
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
