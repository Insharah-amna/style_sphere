import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool lightMode;

  const MyAppBar({super.key, required this.title, this.lightMode = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: lightMode ? AppColors.offWhite : AppColors.darkMode,
      elevation: 0,
      centerTitle: true,

      title: Image.asset(
        lightMode ? "assets/images/logo.png" : "assets/icons/logo_light.png",
        height: 32,
      ),

      leading: IconButton(
        icon: Image.asset(
          lightMode ? "assets/icons/menu.png" : "assets/icons/menu_light.png",
          width: 24,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),

      actions: [
        // IconButton(
        //   icon: Image.asset(
        //     lightMode
        //         ? "assets/icons/search.png"
        //         : "assets/icons/search_light.png",
        //     width: 24,
        //   ),
        //   onPressed: () {},
        // ),
        IconButton(
          icon: Image.asset(
            lightMode
                ? "assets/icons/shopping_bag.png"
                : "assets/icons/cart_light.png",
            width: 24,
          ),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
