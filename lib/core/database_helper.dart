import 'package:retro_games_museum/data/models/video_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../config/database_config.dart';
import '../../data/models/console_model.dart';
import '../data/models/game_model.dart';

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
    await db.execute(DatabaseConfig.createVideoTable);
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

    final defaultGames = [
      // NES
      GameModel(
        title: 'Super Mario Bros', 
        consoleId: 1, 
        releaseYear: 1985, 
        genre: 'Plataformas, Aventura', 
        description: 'El juego describe las aventuras de dos fontaneros, Mario y Luigi, quienes deben rescatar a la Princesa Peach, quién fue secuestrada por el rey de los Koopas, Bowser y salvar al Reino Champiñón de este mismo. A través de ocho diferentes niveles de juego, los jugadores pueden controlar a uno de los dos hermanos y deben enfrentarse finalmente a cada uno de los enemigos de cada castillo para liberar a la Princesa Peach.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fnes_super_mario_bros.jpg?alt=media&token=cba4c64d-7b1a-448c-997c-f4676ec4d925'
      ),
      GameModel(
        title: 'Duck Hunt', 
        consoleId: 1, 
        releaseYear: 1984, 
        genre: 'Shooter, Simulación', 
        description: 'Duck Hunt es un videojuego de disparos para la Nintendo Entertainment System. Se conoce más comúnmente como un juego de lanzamiento para el NES en América del Norte (que venia incluida con la consola). Duck Hunt está basado en un juego de Laser Clay Shooting System con el mismo nombre. Una versión (Vs.) fue lanzada en las salas recreativas en América del Norte en 1984. Después se lanzó como un combo con Super Mario Bros. e incluso más tarde se lanzó como una combinación de tres juegos con World Class Track Meet.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fnes_duck_hunt.jpg?alt=media&token=8ffedf6e-1734-4076-8768-d2c78fb8577c'
      ),
      GameModel(
        title: 'Super Mario Bros 3', 
        consoleId: 1, 
        releaseYear: 1988, 
        genre: 'Plataformas', 
        description: 'Super Mario Bros. 3 (スーパーマリオブラザーズ3 en japonés) es el último videojuego de plataformas de la franquicia Mario para la consola Nintendo Entertainment System. Salió a la venta el 23 de octubre de 1988 en Japón y el 12 de febrero de 1990 en Estados Unidos. Al igual que en títulos anteriores, SMB3 fue diseñado por Shigeru Miyamoto, mientras que la banda sonora fue compuesta por Kōji Kondō. El juego retoma la historia del primer título, en la cual los fontaneros Mario y Luigi deberán salvar a la Princesa Peach de las garras del Rey Koopa.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fnes_super_mario_bros_3.jpg?alt=media&token=4aee9410-5818-4a3e-8b2b-4630acc8b3f8'
      ),
      GameModel(
        title: 'Excitebike', 
        consoleId: 1, 
        releaseYear: 1984, 
        genre: 'Racing, Deportes', 
        description: 'Es un videojuego de carreras de moto-cross creado por Nintendo. Debutó como juego para la Famicom en Japón en 1984 y un año más tarde en la consola Nintendo Entertainment System en América del Norte en el año 1985. Este es el primer juego de la serie Excite. En el juego, el jugador tiene la opción de competir contra motoristas manejados por la consola o con un amigo. Fue el primer juego de la saga Excite, sucedido por Excitebike 64 y sus sucesores, Excite Truck y Excitebots.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fnes_excitebike.jpg?alt=media&token=ebad084b-6145-43f6-9ecd-7afa6939f785'
      ),
      GameModel(
        title: 'The Legend of Zelda', 
        consoleId: 1, 
        releaseYear: 1986, 
        genre: 'Acción, Aventura', 
        description: 'También conocido como THE HYRULE FANTASY, es la primera entrega de la saga de Zelda, diseñado por Shigeru Miyamoto y desarrollado y publicado por Nintendo. Situado en la tierra de Hyrule, la trama se centra en un chico llamado Link, el protagonista jugable que tiene como objetivo rescatar a la princesa Zelda de las garras de la antagonista principal, Ganon, mediante la recopilación de los ocho fragmentos de la Trifuerza, un poderoso artefacto.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fnes_legend_of_zelda.jpg?alt=media&token=407c1016-657b-49cb-a720-a3823c709c01'
      ),
      // PS1
      GameModel(
        title: 'Crash Bandicoot', 
        consoleId: 3, 
        releaseYear: 1996, 
        genre: 'Plataformas, Aventura', 
        description: 'El jugador controla a Crash, un bandicoot mejorado genéticamente creado por el científico loco Doctor Neo Cortex. La trama sigue a Crash en su intento por rescatar a su novia Tawna, y frustrar los planes del científico Neo Cortex para dominar el mundo. Si bien el título cuenta principalmente con un sistema de perspectiva en tercera persona, algunos de sus niveles muestran una vista tanto lateral como frontal.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fps1_crash_bandicoot.webp?alt=media&token=56d9c9aa-0f52-4fa2-89d2-ee5e1e0ad5a8'
      ),
      GameModel(
        title: 'Tomb Raider', 
        consoleId: 3, 
        releaseYear: 1996, 
        genre: 'Acción, Disparos, Aventura', 
        description: 'Es la primera entrega de la franquicia mediática Tomb Raider, que sigue a la arqueóloga y aventurera Lara Croft, contratada por la empresaria de Jacqueline Natla para encontrar un artefacto llamado Vástago de la Atlántida. El juego presenta a Lara atravesando niveles divididos en múltiples áreas y complejos de habitaciones mientras lucha contra enemigos y resuelve acertijos para progresar.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fps1_tomb_raider.jpg?alt=media&token=958c37ab-06bb-4a84-8b52-0a9bdbec145d'
      ),
      GameModel(
        title: 'Metal Gear Solid', 
        consoleId: 3, 
        releaseYear: 1998, 
        genre: 'Acción, Espionaje táctico', 
        description: 'Metal Gear Solid sigue a Solid Snake, un soldado que se infiltra en una instalación de armas nucleares para neutralizar la amenaza terrorista de FOXHOUND, una unidad genéticamente mejorada de fuerzas especiales. Snake debe liberar a dos importantes rehenes, confrontar a los terroristas y evitar el lanzamiento de un ataque nuclear. Para ello, cuenta con un equipo de apoyo a distancia que le comunica vía códec información sobre la misión, comandada por el coronel Roy Campbell, y complementada por personal médico, de análisis de datos, expertos en armas y en supervivencia.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fps1_metal_gear_solid.jpg?alt=media&token=2c8648c0-1e24-45c0-bd8c-a1e53bbf866d'
      ),
      GameModel(
        title: 'Tekken 3', 
        consoleId: 3, 
        releaseYear: 1997, 
        genre: 'Lucha', 
        description: 'Tekken 3 es un videojuego de lucha desarrollado y publicado por Namco. Lanzado por primera vez en arcades en 1997 y posteriormente adaptado para la PlayStation en 1998, Tekken 3 es la tercera entrega de la serie Tekken y se considera uno de los mejores juegos de lucha de todos los tiempos.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fps1_tekken3.webp?alt=media&token=a9659a06-2e3b-4138-a61d-ea21b7b2dbca'
      ),
      GameModel(
        title: 'Final Fantasy VII', 
        consoleId: 3, 
        releaseYear: 1997, 
        genre: 'Aventura', 
        description: 'El argumento de Final Fantasy VII se centra en el protagonista Cloud Strife, un mercenario que inicialmente se une al grupo ecoterrorista AVALANCHA para detener el control mundial de la corporación Shinra que está drenando la vida del planeta para usarla como fuente de energía. Conforme la historia avanza, Cloud y sus aliados se ven envueltos en un conflicto que representa una amenaza aún mayor para el mundo, enfrentándose a Sefirot, el antagonista principal del juego.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fps1_ff_vii.jpg?alt=media&token=b8eab8fd-c5fc-4f32-a0d3-a929a535fa09'
      ),
      //N64
      GameModel(
        title: 'Star Fox 64', 
        consoleId: 5, 
        releaseYear: 1997, 
        genre: 'Disparos', 
        description: 'Star Fox 64 llamado en Europa y Australia Lylat Wars, es un videojuego scrolling shooter para Nintendo 64. Se vendió acompañado del accesorio "Rumble Pak", el cual hacía vibrar el mando, lo cual fue una novedad. En un principio, este juego iba a ser parte de la Star Fox 2 para Super Nintendo, pero Nintendo optó por desarrollar el juego para Nintendo 64, que sería lanzada en menos de un año.',
        imagePath: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fn64_star_fox.jpg?alt=media&token=8267dca1-3964-4318-8551-70bc61ecb098'
      ),
    ];

    final defaultVideos = [
      VideoModel(
        title: 'Tekken 3',
        consoleId: 3,
        description: 'Mira el trailer de Tekken 3',
        thumbnailUrl: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fps1_tekken3.webp?alt=media&token=a9659a06-2e3b-4138-a61d-ea21b7b2dbca',
        videoUrl: 'https://www.youtube.com/watch?v=IsvtUxEFQaU',
        duration: '1:37',
      ),
      VideoModel(
        title: 'Excitebike',
        consoleId: 1,
        description: 'Pequeño Gameplay de Excitebike',
        thumbnailUrl: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fnes_excitebike.jpg?alt=media&token=ebad084b-6145-43f6-9ecd-7afa6939f785',
        videoUrl: 'https://www.youtube.com/watch?v=b_YTqIAkQrc',
        duration: '1:06',
      ),
      VideoModel(
        title: 'Crash Bandicoot',
        consoleId: 3,
        description: 'Batalla de jefe Papu Papu',
        thumbnailUrl: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fps1_crash_bandicoot.webp?alt=media&token=56d9c9aa-0f52-4fa2-89d2-ee5e1e0ad5a8',
        videoUrl: 'https://www.youtube.com/watch?v=ryXyMycZq7I',
        duration: '0:40',
      ),
      VideoModel(
        title: 'Star Fox 64',
        consoleId: 5,
        description: 'Gameplay de nivel Solar en Star Fox 64',
        thumbnailUrl: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fn64_star_fox.jpg?alt=media&token=8267dca1-3964-4318-8551-70bc61ecb098',
        videoUrl: 'https://www.youtube.com/watch?v=41P87KmLjoE',
        duration: '5:13',
      ),
      VideoModel(
        title: 'Duck Hunt',
        consoleId: 1,
        description: 'Hecha un vista a este viejo gameplay de Duck Hunt, que recuerdos',
        thumbnailUrl: 'https://firebasestorage.googleapis.com/v0/b/retrogamesmuseum-53f2f.appspot.com/o/games%2Fnes_duck_hunt.jpg?alt=media&token=8ffedf6e-1734-4076-8768-d2c78fb8577c',
        videoUrl: 'https://www.youtube.com/watch?v=A78iNBzT8ug',
        duration: '2:58',
      )
    ];

    for (var console in defaultConsoles) {
      await db.insert(DatabaseConfig.consoleTable, console.toMap());
    }

    for (var game in defaultGames) {
      await db.insert(DatabaseConfig.gameTable, game.toMap());
    }

    for (var game in defaultVideos) {
      await db.insert(DatabaseConfig.videoTable, game.toMap());
    }
  }
}