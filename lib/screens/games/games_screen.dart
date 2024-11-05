import 'package:flutter/material.dart';

import '../../data/models/game_model.dart';
import '../../data/models/simple_console_model.dart';
import '../../data/repositories/console_repository.dart';
import '../../data/repositories/game_repository.dart';
import 'game_detail_screen.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final ConsoleRepository _consoleRepository = ConsoleRepository();
  final GameRepository _gameRepository = GameRepository();
  List<SimpleConsoleModel> _consolesNames = [];
  List<GameModel> _gameImages = [];
  bool _isLoading = true;
  bool _showDefaultMessage = true;

  @override
  void initState() {
    super.initState();
    _loadConsoleNames();
  }

  Future<void> _loadConsoleNames() async {
    try {
      final consoles = await _consoleRepository.getAllConsoleNames();
      setState(() {
        _consolesNames = consoles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 231, 218, 218),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: _consolesNames.map((console) {
                return GestureDetector(
                  onTap: () => _showGames(context, console.id.toString()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        console.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _gameImages.isEmpty
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Text(
                        _showDefaultMessage ? 'Seleccione una consola para ver sus juegos': 'No se tiene registro de juegos para esta consola.',
                      ),
                    ),
                  )
                : Row(
                    children: _gameImages.map((game) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameDetailScreen(
                                gameId: game.id ?? 0,
                                gameTitle: game.title,
                                rating: game.rating ?? 0,
                                releaseYear: game.releaseYear,
                                genre: game.genre,
                                description: game.description,
                                imagePath: game.imagePath,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            game.imagePath,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.6,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ]));
  }

  Future<void> _showGames(BuildContext context, String consoleId) async {
    try {
      final games =
          await _gameRepository.getGamesByConsoleId(int.parse(consoleId));
      setState(() {
        _gameImages = games.map((imagePath) => imagePath).toList();
        _showDefaultMessage = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
