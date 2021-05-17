class Skill {
  int id;
  String name;
  bool isValue = false;

  Skill({this.id, this.name, this.isValue});

  Skill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
}
