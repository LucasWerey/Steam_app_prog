import 'package:flutter/material.dart';
import 'package:steam_project/components/searchbar.dart';
import 'package:steam_project/model/game.dart';
import 'package:steam_project/components/game_card.dart';
import '../resources/resources.dart';
import '../services/api_service.dart';

class SearchPage extends StatefulWidget {
  final String? searchText;
  const SearchPage({Key? key, this.searchText}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        await fetchGame(id, 'french').then((game) {
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
    searchController.text = widget.searchText ?? '';
    searchController.addListener(() {
      _searchGames(searchController.text);
    });
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
        title: const Text('Recherche'),
        backgroundColor: const Color.fromARGB(255, 30, 38, 44),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.backgroundEmpty),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nombre de résultats : ${_filteredGames.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Proxima',
                    decoration: TextDecoration.underline,
                    decorationThickness: 4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
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
                    price: game.final_formatted,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
