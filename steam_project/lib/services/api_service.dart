import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:steam_project/utils/showSnackBar.dart';
import '../model/game.dart';
import '../model/steam_user.dart';

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

    final priceOverview = appDetails['price_overview'];
    final price =
        priceOverview != null ? priceOverview['final_formatted'] : 'N/A';

    return {
      'name': appDetails['name'] ?? 'N/A',
      'image': appDetails['header_image'],
      'background': appDetails['background'],
      'developers': appDetails['developers'],
      'free': appDetails['is_free'] == true ? 'Gratuit' : price
    };
  } else {
    throw Exception(
        'Echec de chargement des détails du jeu $appId erreur : ${response.statusCode}');
  }
}

Future<Game> fetchGame(int appId) async {
  final response = await http.get(
      Uri.parse('https://store.steampowered.com/api/appdetails?appids=$appId'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body)['$appId']['data'];
    bool isFree = json['is_free'];

    String? finalFormatted;
    if (!isFree) {
      finalFormatted = json['price_overview'] != null
          ? json['price_overview']['final_formatted']
          : 'N/A';
    }

    return Game(
      steam_appid: json['steam_appid']?.toString() ?? '',
      name: json['name'] ?? '',
      isFree: isFree,
      shortDescription: json['short_description'] ?? '',
      description: json['about_the_game'] ?? '',
      headerImage: json['header_image'] ?? '',
      developers: List<String>.from(json['developers'] ?? []),
      backgroundRaw: json['background_raw'] ?? '',
      background: json['background'] ?? '',
      final_formatted: finalFormatted,
    );
  } else {
    throw Exception('Failed to fetch game');
  }
}

Future<List<Map<String, dynamic>>> fetchGameReview(int appId) async {
  final res = await http.get(
      Uri.parse('https://store.steampowered.com/appreviews/$appId?json=1'));
  if (res.statusCode == 200) {
    final data = json.decode(res.body);
    final reviews = data['reviews'];
    final querySummary = data['query_summary'];
    final reviewSocre = querySummary['review_score'];
    final reviewSocreDesc = querySummary['review_score_desc'];
    final result = <Map<String, dynamic>>[];
    for (final review in reviews) {
      final authorId = review['author']['steamid'];
      final reviewText = review['review'];
      result.add({
        'steamid': authorId,
        'review_score': reviewSocre,
        'review_score_desc': reviewSocreDesc,
        'review': reviewText,
      });
    }
    return result;
  } else {
    throw Exception('Failed to fetch game reviews');
  }
}

// ignore: non_constant_identifier_names
Future<List<int>> fetchFindGame(String GameName) async {
  final response = await http.get(
      Uri.parse('https://steamcommunity.com/actions/SearchApps/$GameName'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data.map<int>((game) => int.parse(game['appid'])).toList();
  } else {
    throw Exception('Failed to load app IDs of $GameName');
  }
}

Future<SteamUser> fetchSteamUser(String steamId) async {
  const ApiKey = '5BB9F89B6982BB7D8D8E7B5FBE5FF77E';
  final response = await http.get(Uri.parse(
      'http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=$ApiKey&steamids=$steamId'));
  final data = jsonDecode(response.body)['response']['players'][0];
  return SteamUser(
    personaName: data['personaname'] ?? 'Unknown',
    avatarUrl: data['avatarfull'],
  );
}
