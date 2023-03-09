import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class Search_Bar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onSubmitted;

  const Search_Bar({super.key, 
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.left,
                controller: controller,
                onSubmitted: onSubmitted,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Proxima',
                    fontSize: 12.92),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.52),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.52),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 30, 38, 44),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Proxima',
                    fontSize: 12.92,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(VectorialImages.search),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
