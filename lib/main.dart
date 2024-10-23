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
      body: const Center(child: Text("Hola Mundo"),),
    );
  }
}