import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sphere/constants/app_colors.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: .infinity,
      backgroundColor: AppColors.offWhite,

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // CLOSE BUTTON
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/x.svg', width: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 16),

              // TOP TABS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_tab("WOMEN", 0), _tab("MEN", 1), _tab("KIDS", 2)],
              ),

              const SizedBox(height: 16),

              // MENU ITEMS
              Expanded(
                child: ListView(
                  children: const [
                    DrawerItem(title: "New"),
                    DrawerItem(title: "Apparel"),
                    DrawerItem(title: "Bag"),
                    DrawerItem(title: "Shoes"),
                    DrawerItem(title: "Beauty"),
                    DrawerItem(title: "Accessories"),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // CONTACT SECTION
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icons/call.png", width: 24),
                      SizedBox(width: 16),
                      Text(
                        "(786) 713-8616",
                        style: TextStyle(fontSize: 16, color: AppColors.label),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  Row(
                    children: [
                      Image.asset("assets/icons/location.png", width: 24),
                      SizedBox(width: 16),
                      Text(
                        "Store Locator",
                        style: TextStyle(fontSize: 16, color: AppColors.label),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Image.asset(
                "assets/images/decoration_line.png",
                height: 11,
                fit: .cover,
              ),
              const SizedBox(height: 36),

              // SOCIAL MEDIA LINKS
              Row(
                spacing: 50,
                mainAxisAlignment: .center,
                children: [
                  Image.asset(
                    "assets/images/twitter_filled.png",
                    height: 21,
                    fit: .cover,
                  ),
                  Image.asset(
                    "assets/images/instagram_filled.png",
                    height: 21,
                    fit: .cover,
                  ),
                  Image.asset(
                    "assets/images/youtube_filled.png",
                    height: 21,
                    fit: .cover,
                  ),
                ],
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab(String title, int index) {
    bool isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
            child: Text(
              title,
              style: TextStyle(
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.black : AppColors.placeholder,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // active indicator
          if (isSelected)
            Container(height: 1, width: 60, color: AppColors.secondary),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      tilePadding: EdgeInsets.zero,
      children: const [
        Column(
          children: [
            ListTile(title: Text("Outer")),
            ListTile(title: Text("Dress")),
            ListTile(title: Text("T-shirt")),
            ListTile(title: Text("Knitwear")),
            ListTile(title: Text("Pants")),
            ListTile(title: Text("Denim")),
          ],
        ),
      ],
    );
  }
}
