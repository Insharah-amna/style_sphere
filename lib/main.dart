import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/constants/app_routes.dart';
import 'package:style_sphere/screens/auth/login_screen.dart';
import 'package:style_sphere/screens/auth/signup_screen.dart';
import 'package:style_sphere/screens/blog_detail_page.dart';
import 'package:style_sphere/screens/collection_detail.dart';
import 'package:style_sphere/screens/home_page.dart';
import 'package:style_sphere/screens/product_detail.dart';
import 'package:style_sphere/screens/products_page.dart';
import 'package:style_sphere/screens/collection_screen.dart';
import 'package:style_sphere/screens/blog_page.dart';
import 'package:style_sphere/screens/about.dart';
import 'package:style_sphere/screens/contact_us.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Style Sphere',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'TenorSans',
        textTheme: TextTheme(
          displayLarge: TextStyle(fontFamily: 'BodoniModa', fontSize: 40),
          displaySmall: TextStyle(
            fontFamily: 'BodoniModa',
            fontSize: 14,
            fontWeight: .w400,
            color: AppColors.offWhite,
            letterSpacing: 2,
          ),
          titleLarge: TextStyle(fontSize: 18, fontWeight: .bold),
          titleMedium: TextStyle(fontSize: 16, color: AppColors.offWhite),
          titleSmall: TextStyle(fontSize: 13, color: AppColors.placeholder),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12, color: AppColors.label),
          labelMedium: TextStyle(fontSize: 15, color: AppColors.secondary),
        ),
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),

      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.products: (context) => const ProductsPage(),
        AppRoutes.productsDetail: (context) => const ProductDetail(),
        AppRoutes.collection: (context) => const CollectionScreen(),
        AppRoutes.collectionDetail: (context) => const CollectionDetail(),
        AppRoutes.blog: (context) => const BlogPage(),
        AppRoutes.blogDetail: (context) => const BlogDetailPage(),
        AppRoutes.about: (context) => const AboutScreen(),
        AppRoutes.contact: (context) => const ContactUsPage(),
      },
    );
  }
}
