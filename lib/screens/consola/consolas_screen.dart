import 'package:flutter/material.dart';
import 'package:retro_games_museum/screens/consola/detalle_consola_screen.dart';

class ConsolasScreen extends StatelessWidget {
  const ConsolasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> consoleNames = ['NES', 'SNES', 'PS1', 'PS2'];
    final List<String> consoleImages = [
      'assets/images/nes_transparency-min.png',
      'assets/images/snes_transparency-min.png',
      'assets/images/ps1_transparency-min.png',
      'assets/images/ps2_transparency-min.png',
    ];

    return Container(
      color: Colors.grey,
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: consoleNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleConsolaScreen(
                    consoleName: consoleNames[index],
                    imageUrl: consoleImages[index],
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
                    child: Image.asset(
                      consoleImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    consoleNames[index],
                    style: TextStyle(
                      fontSize: 16,
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
