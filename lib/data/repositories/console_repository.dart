import '../../core/database_helper.dart';
import '../models/console_model.dart';
import '../models/simple_console_model.dart';
import '../../config/database_config.dart';

class ConsoleRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<ConsoleModel>> getAllConsoles() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query(DatabaseConfig.consoleTable);

    return List.generate(maps.length, (i) {
      return ConsoleModel.fromMap(maps[i]);
    });
  }

  Future<ConsoleModel?> getConsole(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseConfig.consoleTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return ConsoleModel.fromMap(maps.first);
  }

  Future<int> insertConsole(ConsoleModel console) async {
    final db = await _databaseHelper.database;
    return await db.insert(DatabaseConfig.consoleTable, console.toMap());
  }

  Future<List<SimpleConsoleModel>> getAllConsoleNames() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseConfig.consoleTable,
      columns: ['id', 'name'],
    );
    
    return List.generate(maps.length, (i) {
      return SimpleConsoleModel.fromMap(maps[i]);
    });
  }
}
