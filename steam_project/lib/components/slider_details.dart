import 'package:flutter/material.dart';
import 'package:steam_project/components/review_card.dart';
import 'package:steam_project/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class GameDetailsSlider extends StatefulWidget {
  final String appid;
  final String description;
  const GameDetailsSlider(
      {Key? key, required this.appid, required this.description})
      : super(key: key);

  @override
  _GameDetailsSliderState createState() => _GameDetailsSliderState();
}

class _GameDetailsSliderState extends State<GameDetailsSlider> {
  int _currentTab = 0;
  List<Map<String, dynamic>> _reviews = [];

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    final reviews = await fetchGameReview(int.parse(widget.appid));
    setState(() {
      _reviews = reviews;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentTab = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentTab == 0
                      ? const Color(0xFF636AF6)
                      : const Color(0xFF1a2025),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(3.54),
                    ),
                  ),
                  side: const BorderSide(color: Color(0xFF636AF6)),
                ),
                child: const Text(
                  'DESCRIPTION',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _currentTab = 1;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentTab == 1
                      ? const Color(0xFF636AF6)
                      : const Color(0xFF1a2025),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(3.54),
                    ),
                  ),
                  side: const BorderSide(color: Color(0xFF636AF6)),
                ),
                child: const Text(
                  'AVIS',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _currentTab == 0
            ? Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Html(
                        data: widget.description,
                        style: {
                          'body': Style(
                            fontSize: FontSize(16),
                            color: Colors.white,
                            alignment: Alignment.center,
                          ),
                        },
                      )
                    ],
                  ),
                ),
              )
            : _reviews.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _reviews.length,
                      itemBuilder: (context, index) {
                        if (index.isOdd) {
                          return const SizedBox(height: 10); // Add SizedBox
                        } else {
                          final review = _reviews[index];
                          return ReviewCard(
                            text: review['review'] ?? 'Review',
                            username: review['steamid'] ?? 'Username',
                          );
                        }
                      },
                    ),
                  ),
      ],
    );
  }
}
