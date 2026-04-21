import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/models/orders.dart';
import 'package:style_sphere/models/users.dart';
import 'package:style_sphere/repositories/order_repository.dart';
import 'package:style_sphere/repositories/user_repository.dart';
import 'package:style_sphere/screens/checkout/add_address_screen.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/payment_success_dialog.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    super.key,
    required this.userId,
    required this.cartItems,
    required this.totalPrice,
  });

  final String userId;
  final List<CartItemWithProduct> cartItems;
  final double totalPrice;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final userRepo = UserRepository();

  final OrderRepository orderRepository = OrderRepository();

  void showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user cannot tap outside to dismiss
      builder: (context) {
        return const PaymentSuccessDialog();
      },
    );
  }

  Future<void> _placeOrder() async {
    try {
      // Convert each CartItemWithProduct to Map using toMap()
      final Map<String, dynamic> itemsMap = {
        for (var item in widget.cartItems) item.productId: item.toMap(),
      };

      final order = OrdersModel(
        items: itemsMap,
        userId: widget.userId,
        status: 'pending',
        totalPrice: widget.totalPrice,
        createdAt: DateTime.now(),
      );

      await orderRepository.createOrder(order);
      await userRepo.clearCart(widget.userId);

      if (!mounted) return;
      showPaymentSuccessDialog(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to place order: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Place Order Screen'),
      backgroundColor: AppColors.offWhite,

      body: FutureBuilder<UserModel?>(
        future: userRepo.getUser(widget.userId),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // User data loaded
          final user = snapshot.data!;

          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Text(
                  'CHECKOUT',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    letterSpacing: 4,
                    fontWeight: .w400,
                  ),
                ),

                const SizedBox(height: 2),

                Image.asset('assets/images/decoration_line.png', height: 11),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Column(
                    spacing: 36,
                    children: [
                      // Shipping Address
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'SHIPPING ADDRESS',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),

                            const SizedBox(height: 8),

                            Padding(
                              padding: const EdgeInsetsGeometry.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      Text(user.name),
                                      Text(user.phone ?? 'phone'),
                                      Text(
                                        user.address?.formattedAddress ??
                                            'address',
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddAddressScreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.chevron_right_outlined,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Add Shipping Address
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Add shipping address',
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
                                    'assets/icons/add.png',
                                    width: 16,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddAddressScreen(),
                                      ),
                                    );
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
                              'SHIPPING METHOD',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),

                            const SizedBox(height: 12),

                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Pickup at store',
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
                                  icon: const Icon(
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
                              'PAYMENT METHOD',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),

                            const SizedBox(height: 12),

                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Via Cash',
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
                                  icon: const Icon(
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
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        'EST. TOTAL',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      Text(
                        '\$${widget.totalPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Place Order
                ElevatedButton(
                  onPressed: () {
                    _placeOrder();
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
                        'PLACE ORDER',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
