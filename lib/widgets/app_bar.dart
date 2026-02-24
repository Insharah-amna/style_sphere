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
      elevation: 0,
      centerTitle: true,

      title: Image.asset("assets/images/logo.png", height: 32,),

      leading: IconButton(
        icon: Image.asset("assets/icons/menu.png", width: 24,),
        onPressed: () {
          Scaffold.of(context).openDrawer();
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