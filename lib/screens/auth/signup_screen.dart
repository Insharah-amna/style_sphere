import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Signup", style: TextStyle(fontSize: 28)),
                  const SizedBox(height: 6),

                  Image.asset("assets/images/decoration_line.png", height: 9),
                  const SizedBox(height: 38),

                  /// Name
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Full Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Email
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }
                      if (!value.contains('@')) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Password
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Confirm Password
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 58),

                  /// Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Signup Successful")),
                          );
                          Navigator.pushNamed(context, AppRoutes.login);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        backgroundColor: Colors.black,
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
                      ),
                      child: Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Signup Navigation
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    child: Text(
                      "Back to Login",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
