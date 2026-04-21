import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/repositories/user_repository.dart';
import 'package:style_sphere/screens/checkout/place_order_screen.dart';

class CartDrawer extends StatefulWidget {
  const CartDrawer({super.key});

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    // if (userId == null) return const LoginRedirect();

    final userRepo = UserRepository();

    return StreamBuilder<List<CartItemWithProduct>>(
      stream: userRepo.watchCart(userId!), // Stream, not Future
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Data received
        final cartItems = snapshot.data ?? [];

        // Calculate total
        double total = 0;
        for (var item in cartItems) {
          total += item.subtotal;
        }

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
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Align(
                    alignment: .centerLeft,
                    child: Text(
                      'CART',
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
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                    child: cartItems.isEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 300),
                              Center(
                                child: Text(
                                  'You have no items in your Shopping Bag.',
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(color: AppColors.placeholder),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];

                              return Padding(
                                padding: const EdgeInsetsGeometry.only(
                                  bottom: 16,
                                ),
                                child: CartItemList(item: item),
                              );
                            },
                          ),
                  ),
                ),

                const SizedBox(height: 12),

                if (cartItems.isNotEmpty)
                  // Delivery Option
                  Padding(
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
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
                                  Image.asset(
                                    'assets/icons/delivery.png',
                                    width: 24,
                                  ),
                                  Text(
                                    'Delivery',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              'Free',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: AppColors.label),
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
                              'EST. TOTAL',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),

                            Text(
                              '\$${total.toStringAsFixed(2)}',
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
                        builder: (context) => PlaceOrderScreen(
                          userId: userId,
                          totalPrice: total,
                          cartItems: cartItems,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
                    shape: const BeveledRectangleBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Image.asset('assets/icons/cart.png', width: 24),
                      const SizedBox(width: 24),
                      Text(
                        cartItems.isEmpty ? 'CONTINUE SHOPPING' : 'BUY NOW',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CartItemList extends StatefulWidget {
  const CartItemList({super.key, required this.item});

  final CartItemWithProduct item;

  @override
  State<CartItemList> createState() => _CartItemState();
}

class _CartItemState extends State<CartItemList> {
  // On increment button click
  void _increaseQuantity(String productId, int currentQuantity) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final userRepo = UserRepository();
    await userRepo.updateQuantity(userId, productId, currentQuantity + 1);
  }

  // On decrement button click
  void _decreaseQuantity(String productId, int currentQuantity) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final userRepo = UserRepository();
    await userRepo.updateQuantity(userId, productId, currentQuantity - 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: Row(
        children: [
          Image.network(widget.item.productImage, width: 100),

          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .spaceEvenly,
            children: [
              Text(
                widget.item.productName.toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                widget.item.productDesc,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _decreaseQuantity(
                      widget.item.productId,
                      widget.item.quantity,
                    ),
                    icon: const Icon(Icons.remove_circle_outline),
                    iconSize: 18,
                    color: Colors.grey,
                  ),
                  Text(
                    '${widget.item.quantity}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () => _increaseQuantity(
                      widget.item.productId,
                      widget.item.quantity,
                    ),
                    icon: const Icon(Icons.add_circle_outline),
                    iconSize: 18,
                    color: Colors.grey,
                  ),
                ],
              ),
              Text(
                '\$${widget.item.productPrice}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
