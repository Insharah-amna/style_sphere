import 'package:flutter/material.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        // child: Padding(
        //   padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          spacing: 16,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "City",
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Postal Code",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Country",
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Phone Number",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
