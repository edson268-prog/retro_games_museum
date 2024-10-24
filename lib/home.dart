import 'package:flutter/material.dart';

void main() => runApp(const RetroGameMuseum());

class RetroGameMuseum extends StatelessWidget {
  const RetroGameMuseum({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Retro Game Museum",
      home: Index(),
    );
  }
}

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Museum"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/Index%2FRetro_Banner_webp.webp?alt=media&token=36a1d16f-9ec4-4936-b67d-ed9862d56861"),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hola 1"), 
              Text("Hola 2")
              ],
          ),
          Center(
            child: ElevatedButton(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Hora")
                ],
              ),
              onPressed: (){
                var t = DateTime.now(); 
                print(t);
              },
            ),
          )
        ],
      ),
    );
  }
}
