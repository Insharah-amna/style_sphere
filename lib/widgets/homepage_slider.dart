import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:style_sphere/constants/app_colors.dart';

class HomepageSlider extends StatefulWidget {
  const HomepageSlider({super.key});

  @override
  State<HomepageSlider> createState() => _HomepageSliderState();
}

class _HomepageSliderState extends State<HomepageSlider> {

  final List<String> imageUrls = [
    "assets/images/homepage1.png",
    "assets/images/homepage1.png",
    "assets/images/homepage1.png",
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 660,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: .infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/homepage1.png"), fit: .cover)
              ),
              child: Column(
                children: [
                  const SizedBox(height: 230),

                  Text(
                    "LUXURY\n FASHION\n& ACCESSORIES",
                    style: TextStyle(fontFamily: 'BodoniModa', fontSize: 36, color: Color(0xFF696A6B)),
                  ),

                  const SizedBox(height: 165),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0x66111111),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text("EXPLORE COLLECTION", style: Theme.of(context).textTheme.titleMedium),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageUrls.asMap().entries.map((entry) {
                      return Transform.rotate(
                        angle: 0.785,
                        child: Container(
                          width: 6.0,
                          height: 6.0,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: _currentIndex == entry.key
                                ? .fromBorderSide(.none)
                                : Border.all(width: 1, color: AppColors.offWhite),
                            color: _currentIndex == entry.key
                                ? AppColors.offWhite
                                : Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
