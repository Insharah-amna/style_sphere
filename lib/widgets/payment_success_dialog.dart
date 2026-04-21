import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/app_routes.dart';

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
                      Navigator.pushNamed(context, AppRoutes.home);
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
