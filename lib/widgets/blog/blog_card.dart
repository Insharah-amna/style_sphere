import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/blogs.dart';
import 'package:style_sphere/screens/blog_detail_page.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({super.key, required this.blog});

  final Blog blog;

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlogDetailPage(blog: widget.blog,)),
        );
      },
      child: Row(
        key: ValueKey(widget.blog.id),
        spacing: 12,
        children: [
          Image.asset(widget.blog.image, width: 120, fit: .cover,),

          Expanded(
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              spacing: 6,
              children: [
                Text(
                  widget.blog.title.toUpperCase(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  widget.blog.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                    .textTheme.titleSmall!
                    .copyWith(
                      color: AppColors.label,
                      height: 1.6
                  ),
                ),
                Text(
                  widget.blog.timeStamp,
                  style: Theme.of(context)
                    .textTheme.bodySmall!
                    .copyWith(color: AppColors.placeholder),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
