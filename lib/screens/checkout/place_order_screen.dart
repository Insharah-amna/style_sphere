import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/screens/checkout/add_address_screen.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/navigation/cart_drawer.dart';
import 'package:style_sphere/widgets/navigation/menu_drawer.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Place Order Screen'),
      backgroundColor: AppColors.offWhite,

      drawer: const MenuDrawer(),
      endDrawer: const CartDrawer(),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              "CHECKOUT",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                letterSpacing: 4,
                fontWeight: .w400,
              ),
            ),

            const SizedBox(height: 2),

            Image.asset("assets/images/decoration_line.png", height: 11),

            const SizedBox(height: 16),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Column(
                spacing: 36,
                children: [
                  // Shipping Address
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "SHIPPING ADDRESS",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),

                        const SizedBox(height: 8),

                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text("Name"),
                                  Text("Address"),
                                  Text("Number"),
                                ],
                              ),
                              Icon(Icons.chevron_right_outlined, size: 24),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Add Shipping Address
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Add shipping address",

                            filled: true,
                            fillColor: AppColors.inputBg,

                            // light grey background
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none, // removes border
                            ),

                            suffixIcon: IconButton(
                              icon: Image.asset(
                                "assets/icons/add.png",
                                width: 16,
                              ),
                              onPressed: () {
                                // action here
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Shipping Method
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "SHIPPING METHOD",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),

                        const SizedBox(height: 12),

                        TextField(
                          decoration: InputDecoration(
                            hintText: "Pickup at store",

                            filled: true,
                            fillColor: AppColors.inputBg,

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 24,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Payment Method
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "PAYMENT METHOD",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),

                        const SizedBox(height: 12),

                        TextField(
                          decoration: InputDecoration(
                            hintText: "Select payment method",

                            filled: true,
                            fillColor: AppColors.inputBg,

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 24,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Total Price
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "EST. TOTAL",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Place Order
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAddressScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                shape: BeveledRectangleBorder(),
              ),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Image.asset("assets/icons/cart.png", width: 24),
                  const SizedBox(width: 24),
                  Text(
                    "PLACE ORDER",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
