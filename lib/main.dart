import 'package:flutter/material.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/screens/home_page.dart';

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
      home: const HomePage(),
    );
  }
}
