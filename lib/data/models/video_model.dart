import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoModel {
  final int? id;
  final String title;
  final int consoleId;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final String duration;

  VideoModel({
    this.id,
    required this.title,
    required this.consoleId,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'console_id': consoleId,
      'description': description,
      'thumbnail_url': thumbnailUrl,
      'video_url': videoUrl,
      'duration': duration,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'],
      title: map['title'],
      consoleId: map['console_id'],
      description: map['description'],
      thumbnailUrl: map['thumbnail_url'],
      videoUrl: map['video_url'],
      duration: map['duration'],
    );
  }

  String get youtubeId =>
      YoutubePlayerController.convertUrlToId(videoUrl) ?? '';
}
