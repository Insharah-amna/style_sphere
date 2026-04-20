import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/models/users.dart';
import 'package:style_sphere/repositories/user_repository.dart';
import 'package:style_sphere/screens/checkout/add_address_screen.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';

class PlaceOrderScreen extends StatelessWidget {
  PlaceOrderScreen({super.key, required this.totalPrice});

  final double totalPrice;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final userRepo = UserRepository();

  void showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user cannot tap outside to dismiss
      builder: (context) {
        return const PaymentSuccessDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Place Order Screen'),
      backgroundColor: AppColors.offWhite,

      body: FutureBuilder<UserModel?>(
        future: userRepo.getUser(userId!),
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
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Place Order
                ElevatedButton(
                  onPressed: () {
                    showPaymentSuccessDialog(context);
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

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const BeveledRectangleBorder(),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close),
              ),
            ),

            const SizedBox(height: 8),

            // Header
            const Text(
              'PAYMENT SUCCESS',
              style: TextStyle(letterSpacing: 3, fontSize: 18),
            ),

            const SizedBox(height: 28),

            // Success icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: const Icon(Icons.check, color: Colors.brown, size: 32),
            ),

            const SizedBox(height: 28),

            // Payment info
            const Text(
              'Your payment was success',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 4),

            const Text(
              'Payment ID 15263541',
              style: TextStyle(fontSize: 14, color: AppColors.label),
            ),

            const SizedBox(height: 16),

            Image.asset('assets/images/decoration_line.png', height: 10),

            const SizedBox(height: 16),

            // Rate your purchase
            const Text('Rate your purchase', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.sentiment_dissatisfied_outlined,
                    color: Color(0xaaA8715A),
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.sentiment_satisfied_outlined,
                    color: Color(0xaaA8715A),
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.sentiment_very_satisfied_outlined,
                    color: Color(0xaaA8715A),
                    size: 30,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsetsGeometry.symmetric(vertical: 10),
                      shape: const BeveledRectangleBorder(),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('SUBMIT'),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsetsGeometry.symmetric(vertical: 10),
                      shape: const BeveledRectangleBorder(),
                    ),
                    child: const Text(
                      'BACK TO HOME',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
