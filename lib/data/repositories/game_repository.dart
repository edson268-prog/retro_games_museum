import '../../core/database_helper.dart';
import '../../config/database_config.dart';
import '../models/game_model.dart';

class GameRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<GameModel>> getGamesByConsoleId(int consoleId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseConfig.gameTable,
      where: 'console_id = ?',
      whereArgs: [consoleId],
    );
    return List.generate(maps.length, (i) {
      return GameModel.fromMap(maps[i]);
    });
  }

  Future<void> updateGameRating(String gameId, double rating) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        DatabaseConfig.gameTable,
        {'rating': rating},
        where: 'id = ?',
        whereArgs: [gameId],
      );
    } catch (e) {
      throw Exception('Error al actualizar la calificación: $e');
    }
  }

  Future<double> getGameRating(String gameId) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> result = await db.query(
        DatabaseConfig.gameTable,
        columns: ['rating'],
        where: 'id = ?',
        whereArgs: [gameId],
      );

      if (result.isNotEmpty) {
        return result.first['rating'] as double;
      }
      return 0.0;
    } catch (e) {
      throw Exception('Error al obtener la calificación: $e');
    }
  }
}
