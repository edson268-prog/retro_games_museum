import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../config/database_config.dart';
import '../../data/models/console_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DatabaseConfig.databaseName);
    return await openDatabase(
      path,
      version: DatabaseConfig.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(DatabaseConfig.createConsoleTable);
    await db.execute(DatabaseConfig.createGameTable);
    await _insertDefaultData(db);
  }

  Future<void> _insertDefaultData(Database db) async {
    final defaultConsoles = [
      ConsoleModel(
        name: 'NES',
        manufacturer: 'Nintendo',
        releaseYear: 1985,
        description: 'La NES (Nintendo Entertainment System o también llamada Nintendo, simplemente) es una consola de 8-bits que fue lanzada por Nintendo en 1985 en USA, 1986 en la mayoría de Europa (no en España) y 1987 en Australia y resto de Europa (ahora sí). En España la distribuyó Spaco, puesto que por aquel entonces no existía Nintendo España. Vendió más de 62 millones de consolas y 500 millones de juegos en todo el mundo, que la convirtieron, durante mucho tiempo, en la consola más popular de la historia.',
        format: 'Cartuchos',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/consoles%2Fnes_transparency-min.png?alt=media&token=cba65dd5-d04a-4e0d-9fc5-a95e5ffe6e28'
      ),
      ConsoleModel(
        name: 'SNES',
        manufacturer: 'Nintendo',
        releaseYear: 1990,
        description: 'La Super Nintendo Entertainment System (también conocida como Super NES, SNES o simplemente, Super Nintendo) fue la consola lanzada por Nintendo en la cuarta generación, la de los 16 bits. En Japón vio la luz en 1990, 1991 en EEUU y 1992 en Europa y Australasia – las regiones PAL -. En Suramérica, la Super Nintendo no hizo acto de presencia hasta 1993.',
        format: 'Cartuchos',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/consoles%2Fsnes_transparency-min.png?alt=media&token=7dae998a-cab1-451c-b634-0f3beb4897cd'
      ),
      ConsoleModel(
        name: 'PlayStation',
        manufacturer: 'Sony',
        releaseYear: 1994,
        description: 'La PlayStation. Quizás la más grande desde la NES. Inició el dominio de Sony y su familia de consolas de forma espectacular, siendo la primera consola en vender más de 100 millones de unidades, una cifra enorme. Su popularidad fue tal que seguían vendiéndose juegos nuevos hasta 2006, 11 años después de su lanzamiento y sólo a unos meses del lanzamiento de la PlayStation 3. Abreviada oficialmente como PS pero también conocida como PS1 o PSX, es una consola de 32 bits lanzada por Sony Computer Entertainment el 3 de Diciembre de 1994 en Japón y prácticamente un año más tarde en occidente, durante el mes de septiembre de 1995.',
        format: 'CD',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/consoles%2Fps1_transparency-min.png?alt=media&token=014a6396-295f-421c-abcf-e213bd7665f2'
      ),
      ConsoleModel(
        name: 'PlayStation 2',
        manufacturer: 'Sony',
        releaseYear: 2000,
        description: 'La PlayStation 2, fabricada por Sony, fue lanzada en el año 2000 (4 de marzo en Japón, a finales de año en el resto del mundo) y se convirtió en la consola de sobremesa más vendida de la historia, con más de 155 millones de unidades vendidas. También tiene uno de los ciclos de producción más largos de la historia, de algo más de 12 años, sólo comparable a los de la Neo-Geo y de la Atari 2600.',
        format: 'CD',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/consoles%2Fps2_transparency-min.png?alt=media&token=b4c65ac5-1810-4ab8-a0f9-e932b26de5b6'
      ),
      ConsoleModel(
        name: 'Nintendo 64',
        manufacturer: 'Nintendo',
        releaseYear: 1996,
        description: 'La Nintendo 64 fue la consola de quinta generación de Nintendo. Muchas veces referida como N64 y previamente llamada Ultra 64, fue la tercera consola de Nintendo que vio la luz internacionalmente. Su nombre se debía a su procesador central de 64 bits. La última en llegar, no lo hizo hasta verano de 1996 en Japón y EEUU. El resto de territorios tuvieron que esperar hasta primavera de 1997. Compitió con la PlayStation y la Sega Saturn, hasta que fue sustituida por la GameCube en 2001.',
        format: 'Cartucho',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/consoles%2Fnintendo_64_transparency-min.png?alt=media&token=2e58ee0a-8083-4786-bca2-d185c5f8a627'
      ),
      ConsoleModel(
        name: 'Mega Drive',
        manufacturer: 'SEGA',
        releaseYear: 1988,
        description: 'La Mega Drive de Sega (conocida como Genesis en Estados Unidos) fue lanzada al mercado el 29 de octubre de 1988 en Japón. Le seguiría Estados Unidos, pero la incapacidad para llegar a un acuerdo con Atari para la distribución hizo que se retrasase el lanzamiento hasta otoño de 1989. La versión PAL, para Europa y Australia, principalmente, no llegaría hasta el 30 de Noviembre de 1990, dos años después de su aparición en Japón. La razón para tener dos nombres es simple: los derechos del nombre Mega Drive ya estaban cogidos en Estados Unidos. La Mega Drive tenía también compatibilidad con los cartuchos de Master System, pero siempre a través de un adaptador.',
        format: 'Cartucho',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/consoles%2Fgenensis_transparency-min.png?alt=media&token=026f5d7f-aa85-4b42-a3e2-167158fccc82'
      ),
      ConsoleModel(
        name: 'Dreamcast',
        manufacturer: 'SEGA',
        releaseYear: 1998,
        description: 'La Dreamcast fue la primera consola en llegar en la sexta generación, de la mano de Sega en noviembre de 1998 en Japón y a finales de 1999 en el resto de territorios. Es, hasta la fecha, la última consola de Sega. Tras los desastres comerciales de la Mega-CD y de la 32X, la Sega Saturn había sido la esperanza de Sega para la quinta generación, pero tras los lanzamientos de la PlayStation y de la Nintendo 64, la consola de Sega se encontraba en una lejana tercera plaza. Aunque en Japón tuviese una base instalada bastante grande, las decisiones comerciales que se habían tomado en el resto del mundo – como el lanzamiento prematuro y sorpresa en Estados Unidos – habían herido de muerte la Saturn desde su primera aparición. Desde 1996, la batalla se consideraba a dos frentes; PlayStation contra Nintendo 64; Sony contra Nintendo.',
        format: 'GD-ROM',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/consoles%2Fdreamcast_transparency-min.png?alt=media&token=42b4167a-375c-4360-b517-c32cf91fc1a7'
      ),
    ];

    for (var console in defaultConsoles) {
      await db.insert(DatabaseConfig.consoleTable, console.toMap());
    }
  }
}