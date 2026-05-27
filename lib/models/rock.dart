class Rock {
  final int? id;
  final String name;
  final String type;
  final String color;
  final String hardness;
  final String description;
  final String imagePath;

  const Rock({
    this.id,
    required this.name,
    required this.type,
    required this.color,
    required this.hardness,
    required this.description,
    required this.imagePath,
  });

  Rock copyWith({
    int? id,
    String? name,
    String? type,
    String? color,
    String? hardness,
    String? description,
    String? imagePath,
  }) {
    return Rock(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      color: color ?? this.color,
      hardness: hardness ?? this.hardness,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'color': color,
      'hardness': hardness,
      'description': description,
      'image_path': imagePath,
    };
  }

  factory Rock.fromMap(Map<String, dynamic> map) {
    return Rock(
      id: map['id'] as int?,
      name: map['name'] as String? ?? 'Unknown',
      type: map['type'] as String? ?? 'Unknown',
      color: map['color'] as String? ?? 'Unknown',
      hardness: map['hardness'] as String? ?? 'Unknown',
      description: map['description'] as String? ?? '',
      imagePath: map['image_path'] as String? ?? '',
    );
  }
}
