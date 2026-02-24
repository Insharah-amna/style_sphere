import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/blogs.dart';
import 'package:style_sphere/widgets/app_bar.dart';
import 'package:style_sphere/widgets/blog_card.dart';
import 'package:style_sphere/widgets/footer.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'BlogPage'),
      backgroundColor: AppColors.offWhite,

        body: SafeArea(
          child: CustomScrollView(
            slivers: [

              /// HEADER
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    Text(
                      "BLOG",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!
                          .copyWith(letterSpacing: 4, fontWeight: FontWeight.w400),
                    ),

                    const SizedBox(height: 2),

                    Image.asset(
                      "assets/images/decoration_line.png",
                      height: 11,
                    ),

                    const SizedBox(height: 26),

                    SearchBullets(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              /// BLOG LIST
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final blog = blogs[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: BlogCard(blog: blog),
                    );
                  },
                  childCount: blogs.length,
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70, top: 35, bottom: 25),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                      elevation: 0,
                      side: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      shape: BeveledRectangleBorder(),
                      backgroundColor: AppColors.offWhite,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "LOAD MORE",
                          style: Theme.of(context).textTheme.titleLarge!
                          .copyWith(fontWeight: .w400)
                        ),
                        SizedBox(width: 18),
                        Image.asset("assets/icons/add.png", width: 18,)
                      ],
                    ),
                  ),
                ),
              ),

              /// FOOTER
              SliverToBoxAdapter(
                child: const Footer(),
              ),
            ],
          ),
        )
    );
  }
}

class SearchBullets extends StatelessWidget {
  var bullets = ['Fashion', 'Promo', 'LookBook'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: bullets.map((tag) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: .circular(.25)
            ),
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 8),
            child: Text(tag),
          ),
        );
      }).toList(),
    );
  }
}
