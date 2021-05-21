class Skill {
  int id;
  String name;
  bool isValue;

  Skill({this.id, this.name, this.isValue});

  Skill.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    isValue = true;
  }
  Skill.fromJsonNoValue(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    isValue = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  Skill copyWith({bool isValue, int id, String name}) {
    return Skill(
      isValue: isValue ?? this.isValue,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return '{id: $id, name: $name}';
  }
}
