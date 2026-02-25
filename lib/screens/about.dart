import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/widgets/app_bar.dart';
import 'package:style_sphere/widgets/cart_drawer.dart';
import 'package:style_sphere/widgets/menu_drawer.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "About Us"),
      backgroundColor: AppColors.offWhite,

      drawer: MenuDrawer(),
      endDrawer: CartDrawer(),

      body: SafeArea(
        child: ListView(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const SizedBox(height: 32),

                  Text(
                    "OUR STORY",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      letterSpacing: 4,
                      fontWeight: .w400,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Image.asset("assets/images/decoration_line.png", height: 11),

                  const SizedBox(height: 25),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
                    child: Column(
                      spacing: 16,
                      children: [
                        Text(
                          "Open Fashion - Free Ecommerce UI Kit is a free download UI kit. You can open Open Fashion - "
                          "Free Ecommerce UI Kit file by Figma.\n\n"
                          "Create stunning shop with bulletproof guidelines and thoughtful components. "
                          "Its library contains more than 50+ components supporting Light & Dark Mode and 60+ ready to use mobile screens.",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  Image.asset("assets/images/about.png", width: .infinity),

                  const SizedBox(height: 50),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        Text(
                          "SIGN UP",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(letterSpacing: 4, fontWeight: .w400),
                        ),

                        const SizedBox(height: 4),

                        Image.asset(
                          "assets/images/decoration_line.png",
                          height: 11,
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Receive early access to new arrivals, sales,\nexclusive content, events and much more!",
                          textAlign: .center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),

                        const SizedBox(height: 15),

                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email address",
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF979797),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF979797),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF979797),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 34),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.black,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 100,
                  vertical: 14,
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "SUBMIT",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 24),
                  Image.asset("assets/icons/right_arrow.png", width: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
