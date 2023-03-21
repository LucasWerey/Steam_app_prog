import 'package:flutter/material.dart';
import '../../resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class Search_Bar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const Search_Bar({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onSubmitted,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Search_BarState createState() => _Search_BarState();
}

// ignore: camel_case_types
class _Search_BarState extends State<Search_Bar> {
  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(widget.focusNode);
      });
    }
  }

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
                controller: widget.controller,
                onChanged: widget.onChanged,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Proxima',
                  fontSize: 12.92,
                ),
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
                  hintText: widget.hintText,
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
                focusNode: widget.focusNode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
