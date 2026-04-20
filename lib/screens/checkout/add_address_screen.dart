import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/models/users.dart';
import 'package:style_sphere/repositories/user_repository.dart';
import 'package:style_sphere/widgets/navigation/app_bar.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final UserRepository _userRepository = UserRepository();
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _addressLineController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _updateUserAddress() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check if user is logged in
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      _showMsg('Please login to add address');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Get current user data
      final currentUser = await _userRepository.getUser(userId);

      if (currentUser == null) {
        throw Exception('User not found');
      }

      // Create address object
      final address = Address(
        street: _addressLineController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
      );

      // Prepare updates
      final updates = <String, dynamic>{
        'phone': _phoneController.text.trim(),
        'address': address.toMap(),
      };

      // Update user in Firestore
      await _userRepository.updateUser(userId, updates);

      if (mounted) {
        _showMsg('Address saved successfully!');

        // Wait a moment to show success message, then go back
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          Navigator.pop(context, true); // Return true to indicate success
        }
      }
    } catch (e) {
      if (mounted) {
        _showMsg('Failed to save address: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _showMsg(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Add Shipping Address'),
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              'ADD SHIPPING ADDRESS',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                letterSpacing: 4,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 2),

            Image.asset('assets/images/decoration_line.png', height: 11),

            const SizedBox(height: 16),

            // Address Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Phone Number Field
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone number',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.trim().length < 10) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Address Line
                      TextFormField(
                        controller: _addressLineController,
                        decoration: const InputDecoration(
                          labelText: 'Street address',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // City
                      TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(labelText: 'City'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Country
                      TextFormField(
                        controller: _countryController,
                        decoration: const InputDecoration(labelText: 'Country'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your country';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Add New Address Button
            ElevatedButton(
              onPressed: _isSaving ? null : _updateUserAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
                shape: const BeveledRectangleBorder(),
              ),
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'ADD NOW',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
