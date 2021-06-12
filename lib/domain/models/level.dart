class Level {
  int id;
  String name;

  Level({this.id, this.name});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return 'id: $id, name: $name';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Level && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
