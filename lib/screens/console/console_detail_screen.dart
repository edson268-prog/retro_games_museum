import 'package:flutter/material.dart';
import 'package:retro_games_museum/data/models/console_model.dart';

class ConsoleDetailScreen extends StatelessWidget {
  final String consoleName;
  final String imageUrl;
  final ConsoleModel consoleDetails; // Agregamos esto

  const ConsoleDetailScreen({
    required this.consoleName,
    required this.imageUrl,
    required this.consoleDetails, // Y esto
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(consoleName),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                Container(
                  height: constraints.maxHeight - 200,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text.rich(
                          TextSpan(
                            text: 'Año de lanzamiento: ',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            children: [
                              TextSpan(
                                text: consoleDetails.releaseYear.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text.rich(
                          TextSpan(
                            text: 'Fabricante: ',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            children: [
                              TextSpan(
                                text: consoleDetails.manufacturer,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text.rich(
                          TextSpan(
                            text: 'Formato: ',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            children: [
                              TextSpan(
                                text: consoleDetails.format,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            consoleDetails.description,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
