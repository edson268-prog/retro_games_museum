class SimpleConsoleModel {
  final int? id;
  final String name;

  SimpleConsoleModel({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SimpleConsoleModel.fromMap(Map<String, dynamic> map) {
    return SimpleConsoleModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}