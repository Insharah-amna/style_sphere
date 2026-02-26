import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/products.dart';
import 'package:style_sphere/screens/collection_screen.dart';
import 'package:style_sphere/screens/products_page.dart';
import 'package:style_sphere/widgets/app_bar.dart';
import 'package:style_sphere/widgets/cart_drawer.dart';
import 'package:style_sphere/widgets/footer.dart';
import 'package:style_sphere/widgets/homepage_card.dart';
import 'package:style_sphere/widgets/homepage_slider.dart';
import 'package:style_sphere/widgets/menu_drawer.dart';
import 'package:style_sphere/widgets/product_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'HomePage'),
      backgroundColor: AppColors.offWhite,

      drawer: const MenuDrawer(),

      endDrawer: const CartDrawer(),

      body: SafeArea(
        child: ListView(
          children: [
            HomepageSlider(),

            const SizedBox(height: 40),

            // New Arrivals
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Text(
                    "NEW ARRIVAL",
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(letterSpacing: 5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),

                  Image.asset("assets/images/decoration_line.png", height: 11),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: .center,
                    spacing: 26,
                    children: [
                      Text("All", style: TextStyle(fontSize: 16)),
                      Text(
                        "Apparel",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Dress",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "T shirt",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Bag",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: newProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final product = newProducts[index];
                      return HomepageCard(product: product);
                    },
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductsPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: BeveledRectangleBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: .center,
                      spacing: 6,
                      children: [
                        Text(
                          "Explore More",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Brands
            Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              spacing: 40,
              children: [
                Image.asset("assets/images/decoration_line.png", height: 10),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset("assets/images/prada.png", width: 70),
                    const SizedBox(width: 41),
                    Image.asset("assets/images/burberry.png", width: 100),
                    const SizedBox(width: 46),
                    Image.asset("assets/images/hugo_boss.png", width: 50),
                  ],
                ),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset("assets/images/cartier.png", width: 72),
                    const SizedBox(width: 44),
                    Image.asset("assets/images/gucci.png", width: 93),
                    const SizedBox(width: 20),
                    Image.asset("assets/images/tiffany.png", width: 98),
                  ],
                ),

                Image.asset("assets/images/decoration_line.png", height: 10),
              ],
            ),

            const SizedBox(height: 60),

            // October collection
            Text(
              "COLLECTIONS",
              textAlign: .center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                letterSpacing: 4,
                fontWeight: .w400,
              ),
            ),

            const SizedBox(height: 26),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CollectionScreen()),
                );
              },
              child: Image.asset(
                "assets/images/homepage2.png",
                width: .infinity,
                fit: .cover,
              ),
            ),

            const SizedBox(height: 40),

            // Autumn collection
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CollectionScreen()),
                );
              },
              child: Container(
                height: 296,
                margin: EdgeInsetsGeometry.symmetric(horizontal: 58),
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 22,
                  vertical: 36,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/homepage3.png"),
                    fit: .cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: .end,
                  children: [
                    Text(
                      "Autumn",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Color(0xBB111111),
                      ),
                    ),
                    Text(
                      "   COLLECTION",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(letterSpacing: 4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // video
            Image.asset(
              "assets/images/homepage4.png",
              width: .infinity,
              fit: .cover,
            ),

            const SizedBox(height: 70),

            Text(
              "JUST FOR YOU",
              textAlign: .center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(letterSpacing: 4),
            ),

            const SizedBox(height: 16),

            Image.asset("assets/images/decoration_line.png", height: 11),

            const SizedBox(height: 24),

            // Just for you collection
            ProductSlider(),

            const SizedBox(height: 56),

            // Open Fashion
            Container(
              height: 525,
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 28,
                horizontal: 18,
              ),
              decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png", width: 98, fit: .cover),
                  const SizedBox(height: 16),

                  Text(
                    "Making a luxurious lifestyle accessible\nfor a generous group of women is our\ndaily drive.",
                    textAlign: .center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: AppColors.label),
                  ),
                  const SizedBox(height: 16),

                  Image.asset("assets/images/decoration_line.png", height: 11),
                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            FeatureItem(
                              imagePath: "assets/images/decor1.png",
                              text: "Fast shipping. Free on orders over \$25.",
                            ),
                            SizedBox(height: 20),
                            FeatureItem(
                              imagePath: "assets/images/decor3.png",
                              text:
                                  "Unique designs and high-quality materials.",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 34),
                      Expanded(
                        child: Column(
                          children: const [
                            FeatureItem(
                              imagePath: "assets/images/decor2.png",
                              text: "Sustainable process from start to finish.",
                            ),
                            SizedBox(height: 20),
                            FeatureItem(
                              imagePath: "assets/images/decor4.png",
                              text: "Fast shipping.\nFree on orders over \$25.",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 34),

                  Center(
                    child: Image.asset(
                      "assets/images/decor5.png",
                      width: 67,
                      fit: .cover,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 46),

            Text(
              "FOLLOW US",
              textAlign: .center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(letterSpacing: 4),
            ),
            const SizedBox(height: 14),

            ImageIcon(
              AssetImage("assets/images/instagram_filled.png"),
              size: 24,
            ),
            const SizedBox(height: 20),

            // Instagram links
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 16,
                      children: const [
                        FollowCard(
                          imagePath: "assets/images/account1.png",
                          accName: "mia",
                        ),
                        FollowCard(
                          imagePath: "assets/images/account2.png",
                          accName: "_jihyn",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 16,
                      children: const [
                        FollowCard(
                          imagePath: "assets/images/account3.png",
                          accName: "amna",
                        ),
                        FollowCard(
                          imagePath: "assets/images/account4.png",
                          accName: "masha",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String imagePath;
  final String text;

  const FeatureItem({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath, width: 50, fit: BoxFit.cover),
        const SizedBox(height: 12),
        Text(text, textAlign: TextAlign.center),
      ],
    );
  }
}

class FollowCard extends StatelessWidget {
  final String imagePath;
  final String accName;

  const FollowCard({super.key, required this.imagePath, required this.accName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      padding: EdgeInsetsGeometry.all(12),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: .cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Align(
        alignment: .bottomLeft,
        child: Text("@$accName", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
