import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/app_routes.dart';
import 'package:style_sphere/models/users.dart';
import 'package:style_sphere/repositories/user_repository.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';
import 'package:style_sphere/widgets/navigation/cart_drawer.dart';
import 'package:style_sphere/widgets/navigation/footer.dart';
import 'package:style_sphere/widgets/navigation/menu_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final UserRepository userRepo = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Profile Page'),
      backgroundColor: AppColors.offWhite,
      drawer: const MenuDrawer(),
      endDrawer: const CartDrawer(),

      body: FutureBuilder<UserModel?>(
        future: userRepo.getUser(userId),
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

          return Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .start,
              children: [
                const SizedBox(height: 22),

                Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  spacing: 2,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 18, fontWeight: .w400),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(color: AppColors.body),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),

                const Text(
                  'My Orders',
                  textAlign: .start,
                  style: TextStyle(fontSize: 18, fontWeight: .w400),
                ),
                const SizedBox(height: 28),

                const Row(
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Column(
                      spacing: 3,
                      children: [
                        Icon(
                          Icons.wallet,
                          color: AppColors.secondary,
                          size: 28,
                        ),
                        Text('To Pay', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      spacing: 3,
                      children: [
                        Icon(
                          Icons.all_inbox_rounded,
                          color: AppColors.secondary,
                          size: 28,
                        ),
                        Text('To Ship', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      spacing: 3,
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: AppColors.secondary,
                          size: 28,
                        ),
                        Text('To Receive', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      spacing: 3,
                      children: [
                        Icon(
                          Icons.cancel_rounded,
                          color: AppColors.secondary,
                          size: 26,
                        ),
                        Text('Cancelled', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // View all orders
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.viewOrders);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.offWhite,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All Orders',
                          style: TextStyle(
                            fontWeight: .w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.arrow_forward_sharp, color: Colors.black),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                const Footer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
