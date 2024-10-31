import 'package:retro_games_museum/data/models/video_model.dart';

import '../../core/database_helper.dart';
import '../../config/database_config.dart';

class VideoRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<VideoModel>> getAllVideos() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query(DatabaseConfig.videoTable);

    return List.generate(maps.length, (i) {
      return VideoModel.fromMap(maps[i]);
    });
  }
}
