class GameModel {
  final int? id;
  final String title;
  final int consoleId;
  final int releaseYear;
  final String genre;
  final String description;
  final String? imagePath;

  GameModel({
    this.id,
    required this.title,
    required this.consoleId,
    required this.releaseYear,
    required this.genre,
    required this.description,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'console_id': consoleId,
      'release_year': releaseYear,
      'genre': genre,
      'description': description,
      'image_path': imagePath,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'],
      title: map['title'],
      consoleId: map['console_id'],
      releaseYear: map['release_year'],
      genre: map['genre'],
      description: map['description'],
      imagePath: map['image_path'],
    );
  }
}