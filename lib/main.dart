import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retro_games_museum/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness:
          Brightness.light,
    ),
  );

  runApp(const RetroGameMuseum());
}

class RetroGameMuseum extends StatefulWidget {
  const RetroGameMuseum({super.key});

  @override
  State<RetroGameMuseum> createState() => _RetroGameMuseumState();
}

class _RetroGameMuseumState extends State<RetroGameMuseum> {
  bool _isFirstLaunch = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isFirstLaunch ? Index(onContinue: _goToHome) : const Home(),
    );
  }

  void _goToHome() {
    setState(() {
      _isFirstLaunch = false;
    });
  }
}

class Index extends StatelessWidget {
  final VoidCallback onContinue;
  const Index({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/Retro_Banner_2_webp.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: titulo("Bienvenido a Retro Games Museum")),
                  const SizedBox(height: 8),
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      child: subtitulo("Embarcate en una aventura a través de los videojuegos clásicos y recuerdos de tu infancia.")),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: () {
                      onContinue();
                    },
                    child: const Text('Continuar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget titulo(String titulo) {
  return Text(
    titulo,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      decoration: TextDecoration.none,
    ),
  );
}

Widget subtitulo(String titulo) {
  return Text(
    titulo,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 16,
      color: Colors.grey[600],
      decoration: TextDecoration.none,
    ),
  );
}
