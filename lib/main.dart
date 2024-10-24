import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// void main() => runApp(const RetroGameMuseum());
void main() {
  // Cambiar el color de la Status Bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Cambia el color de la Status Bar
      statusBarIconBrightness: Brightness.light, // Cambia el color de los íconos
    ),
  );

  runApp(const RetroGameMuseum());
}

class RetroGameMuseum extends StatelessWidget {
  const RetroGameMuseum({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Index(),
      ),
    );
  }
}

class Index extends StatelessWidget {
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
          
          // Parte inferior: Título, subtítulo y botón
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
                  child: const Text(
                    'Bienvenido a Retro Games Museum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Embarcate en una aventura a través de los videojuegos clásicos y recuerdos de tu infancia.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
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
                      // Acción del botón
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
