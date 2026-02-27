import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/dummy_cart.dart';
import 'package:style_sphere/screens/checkout/checkout_screen.dart';

class CartDrawer extends StatefulWidget {
  const CartDrawer({super.key});

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: .infinity,
      backgroundColor: AppColors.offWhite,

      child: SafeArea(
        child: Column(
          children: [
            // CLOSE BUTTON
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/x.svg', width: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Align(
                alignment: .centerLeft,
                child: Text(
                  "CART",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    letterSpacing: 4,
                    color: AppColors.body,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: cartItems.isEmpty
                    ? Column(
                        children: [
                          const SizedBox(height: 300),
                          Center(
                            child: Text(
                              "You have no items in your Shopping Bag.",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.placeholder),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        // shrinkWrap: true,
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

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()),
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
                    cartItems.isEmpty ? "CONTINUE SHOPPING" : "BUY NOW",
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

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.item});

  final CartItems item;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: Row(
        children: [
          Image.asset(widget.item.image, width: 100),

          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .spaceEvenly,
            children: [
              Text(
                widget.item.title.toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                widget.item.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                spacing: 12,
                children: [
                  Icon(
                    Icons.remove_circle_outline,
                    size: 20,
                    color: Colors.grey,
                  ),
                  Text(
                    "${widget.item.quantity}",
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.add_circle_outline, size: 20, color: Colors.grey),
                ],
              ),
              Text(
                "\$${widget.item.price}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
