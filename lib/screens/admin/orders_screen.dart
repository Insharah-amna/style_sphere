import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/repositories/order_repository.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final OrderRepository orderRepository = OrderRepository();
  late Stream<QuerySnapshot> ordersStream;

  @override
  void initState() {
    super.initState();
    _initializeOrdersStream();
  }

  void _initializeOrdersStream() {
    ordersStream = orderRepository.getUserOrders(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Orders Screen'),
      backgroundColor: AppColors.offWhite,
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            const Text('All Orders', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: ordersStream,
                builder: (context, snapshot) {
                  // Loading state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error state
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  // No orders state
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No orders found'));
                  }

                  // Orders found - display them
                  final orders = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final orderDoc = orders[index];
                      final orderData = orderDoc.data() as Map<String, dynamic>;

                      return Container(
                        decoration: ShapeDecoration(
                          shape: BeveledRectangleBorder(
                            side: const BorderSide(
                              color: AppColors.body,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                        ),
                        padding: const EdgeInsetsGeometry.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 6,
                        ),
                        child: Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          spacing: 2,
                          children: [
                            Text(
                              'Order ID: ${orderDoc.id}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Row(
                              children: [
                                const Text('Status: '),
                                Text(
                                  '${orderData['status']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                            Text('Total: \$${orderData['totalPrice']}'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
