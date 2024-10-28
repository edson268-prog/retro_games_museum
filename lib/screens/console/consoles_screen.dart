import 'package:flutter/material.dart';
import 'package:retro_games_museum/screens/console/console_detail_screen.dart';
import '../../data/models/console_model.dart';
import '../../data/repositories/console_repository.dart';

class ConsolesScreen extends StatefulWidget {
  const ConsolesScreen({super.key});

  @override
  State<ConsolesScreen> createState() => _ConsolesScreenState();
}

class _ConsolesScreenState extends State<ConsolesScreen> {
  final ConsoleRepository _consoleRepository = ConsoleRepository();
  List<ConsoleModel> _consoles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConsoles();
  }

  Future<void> _loadConsoles() async {
    try {
      final consoles = await _consoleRepository.getAllConsoles();
      setState(() {
        _consoles = consoles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // SHOW ERROR
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      color: Colors.grey,
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _consoles.length,
        itemBuilder: (context, index) {
          final console = _consoles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsoleDetailScreen(
                    consoleName: console.name,
                    imageUrl: console.imagePath,
                    consoleDetails: console, // Pasamos el modelo completo
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      console.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    console.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    console.releaseYear.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}