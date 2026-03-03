import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/app_routes.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: AppColors.offWhite,

      child: Column(
        children: [
          const Spacer(),

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
          const SizedBox(height: 30),

          Image.asset(
            "assets/images/decoration_line.png",
            height: 10,
            fit: .cover,
          ),
          const SizedBox(height: 22),

          Row(
            spacing: 52,
            mainAxisAlignment: .center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.about);
                },
                child: Text("About", style: TextStyle(color: Colors.black)),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.contact);
                },
                child: Text("Contact", style: TextStyle(color: Colors.black)),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.blog);
                },
                child: Text("Blog", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            alignment: .center,
            height: 48,
            width: .infinity,
            decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
            child: Text(
              "Copyright© OpenUI All Rights Reserved.",
              textAlign: .center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
