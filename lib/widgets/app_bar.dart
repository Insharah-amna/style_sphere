import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCart;
  final bool showSearch;

  const MyAppBar({
    super.key,
    required this.title,
    this.showCart = true,
    this.showSearch = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.offWhite,

      title: Image.asset("assets/images/logo.png", height: 32,),

      elevation: 0,
      centerTitle: true,

      leading: IconButton(
        icon: Image.asset("assets/icons/menu.png", width: 24,),
        onPressed: () {
          // open drawer
        },
      ),

      actions: [
        if (showSearch)
          IconButton(
            icon: Image.asset("assets/icons/search.png", width: 24,),
            onPressed: () {},
          ),
        if (showCart)
          IconButton(
            icon: Image.asset("assets/icons/shopping_bag.png", width: 24,),
            onPressed: () {},
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}