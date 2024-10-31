import 'package:flutter/material.dart';
import 'package:retro_games_museum/data/models/video_model.dart';
import 'package:retro_games_museum/data/repositories/video_repository.dart';

import 'video_detail_screen.dart';
import 'video_player_card.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final VideoRepository _videoRepository = VideoRepository();
  List<VideoModel> _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConsoles();
  }

  Future<void> _loadConsoles() async {
    try {
      final videos = await _videoRepository.getAllVideos();
      setState(() {
        _videos = videos;
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

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 218, 218),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoDetailScreen(video: _videos[index]),
                ),
              );
            },
            child: VideoPlayerCard(video: _videos[index]),
          );
        },
      ),
    );
  }
}
