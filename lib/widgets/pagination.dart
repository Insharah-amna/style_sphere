import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentPage = 1;
  int totalPages = 5;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentPage > 1 ? () {} : null,
          icon: SvgPicture.asset('assets/icons/chevron-left.svg', width: 28),
        ),

        ...List.generate(totalPages, (index) {
          final page = index + 1;

          return GestureDetector(
            onTap: () {
              setState(() {
                currentPage = page;
              });
            },
            child: Container(
              width: 36,
              height: 36,
              alignment: .center,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: currentPage == page
                    ? Colors.black
                    : Colors.grey.shade200,
              ),
              child: Text(
                "$page",
                style: TextStyle(
                  color: currentPage == page ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }),

        IconButton(
          onPressed: currentPage < totalPages ? () {} : null,
          icon: SvgPicture.asset('assets/icons/chevron-right.svg', width: 28),
        ),
      ],
    );
  }
}
