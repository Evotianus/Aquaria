class Fish {
  int? id;
  String? name;
  String? description;
  String? image;

  Fish(
    this.id,
    this.name,
    this.description,
    this.image,
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
      };

  factory Fish.fromJson(Map<String, dynamic> json) {
    return Fish(
      json['id'],
      json['name'],
      json['description'],
      json['image'],
    );
  }
}
