import 'package:flutter/material.dart';
import 'package:steam_project/components/searchbar.dart';
import 'package:steam_project/model/game.dart';
import 'package:steam_project/components/game_card.dart';
import '../resources/resources.dart';
import '../services/api_service.dart';
import '../utils/showSnackBar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Game> _filteredGames = [];

  void _searchGames(String searchText) async {
    fetchFindGame(searchText).then((ids) async {
      List<Game> filteredGames = [];
      for (int id in ids) {
        await fetchGame(id).then((game) {
          String name = game.name.toLowerCase();
          if (name.contains(searchText.toLowerCase())) {
            filteredGames.add(game);
          }
        });
      }
      setState(() {
        _filteredGames = filteredGames;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      _searchGames(searchController.text);
    });
    // Donner le focus à la barre de recherche lors du chargement de la page
    Future.delayed(Duration.zero, () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(() {
      _searchGames(searchController.text);
    });
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
        backgroundColor: const Color.fromARGB(255, 30, 38, 44),
        elevation: 0,
      ),
      body: Column(
        children: [
          Search_Bar(
            controller: searchController,
            focusNode: _focusNode,
            hintText: 'Rechercher un jeu...',
            onSubmitted: (text) {
              if (text.isNotEmpty) {
                _searchGames(text);
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredGames.length,
              itemBuilder: (context, index) {
                final game = _filteredGames[index];
                return GameCard(
                  appId: game.steam_appid,
                  gameName: game.name,
                  gameImage: game.headerImage,
                  backgroundImage: game.background,
                  free: game.isFree.toString(),
                  gameEditor: game.developers,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
