class Fish {
  int? id;
  String? name;
  String? description;
  String? image;

  DateTime? createdAt;

  Fish(
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'created_at': createdAt,
      };

  factory Fish.fromJson(Map<String, dynamic> json) {
    return Fish(
      json['id'] as int,
      json['name'],
      json['description'],
      json['image'],
      DateTime.parse(json['created_at'].toString()),
    );
  }
}
