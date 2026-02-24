import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/blogs.dart';
import 'package:style_sphere/widgets/app_bar.dart';
import 'package:style_sphere/widgets/cart_drawer.dart';
import 'package:style_sphere/widgets/footer.dart';
import 'package:style_sphere/widgets/menu_drawer.dart';

class BlogDetailPage extends StatelessWidget {
  const BlogDetailPage({
    super.key,
    required this.blog
  });

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Blog Detail"),
      backgroundColor: AppColors.offWhite,

      drawer: const MenuDrawer(),

      endDrawer: const CartDrawer(),

      body: SafeArea(
        child: ListView(
          children: [
            Image.asset(blog.image, width: .infinity, fit: .cover,),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  Align(
                    alignment: .centerLeft,
                    child: Text(
                      blog.title,
                      style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(fontWeight: .w400),
                    )
                  ),

                  const SizedBox(height: 10),
                  Text(blog.description),

                  const SizedBox(height: 30),
                  Image.asset(blog.image),

                  const SizedBox(height: 30),
                  Text(blog.description),

                  const SizedBox(height: 40),
                  Align(
                    alignment: .centerLeft,
                    child:
                      Text(
                        "Posted By OpenFashion | ${blog.timeStamp}",
                        style: Theme.of(context).textTheme.titleSmall
                      ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
