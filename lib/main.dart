import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retro_games_museum/home.dart';

// void main() => runApp(const RetroGameMuseum());
void main() {
  // Cambiar el color de la Status Bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Cambia el color de la Status Bar
      statusBarIconBrightness:
          Brightness.light, // Cambia el color de los íconos
    ),
  );

  runApp(const RetroGameMuseum());
}

class RetroGameMuseum extends StatelessWidget {
  const RetroGameMuseum({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Index(),
      ),
    );
  }
}

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/Index%2FRetro_Banner_2_webp.webp?alt=media&token=c3193177-bcbc-4ae4-b482-7cbc1f9fbf10',
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
                      print("PRESIONADO");
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
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
    ),
  );
}
