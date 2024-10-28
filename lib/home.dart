import 'package:flutter/material.dart';
import 'package:retro_games_museum/screens/accesorios/accesorios_screen.dart';
import 'package:retro_games_museum/screens/console/consoles_screen.dart';
import 'package:retro_games_museum/screens/games/games_screen.dart';
import 'package:retro_games_museum/screens/videos/videos_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Retro Game Museum',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: const TabBar(
                isScrollable: false,
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.white,
                dividerColor: Colors.blue,
                tabs: [
                  Tab(text: 'Consolas'),
                  Tab(text: 'Juegos'),
                  Tab(text: 'Videos'),
                  Tab(text: 'Accesorios'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ConsolesScreen(),
                  GamesScreen(),
                  VideosScreen(),
                  AccesoriosScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
