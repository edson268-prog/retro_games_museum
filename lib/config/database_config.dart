class DatabaseConfig {
  static const String databaseName = 'retro_games.db';
  static const int databaseVersion = 1;
  
  static const String consoleTable = 'consoles';
  static const String gameTable = 'games';
  
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
}