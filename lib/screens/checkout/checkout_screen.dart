import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/dummy_cart.dart';
import 'package:style_sphere/screens/checkout/place_order_screen.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/navigation/cart_drawer.dart';
import 'package:style_sphere/widgets/navigation/menu_drawer.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: MyAppBar(title: 'Checkout Screen'),
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

            // Cart Items
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    return Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 16),
                      child: CartItem(item: item),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 6),

            // Delivery Option
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Column(
                spacing: 8,
                children: [
                  const Divider(),

                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: Row(
                          spacing: 10,
                          children: [
                            Image.asset("assets/icons/delivery.png", width: 24),
                            Text(
                              "Delivery",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      Text(
                        "Free",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.label,
                        ),
                      ),
                    ],
                  ),

                  const Divider(),
                  const SizedBox(height: 6),

                  // Total Price
                  Row(
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
                ],
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlaceOrderScreen(totalPrice: totalPrice),
                  ),
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
                    "CHECKOUT",
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
