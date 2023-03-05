import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgClickableComponent extends StatelessWidget {
  final String svgPath;
  final VoidCallback onPressed;

  const SvgClickableComponent({super.key, required this.svgPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SvgPicture.asset(svgPath),
    );
  }
}
