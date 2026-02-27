import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/collection.dart';
import 'package:style_sphere/screens/collection_detail.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/navigation/cart_drawer.dart';
import 'package:style_sphere/widgets/navigation/footer.dart';
import 'package:style_sphere/widgets/navigation/menu_drawer.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Collection Screen', lightMode: false),
      backgroundColor: AppColors.darkMode,

      drawer: const MenuDrawer(),
      endDrawer: const CartDrawer(),

      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 22),

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

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final collection = collections[index];
                return Padding(
                  padding: EdgeInsetsGeometry.only(bottom: 50),
                  child: CollectionCard(collection: collection),
                );
              },
            ),

            const SizedBox(height: 24),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class CollectionCard extends StatefulWidget {
  const CollectionCard({super.key, required this.collection});

  final Collection collection;

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CollectionDetail(collection: widget.collection),
          ),
        );
      },
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: AppColors.darkMode),

        child: Column(
          children: [
            Image.asset(widget.collection.image, fit: .cover, width: .infinity),

            const SizedBox(height: 12),

            Row(
              spacing: 8,
              mainAxisAlignment: .center,
              children: [
                Text(
                  widget.collection.number.toString().padLeft(2, '0'),
                  style: Theme.of(context).textTheme.displaySmall,
                ),

                Expanded(
                  child: Container(height: 2, color: const Color(0xFF717171)),
                ),

                Text(
                  widget.collection.collectionName,
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 2,
                    color: AppColors.offWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
