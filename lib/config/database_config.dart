class DatabaseConfig {
  static const String databaseName = 'retro_games.db';
  static const int databaseVersion = 1;
  
  static const String consoleTable = 'consoles';
  static const String gameTable = 'games';
  static const String videoTable = 'videos';
  static const String productTable = 'products';
  static const String cartTable = 'cart';
  
  static const String createConsoleTable = '''
    CREATE TABLE $consoleTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      manufacturer TEXT NOT NULL,
      release_year INTEGER,
      description TEXT,
      format TEXT NOT NULL,
      image_path TEXT
    )
  ''';

  static const String createGameTable = '''
    CREATE TABLE $gameTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      console_id INTEGER,
      release_year INTEGER,
      genre TEXT,
      description TEXT,
      image_path TEXT,
      rating DOUBLE,
      FOREIGN KEY (console_id) REFERENCES $consoleTable (id)
    )
  ''';

  static const String createVideoTable = '''
    CREATE TABLE $videoTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      console_id INTEGER,
      description TEXT,
      thumbnail_url TEXT,
      video_url TEXT,
      duration TEXT,
      FOREIGN KEY (console_id) REFERENCES $consoleTable (id)
    )
  ''';

  static const String createProductTable = '''
    CREATE TABLE $productTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        imageUrl TEXT,
        stock INTEGER NOT NULL
    )
  ''';

  static const String createCartTable = '''
    CREATE TABLE cart(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (productId) REFERENCES products (id)
      )
  ''';
}