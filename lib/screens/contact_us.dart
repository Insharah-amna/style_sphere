import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/navigation/cart_drawer.dart';
import 'package:style_sphere/widgets/navigation/footer.dart';
import 'package:style_sphere/widgets/navigation/menu_drawer.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Contact Us"),
      backgroundColor: AppColors.offWhite,

      drawer: MenuDrawer(),
      endDrawer: CartDrawer(),

      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    const SizedBox(height: 32),

                    Text(
                      "CONTACT US",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        letterSpacing: 4,
                        fontWeight: .w400,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Image.asset(
                      "assets/images/decoration_line.png",
                      height: 11,
                    ),

                    const SizedBox(height: 50),

                    Column(
                      spacing: 16,
                      children: [
                        Image.asset("assets/icons/message.png", width: 50),

                        Text(
                          "Need an ASAP answer? Contact us via chat, 24/7! For existing furniture orders, please call us.",
                        ),

                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(),
                            backgroundColor: Colors.black,
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 30,
                            ),
                          ),
                          child: Text(
                            "CHAT WITH US",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 60),

                    Column(
                      spacing: 18,
                      children: [
                        Image.asset("assets/icons/inbox.png", width: 50),

                        Text(
                          "You can text us at 800-309-2622 – or click on the “text us” link below on your mobile device. Please allow the system to acknowledge a simple greeting (even “Hi” will do!) before providing your question/order details. Consent is not required for any purchase. Message and data rates may apply. Text messaging may not be available via all carriers.",
                        ),

                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: BeveledRectangleBorder(),
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 30,
                            ),
                          ),
                          child: Text(
                            "TEXT US",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 60),

                    Column(
                      spacing: 16,
                      children: [
                        Image.asset(
                          "assets/icons/twitter_outlined.png",
                          width: 50,
                        ),

                        Text(
                          "To send us a private or direct message, like @Open Fashion on Facebook or follow us on Twitter. We’ll get back to you ASAP. Please include your name, order number, and email address for a faster response!",
                        ),
                      ],
                    ),
                  ],
                ),
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
