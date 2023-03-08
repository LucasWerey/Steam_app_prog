import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/game.dart';

Future<List<int>> fetchAppIds() async {
  final response = await http.get(Uri.parse(
      'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final ranks = data['response']['ranks'];
    return ranks.map<int>((rank) => rank['appid'] as int).toList();
  } else {
    throw Exception('Failed to load app IDs');
  }
}

Future<Map<String, dynamic>> fetchAppDetails(int appId) async {
  final response = await http.get(
      Uri.parse('https://store.steampowered.com/api/appdetails?appids=$appId'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final appDetails = data['$appId']['data'];

    return {
      'name': appDetails['name'],
      'image': appDetails['header_image'],
      'background': appDetails['background'],
      'developers': appDetails['developers'],
      'free': appDetails['is_free'] == true
          ? 'Gratuit'
          : appDetails['price_overview']['final_formatted'],
    };
  } else {
    throw Exception('Failed to load app details');
  }
}

Future<Game> fetchGame(int appId) async {
  final response = await http.get(
      Uri.parse('https://store.steampowered.com/api/appdetails?appids=$appId'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body)['$appId']['data'];
    bool isFree = json['is_free'];

    String? final_formatted;
    if (!isFree) {
      final_formatted = json['price_overview']['final_formatted'];
    }

    return Game(
      steam_appid: json['steam_appid'].toString(),
      name: json['name'],
      isFree: isFree,
      shortDescription: json['short_description'],
      description: json['about_the_game'],
      headerImage: json['header_image'],
      developers: List<String>.from(json['developers']),
      backgroundRaw: json['background_raw'],
      background: json['background'],
      final_formatted: final_formatted,
    );
  } else {
    throw Exception('Failed to fetch game');
  }
}
