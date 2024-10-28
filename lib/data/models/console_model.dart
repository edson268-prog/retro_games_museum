class ConsoleModel {
  final int? id;
  final String name;
  final String manufacturer;
  final int releaseYear;
  final String description;
  final String format;
  final String imagePath;

  ConsoleModel({
    this.id,
    required this.name,
    required this.manufacturer,
    required this.releaseYear,
    required this.description,
    required this.format,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer,
      'release_year': releaseYear,
      'description': description,
      'format': format,
      'image_path': imagePath,
    };
  }

  factory ConsoleModel.fromMap(Map<String, dynamic> map) {
    return ConsoleModel(
      id: map['id'],
      name: map['name'],
      manufacturer: map['manufacturer'],
      releaseYear: map['release_year'],
      description: map['description'],
      format: map['format'],
      imagePath: map['image_path'],
    );
  }
}