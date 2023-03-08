import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final double rate;
  final int starsNumber;

  RatingStar({required this.rate, required this.starsNumber});

  @override
  Widget build(BuildContext context) {
    double rate5 = rate / 2;
    int fullStarts = rate5.floor();
    double dif = rate5 - fullStarts;

    List<Widget> etoiles = [];

    for (int i = 0; i < starsNumber; i++) {
      if (i < fullStarts) {
        etoiles.add(Icon(Icons.star, color: Colors.yellow));
      } else if (i == fullStarts) {
        etoiles.add(Icon(Icons.star_half, color: Colors.yellow));
      } else {
        etoiles.add(Icon(Icons.star_border, color: Colors.grey));
      }
    }

    return Row(children: etoiles);
  }
}
